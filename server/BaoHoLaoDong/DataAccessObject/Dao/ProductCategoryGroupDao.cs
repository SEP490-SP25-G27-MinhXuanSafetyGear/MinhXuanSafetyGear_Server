using BusinessObject.Entities;
using Microsoft.EntityFrameworkCore;

namespace DataAccessObject.Dao;

public class ProductCategoryGroupDao
{
    private readonly MinhXuanDatabaseContext _context;

    public ProductCategoryGroupDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }
    public async Task<List<ProductCategoryGroup>?> GetAllAsync()
    {
        return await _context.ProductCategoryGroups
            .AsNoTracking()
            .Include(p => p.ProductCategories)
            .ToListAsync();
    }
}