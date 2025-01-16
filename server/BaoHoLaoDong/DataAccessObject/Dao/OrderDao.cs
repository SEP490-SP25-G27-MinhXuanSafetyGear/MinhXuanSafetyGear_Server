using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class OrderDao : IDao<Order>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public OrderDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<Order?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<Order?> CreateAsync(Order entity)
    {
        throw new NotImplementedException();
    }

    public async Task<Order?> UpdateAsync(Order entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Order>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<Order>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}