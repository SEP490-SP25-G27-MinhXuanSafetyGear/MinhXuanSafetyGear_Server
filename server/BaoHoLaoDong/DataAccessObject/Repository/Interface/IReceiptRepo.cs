using BusinessObject.Entities;

namespace DataAccessObject.Repository.Interface
{
    public interface IReceiptRepo
    {
        Task<Receipt?> GetReceiptByIdAsync(int id);
        Task<Receipt?> CreateReceiptAsync(Receipt receipt);
        Task<Receipt?> UpdateReceiptAsync(Receipt receipt);
        Task<bool> DeleteReceiptAsync(int id);
        Task<List<Receipt>?> GetAllReceiptsAsync();
        Task<List<Receipt>?> GetReceiptsPageAsync(int page, int pageSize);
    }
}
