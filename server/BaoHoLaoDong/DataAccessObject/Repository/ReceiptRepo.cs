using DataAccessObject.Repository.Interface;
using BusinessObject.Entities;
using DataAccessObject.Dao;

namespace DataAccessObject.Repository
{
    public class ReceiptRepo : IReceiptRepo
    {
        private readonly ReceiptDao _receiptDao;

        public ReceiptRepo(MinhXuanDatabaseContext context)
        {
            _receiptDao = new ReceiptDao(context);
        }

        public async Task<Receipt?> GetReceiptByIdAsync(int id)
        {
            return await _receiptDao.GetByIdAsync(id);
        }

        public async Task<Receipt?> CreateReceiptAsync(Receipt receipt)
        {
            return await _receiptDao.CreateAsync(receipt);
        }

        public async Task<Receipt?> UpdateReceiptAsync(Receipt receipt)
        {
            return await _receiptDao.UpdateAsync(receipt);
        }

        public async Task<bool> DeleteReceiptAsync(int id)
        {
            return await _receiptDao.DeleteAsync(id);
        }

        public async Task<List<Receipt>?> GetAllReceiptsAsync()
        {
            return await _receiptDao.GetAllAsync();
        }

        public async Task<List<Receipt>?> GetReceiptsPageAsync(int page, int pageSize)
        {
            return await _receiptDao.GetPageAsync(page, pageSize);
        }
    }
}
