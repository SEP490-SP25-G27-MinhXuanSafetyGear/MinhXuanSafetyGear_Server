using BusinessLogicLayer.Hubs;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Models;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository.Interface;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
namespace BusinessLogicLayer.Services;

public class OrderQueueWorker : BackgroundService
{
    private readonly IServiceScopeFactory _serviceScopeFactory;
    private readonly ILogger<OrderQueueWorker> _logger;
    private readonly IHubContext<NotificationHub> _notificationHub;
    private readonly IHubContext<OrderHub> _orderHub;
    private readonly IHubContext<ProductHub> _productHub;

    public OrderQueueWorker(IServiceScopeFactory serviceScopeFactory, ILogger<OrderQueueWorker> logger,
        IHubContext<NotificationHub> notificationHub, IHubContext<OrderHub> orderHub,IHubContext<ProductHub> productHub
        )
    {
        _serviceScopeFactory = serviceScopeFactory;
        _notificationHub = notificationHub;
        _productHub = productHub;
        _orderHub = orderHub;
        _logger = logger;
    }
    
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("🚀 Order Queue Worker đang chạy...");
        var delayMilliseconds = 1000; // Bắt đầu với delay nhỏ
        while (!stoppingToken.IsCancellationRequested)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var services = scope.ServiceProvider;
                try
                {
                    var orderService = services.GetRequiredService<IOrderService>();
                    var notificationService = services.GetRequiredService<INotificationService>();
                    var mailService = services.GetRequiredService<IMailService>();
                    var orderQueueService = services.GetRequiredService<IOrderQueueService>();
                    var productService = services.GetRequiredService<IProductService>();
                    var userRepo = services.GetRequiredService<IUserRepo>();
                    try
                    {
                        var newOrder = await orderQueueService.DequeueOrder();
                        if (newOrder != null)
                        {
                            try
                            {
                                var createdOrder = await orderService.CreateNewOrderV2Async(newOrder);
                                if (createdOrder != null)
                                {
                                    orderQueueService.CompleteOrder(newOrder.TrackingId, createdOrder);
                                    try
                                    {
                                        var notification = new NewNotification
                                        {
                                            Title = "Đơn hàng mới cần xác minh",
                                            Message = $"Đơn hàng từ khách hàng {createdOrder.Email} được tạo mới với số tiền là {createdOrder.TotalAmount}",
                                            RecipientId = 1,
                                            RecipientType = RecipientType.Employee.ToString(),
                                            OrderId = createdOrder.OrderId
                                        };
                                        var notifi = await notificationService.CreateNewNotificationAsync(notification);
                                        await _notificationHub.Clients.Group(NotificationGroup.Employee.ToString())
                                            .SendAsync("ReceiveNotification", notifi, cancellationToken: stoppingToken);
                                    }
                                    catch (Exception ex)
                                    {
                                        _logger.LogError("Loi tao thong bao",ex.Message);
                                    }
                                    await _orderHub.Clients.All.SendAsync("NewOrderCreated", createdOrder, cancellationToken: stoppingToken);
                                    if (createdOrder.OrderDetails != null)
                                        foreach (var odl in createdOrder.OrderDetails)
                                        {
                                            var product = await productService.GetProductByIdAsync(odl.ProductId);
                                            await _productHub.Clients.All.SendAsync("ProductUpdated", product, cancellationToken: stoppingToken);
                                        } 
                                    
                                    await mailService.SendOrderConfirmationEmailAsync(createdOrder);

                                    _logger.LogInformation($"✅ Xử lý đơn hàng thành công của: {createdOrder.Email}");
                                }
                                else
                                {
                                    _logger.LogWarning($"⛔ Đơn hàng của {newOrder.CustomerEmail} thất bại do hết hàng!");
                                    // _ = Task.Run(() => mailService.SendOrderFailureEmailAsync(newOrder), stoppingToken);
                                }
                            }
                            catch (Exception ex)
                            {
                                _logger.LogError($"❌ Lỗi khi tạo đơn hàng: {ex.Message}");
                            }
                        }
                        else
                        {
                            _logger.LogInformation("⌛ Không có đơn hàng. Đang chờ...");
                            await Task.Delay(delayMilliseconds, stoppingToken);
                        }
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError($"❌ Lỗi khi xử lý hàng đợi đơn hàng: {ex.Message}");
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError($"❌ Lỗi khi lấy dịch vụ từ DI container: {ex.Message}");
                }
            }
        }
    }
}