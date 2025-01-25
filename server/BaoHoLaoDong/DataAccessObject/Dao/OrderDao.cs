using BusinessObject.Entities;
using Microsoft.EntityFrameworkCore;

namespace DataAccessObject.Dao;

public class OrderDao : IDao<Order>
{
    private readonly MinhXuanDatabaseContext _context;
    public OrderDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<List<Order>> GetAllOrdersAsync()
    {
        return await _context.Orders
            .Include(x => x.Customer)
            .Include(x => x.OrderDetails)
            .Include(x => x.Invoices)
            .ToListAsync();
    }

    public async Task<Order?> GetByIdAsync(int id)
    {
        return await _context.Orders

            .Include(x => x.Customer)
            .Include(x => x.OrderDetails)
            .Include(x => x.Invoices)
            .AsNoTracking()
            .FirstOrDefaultAsync(o => o.OrderId == id);
    }

    // Create a new Order
    public async Task<Order?> CreateAsync(Order entity)
    {
        await _context.Orders.AddAsync(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    // Update an existing Order
    public async Task<Order?> UpdateAsync(Order entity)
    {
        var existingOrder = await _context.Orders.FindAsync(entity.OrderId);
        if (existingOrder == null)
        {
            throw new ArgumentException("Order not found");
        }

        _context.Orders.Update(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    // Delete an Order by ID
    public async Task<bool> DeleteAsync(int id)
    {
        var order = await _context.Orders.FindAsync(id);
        if (order == null)
        {
            return false;
        }

        _context.Orders.Remove(order);
        await _context.SaveChangesAsync();
        return true;
    }

    // Get all Orders
    public async Task<List<Order>?> GetAllAsync()
    {
        return await _context.Orders

            .Include(order => order.Customer)
            .Include(order => order.OrderDetails)
            .Include(order => order.Invoices)
            .AsNoTracking()
            .ToListAsync();
    }

    // Get a page of Orders (pagination)
    public async Task<List<Order>?> GetPageAsync(int page, int pageSize)
    {
        return await _context.Orders
            .AsNoTracking()
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();
    }
}
