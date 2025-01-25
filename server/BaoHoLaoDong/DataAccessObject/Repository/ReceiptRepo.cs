using DataAccessObject.Repository.Interface;
using BusinessObject.Entities;
using DataAccessObject.Dao;

namespace DataAccessObject.Repository
{
    public class InvoceRepo : IInvoiceRepo
    {
        private readonly InvoiceDao _invoiceDao;

        public InvoceRepo(MinhXuanDatabaseContext context)
        {
            _invoiceDao = new InvoiceDao(context);
        }

        public async Task<Invoice?> GetReceiptByIdAsync(int id)
        {
            return await _invoiceDao.GetByIdAsync(id);
        }

        public async Task<Invoice?> CreateReceiptAsync(Invoice invoice)
        {
            return await _invoiceDao.CreateAsync(invoice);
        }

        public async Task<Invoice?> UpdateReceiptAsync(Invoice invoice)
        {
            return await _invoiceDao.UpdateAsync(invoice);
        }

        public async Task<bool> DeleteReceiptAsync(int id)
        {
            return await _invoiceDao.DeleteAsync(id);
        }

        public async Task<List<Invoice>?> GetAllReceiptsAsync()
        {
            return await _invoiceDao.GetAllAsync();
        }

        public async Task<List<Invoice>?> GetReceiptsPageAsync(int page, int pageSize)
        {
            return await _invoiceDao.GetPageAsync(page, pageSize);
        }
    }
}
