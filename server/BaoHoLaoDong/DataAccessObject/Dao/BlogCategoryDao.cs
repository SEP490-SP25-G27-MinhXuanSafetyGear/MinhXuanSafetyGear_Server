using BusinessObject.Entities;
using Microsoft.EntityFrameworkCore;

namespace DataAccessObject.Dao;

public class BlogCategoryDao : IDao<BlogCategory>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public BlogCategoryDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }
    
    public async Task<BlogCategory?> GetByIdAsync(int id)
    {
        return await _context.BlogCategories.AsNoTracking().FirstOrDefaultAsync(c=>c.CategoryId == id);
    }

    public async Task<BlogCategory?> CreateAsync(BlogCategory entity)
    {
        await _context.BlogCategories.AddAsync(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    public async Task<BlogCategory?> UpdateAsync(BlogCategory entity)
    {
        _context.Entry(entity).State = EntityState.Modified;
        await _context.SaveChangesAsync();
        return entity;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        var entity = await GetByIdAsync(id);
        if (entity == null)
        {
            return false;
        }
        _context.BlogCategories.Remove(entity);
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<List<BlogCategory>?> GetAllAsync()
    {
        return await _context.BlogCategories.AsNoTracking().ToListAsync();
    }

    public async Task<List<BlogCategory>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}