using BusinessLogicLayer.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
public class BlogPostController : ControllerBase
{
    private readonly IBlogPostService _blogPostService;
    public BlogPostController(IBlogPostService blogPostService)
    {
        _blogPostService = blogPostService;
    }
    
}