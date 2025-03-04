using BusinessLogicLayer.Mappings.ResponseDTO;
using Microsoft.AspNetCore.SignalR;

namespace ManagementAPI.Hubs
{
    public class OrderHub : Hub
    {
        public async Task SendOrderAdded(OrderResponse order)
        {
            await Clients.All.SendAsync("OrderAdded", order);
        }
        public async Task SendOrderUpdated(OrderResponse order)
        {
            await Clients.All.SendAsync("OrderUpdated", order);
        }
        public async Task SendOrderDeleted(OrderResponse order)
        {
            await Clients.All.SendAsync("OrderDeleted", order);
        }
    }
}
