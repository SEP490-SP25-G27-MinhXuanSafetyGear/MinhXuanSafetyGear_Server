using BusinessObject.Entities;

namespace DataAccessObject.Repository.Interface
{
    public interface IInvoiceRepo
    {
        Task<Invoice?> GetReceiptByIdAsync(int id);
        Task<Invoice?> CreateReceiptAsync(Invoice invoice);
        Task<Invoice?> UpdateReceiptAsync(Invoice invoice);
        Task<bool> DeleteReceiptAsync(int id);
        Task<List<Invoice>?> GetAllReceiptsAsync();
        Task<List<Invoice>?> GetReceiptsPageAsync(int page, int pageSize);
    }
}
