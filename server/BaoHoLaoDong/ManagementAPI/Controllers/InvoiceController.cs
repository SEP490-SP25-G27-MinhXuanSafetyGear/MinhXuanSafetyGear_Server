using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Models;
using BusinessLogicLayer.Services.Interface;
using DataAccessObject.Repository.Interface;
using ManagementAPI.Hubs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;

using BusinessLogicLayer.Services.Interface;
using DataAccessObject.Repository.Interface;
using Microsoft.AspNetCore.Mvc;


namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
public class InvoiceController : ControllerBase
{
    private readonly IInvoiceService _invoiceService;
    private readonly IHubContext<InvoiceHub> _invoiceHub;

    public InvoiceController(IInvoiceService invoiceService, IHubContext<InvoiceHub> invoiceHub)
    {
        _invoiceService = invoiceService;
        _invoiceHub = invoiceHub;
    }
    [HttpPut("confirm-invoice-by-customer")]
    public async Task<IActionResult> ConfirmInvoiceByCustomer([FromQuery] ConfirmInvoice confirmInvoice)
    {
        try
        {
            var invoice = await _invoiceService.ConFirmInvoiceByCustomerAsync(confirmInvoice);
            await _invoiceHub.Clients.All.SendAsync("InvoiceConfirmedByCustomer", invoice);
            return Ok(invoice);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    [HttpPut("confirm-invoice-by-employee/{invoiceNo}/{status}")]
    public async Task<IActionResult> ConfirmInvoiceByEmployee([FromRoute] string invoiceNo, [FromRoute] string status)
    {
        try
        {
            if (status == "Confirmed")
            {
                status = "Completed";
            }
            else
            {
                status = "Canceled";
            }
            var invoice = await _invoiceService.ConFirmInvoiceByEmployeeAsync(invoiceNo, status);
            await _invoiceHub.Clients.All.SendAsync("InvoiceConfirmedByEmployee", invoiceNo, status);

            return Ok(invoice);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}

  