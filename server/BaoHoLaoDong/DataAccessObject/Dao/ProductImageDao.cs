using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class ProductImageDao : IDao<ProductImage>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public ProductImageDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<ProductImage?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductImage?> CreateAsync(ProductImage entity)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductImage?> UpdateAsync(ProductImage entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<ProductImage>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<ProductImage>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}