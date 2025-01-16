using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class BlogPostDao : IDao<BlogPost>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public BlogPostDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }
    
    public async Task<BlogPost?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<BlogPost?> CreateAsync(BlogPost entity)
    {
        throw new NotImplementedException();
    }

    public async Task<BlogPost?> UpdateAsync(BlogPost entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<BlogPost>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<BlogPost>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}