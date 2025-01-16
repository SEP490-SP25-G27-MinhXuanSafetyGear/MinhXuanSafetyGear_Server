using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class CustomerDao : IDao<Customer>
{
    private readonly MinhXuanDatabaseContext _context;
    public CustomerDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }
    public async Task<Customer?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<Customer?> CreateAsync(Customer entity)
    {
        throw new NotImplementedException();
    }

    public async Task<Customer?> UpdateAsync(Customer entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Customer>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<Customer>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}