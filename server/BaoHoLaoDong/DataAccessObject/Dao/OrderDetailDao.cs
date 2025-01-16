using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class OrderDetailDao : IDao<OrderDetail>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public OrderDetailDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<OrderDetail?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<OrderDetail?> CreateAsync(OrderDetail entity)
    {
        throw new NotImplementedException();
    }

    public async Task<OrderDetail?> UpdateAsync(OrderDetail entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<OrderDetail>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<OrderDetail>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}