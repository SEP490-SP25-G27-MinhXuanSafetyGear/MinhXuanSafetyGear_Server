using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class CategoryDao : IDao<Category>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public CategoryDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<Category?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<Category?> CreateAsync(Category entity)
    {
        throw new NotImplementedException();
    }

    public async Task<Category?> UpdateAsync(Category entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Category>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<Category>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}