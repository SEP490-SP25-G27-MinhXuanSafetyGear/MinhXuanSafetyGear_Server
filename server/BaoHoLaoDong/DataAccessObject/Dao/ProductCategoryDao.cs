using BusinessObject.Entities;
using Microsoft.EntityFrameworkCore;

namespace DataAccessObject.Dao;

public class ProductCategoryDao : IDao<Category>
{
    private readonly MinhXuanDatabaseContext _context;

    public ProductCategoryDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    // Get Category by ID
    public async Task<Category?> GetByIdAsync(int id)
    {
        return await _context.Categories
            .AsNoTracking()
            .FirstOrDefaultAsync(c => c.CategoryId == id);
    }
    public async Task<Category?> GetByNameAsync(string categoryName)
    {
        return await _context.Categories
                             .FirstOrDefaultAsync(c => c.CategoryName.Equals(categoryName));
    }
    // Create a new Category
    public async Task<Category?> CreateAsync(Category entity)
    {
        await _context.Categories.AddAsync(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    // Update an existing Category
    public async Task<Category?> UpdateAsync(Category entity)
    {
        _context.Entry(entity).State = EntityState.Modified;
        await _context.SaveChangesAsync();
        return entity;
    }

    // Delete a Category by ID
    public async Task<bool> DeleteAsync(int id)
    {
        var category = await _context.Categories.FindAsync(id);
        if (category == null)
        {
            return false;
        }

        _context.Categories.Remove(category);
        await _context.SaveChangesAsync();
        return true;
    }

    // Get all Categories
    public async Task<List<Category>?> GetAllAsync()
    {
        return await _context.Categories
            .AsNoTracking()
            .ToListAsync();
    }

    // Get a page of Categories (pagination)
    public async Task<List<Category>?> GetPageAsync(int page, int pageSize)
    {
        return await _context.Categories
            .AsNoTracking()
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();
    }
}
