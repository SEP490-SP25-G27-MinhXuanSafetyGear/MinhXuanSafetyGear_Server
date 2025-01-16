using BusinessObject.Entities;
using Microsoft.EntityFrameworkCore;

namespace DataAccessObject.Dao;

public class EmployeeDao : IDao<Employee>
{
    private readonly MinhXuanDatabaseContext _context;
    public EmployeeDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<Employee?> GetByIdAsync(int id)
    {
        return await _context.Employees.FindAsync(id);
    }

    public async Task<Employee?> CreateAsync(Employee entity)
    {
        await _context.Employees.AddAsync(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    public async Task<Employee?> UpdateAsync(Employee entity)
    {
        _context.Entry(entity).State = EntityState.Modified;
        await _context.SaveChangesAsync();
        return entity;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Employee>?> GetAllAsync()
    {
        return await _context.Employees.ToListAsync();
    }

    public async Task<List<Employee>?> GetPageAsync(int page, int pageSize)
    {
        return await _context.Employees.Skip((page - 1) * pageSize).Take(pageSize).ToListAsync();
    }

    public async Task<Employee?> GetEmployeeByEmailAsync(string email)
    {
        return await _context.Employees.FirstOrDefaultAsync(e => e.Email == email);
    }
    
}