using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository;
using DataAccessObject.Repository.Interface;
using Microsoft.Extensions.Logging;

namespace BusinessLogicLayer.Services;

public class InvoiceService : IInvoiceService
{
    private readonly IInvoiceRepo _invoiceRepo;
    private readonly IFileService _fileService;
    private readonly IMapper _mapper;
    private readonly ILogger<InvoiceService> _logger;
    private readonly string _imagePathBill = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot","Images", "bill");

    public InvoiceService(MinhXuanDatabaseContext context, IFileService fileService, IMapper mapper, ILogger<InvoiceService> logger)
    {
        _invoiceRepo = new InvoiceRepo(context);
        _fileService = fileService;
        _mapper = mapper;
        _logger = logger;
    }
    public async Task<InvoiceResponse?> ConFirmInvoiceByCustomerAsync(ConfirmInvoice confirmInvoice)
    {
        try
        {
            var invoice = await _invoiceRepo.GetInvoiceByNumberAsync(confirmInvoice.InvoiceNumber);
            if(invoice == null) { return null; }

            var fileBill = confirmInvoice.File;
            if (fileBill != null)
            {
                var fileName = invoice.InvoiceNumber + ".pdf";
                if (!string.IsNullOrEmpty(fileName))
                {
                    invoice.FileName = await _fileService.SaveFileBillAsync(_imagePathBill,fileBill,fileName);
                }
            }

            invoice.PaymentConfirmOfCustomer = true;
            invoice.PaymentDate = DateTime.Now;
            invoice = await _invoiceRepo.UpdateInvoiceAsync(invoice);
            if(invoice == null) { return null; }
            return _mapper.Map<InvoiceResponse>(invoice);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating order.");
            throw;
        }
    }

    public async Task<InvoiceResponse?> ConFirmInvoiceByEmployeeAsync(string invoiceNo,string status)
    {
        try
        {
            var invoice = await _invoiceRepo.GetInvoiceByNumberAsync(invoiceNo);
            if(invoice == null) { return null; }

            invoice.PaymentConfirmOfCustomer = true;
            invoice.PaymentDate = DateTime.Now;
            invoice.PaymentStatus = status;
            invoice.Order.Status = status;
            invoice.Order.UpdatedAt = DateTime.Now;
            invoice = await _invoiceRepo.UpdateInvoiceAsync(invoice);
            if(invoice == null) { return null; }
            return _mapper.Map<InvoiceResponse>(invoice);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating order.");
            throw;
        }
    }
}