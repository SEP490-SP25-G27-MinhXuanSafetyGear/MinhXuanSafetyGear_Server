using BusinessLogicLayer.Mappings.ResponseDTO;
using Microsoft.AspNetCore.SignalR;

namespace ManagementAPI.Hubs;

public class ProductHub : Hub
{
    // Khi một sản phẩm mới được thêm vào
    public async Task SendProductAdded(ProductResponse product)
    {
        await Clients.All.SendAsync("ProductAdded", product);
    }

    // Khi một sản phẩm được cập nhật
    public async Task SendProductUpdated(ProductResponse product)
    {
        await Clients.All.SendAsync("ProductUpdated", product);
    }

    // Khi một sản phẩm bị xóa
    public async Task SendProductDeleted(int productId)
    {
        await Clients.All.SendAsync("ProductDeleted", productId);
    }

    public async Task SendProductCategoryAdded(int categoryId)
    {
        await Clients.All.SendAsync("ProductCategoryAdded",categoryId);
    }
    public async Task SendProductCategoryUpdated(int categoryId)
    {
        await Clients.All.SendAsync("ProductCategoryUpdated",categoryId);
    }
}