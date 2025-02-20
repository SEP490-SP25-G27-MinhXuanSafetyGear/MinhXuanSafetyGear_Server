using BusinessLogicLayer.Mappings.ResponseDTO;
using Microsoft.AspNetCore.SignalR;

namespace ManagementAPI.Hubs
{
    public class BlogHub : Hub
    {
        public async Task SendBlogAdded(BlogPostResponse blogs)
        {
            await Clients.All.SendAsync("BlogAdded", blogs);
        }
        public async Task SendBlogUpdated(BlogPostResponse blogs)
        {
            await Clients.All.SendAsync("BlogUpdated", blogs);
        }
        public async Task SendBlogDeleted(BlogPostResponse blogs)
        {
            await Clients.All.SendAsync("BlogDeleted", blogs);
        }
    }
}
