using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class ReceiptDao : IDao<Receipt>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public ReceiptDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<Receipt?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<Receipt?> CreateAsync(Receipt entity)
    {
        throw new NotImplementedException();
    }

    public async Task<Receipt?> UpdateAsync(Receipt entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Receipt>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<Receipt>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}