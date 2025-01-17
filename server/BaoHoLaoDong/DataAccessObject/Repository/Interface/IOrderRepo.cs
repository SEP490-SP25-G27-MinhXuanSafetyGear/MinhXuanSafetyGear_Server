using BusinessObject.Entities;

namespace DataAccessObject.Repository.Interface
{
    public interface IOrderRepo
    {
        //Order
        Task<Order?> GetOrderByIdAsync(int id);
        Task<Order?> CreateOrderAsync(Order order);
        Task<Order?> UpdateOrderAsync(Order order);
        Task<bool> DeleteOrderAsync(int id);
        Task<List<Order>?> GetAllOrdersAsync();
        Task<List<Order>?> GetOrdersPageAsync(int page, int pageSize);

        //OrderDetail
        Task<OrderDetail?> GetOrderDetailByIdAsync(int orderDetailId);
        Task<OrderDetail?> CreateOrderDetailAsync(OrderDetail orderDetail);
        Task<OrderDetail?> UpdateOrderDetailAsync(OrderDetail orderDetail);
        Task<bool> DeleteOrderDetailAsync(int orderDetailId);
        Task<List<OrderDetail>?> GetOrderDetailsByOrderIdAsync(int orderId);
    }
}
