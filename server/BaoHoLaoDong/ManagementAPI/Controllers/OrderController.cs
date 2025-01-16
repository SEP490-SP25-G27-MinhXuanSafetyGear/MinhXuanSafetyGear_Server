using BusinessLogicLayer.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
public class OrderController : ControllerBase
{
    private readonly IOrderService _orderService;
    public OrderController(IOrderService orderService)
    {
        _orderService = orderService;
    }
}