using BusinessLogicLayer.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
public class ProducController : ControllerBase
{
    private readonly IProductService _productService;
    public ProducController(IProductService productService)
    {
        _productService = productService;
    }
}