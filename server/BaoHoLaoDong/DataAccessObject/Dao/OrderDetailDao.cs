using BusinessObject.Entities;
using Microsoft.EntityFrameworkCore;

namespace DataAccessObject.Dao;

public class OrderDetailDao : IDao<OrderDetail>
{
    private readonly MinhXuanDatabaseContext _context;

    public OrderDetailDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    // Get OrderDetail by ID
    public async Task<OrderDetail?> GetByIdAsync(int id)
    {
        return await _context.OrderDetails
            .AsNoTracking()
            .FirstOrDefaultAsync(od => od.OrderDetailId == id);
    }

    // Get OrderDetails by OrderId
    public async Task<List<OrderDetail>?> GetByOrderIdAsync(int orderId)
    {
        return await _context.OrderDetails
            .Where(od => od.OrderId == orderId)
            .AsNoTracking()
            .ToListAsync();
    }

    // Create a new OrderDetail
    public async Task<OrderDetail?> CreateAsync(OrderDetail entity)
    {
        await _context.OrderDetails.AddAsync(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    // Update an existing OrderDetail
    public async Task<OrderDetail?> UpdateAsync(OrderDetail entity)
    {
        var existingOrderDetail = await _context.OrderDetails.FindAsync(entity.OrderDetailId);
        if (existingOrderDetail == null)
        {
            throw new ArgumentException("OrderDetail not found");
        }

        _context.OrderDetails.Update(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    // Delete an OrderDetail by ID
    public async Task<bool> DeleteAsync(int id)
    {
        var orderDetail = await _context.OrderDetails.FindAsync(id);
        if (orderDetail == null)
        {
            return false;
        }

        _context.OrderDetails.Remove(orderDetail);
        await _context.SaveChangesAsync();
        return true;
    }

    // Get all OrderDetails
    public async Task<List<OrderDetail>?> GetAllAsync()
    {
        return await _context.OrderDetails
            .AsNoTracking()
            .ToListAsync();
    }

    // Get a page of OrderDetails (pagination)
    public async Task<List<OrderDetail>?> GetPageAsync(int page, int pageSize)
    {
        return await _context.OrderDetails
            .AsNoTracking()
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();
    }
}
