using BusinessObject.Entities;

namespace DataAccessObject.Repository.Interface
{
    public interface IInvoiceRepo
    {
        Task<Invoice?> GetInvoiceByIdAsync(int id);
        Task<Invoice?> CreateInvoiceAsync(Invoice receipt);
        Task<Invoice?> UpdateInvoiceAsync(Invoice receipt);
        Task<bool> DeleteInvoiceAsync(int id);
        Task<List<Invoice>?> GetAllInvoicesAsync();
        Task<List<Invoice>?> GetInvoicesPageAsync(int page, int pageSize);
    }
}
