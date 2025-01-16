using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class ProductDao : IDao<Product>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public ProductDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<Product?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<Product?> CreateAsync(Product entity)
    {
        throw new NotImplementedException();
    }

    public async Task<Product?> UpdateAsync(Product entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Product>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<Product>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}