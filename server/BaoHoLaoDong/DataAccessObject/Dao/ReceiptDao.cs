using BusinessObject.Entities;
using Microsoft.EntityFrameworkCore;

namespace DataAccessObject.Dao;

public class ReceiptDao : IDao<Receipt>
{
    private readonly MinhXuanDatabaseContext _context;

    public ReceiptDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    // Get Receipt by ID
    public async Task<Receipt?> GetByIdAsync(int id)
    {
        return await _context.Receipts
            .AsNoTracking()
            .FirstOrDefaultAsync(r => r.ReceiptId == id);
    }

    // Create a new Receipt
    public async Task<Receipt?> CreateAsync(Receipt entity)
    {
        await _context.Receipts.AddAsync(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    // Update an existing Receipt
    public async Task<Receipt?> UpdateAsync(Receipt entity)
    {
        var existingReceipt = await _context.Receipts.FindAsync(entity.ReceiptId);
        if (existingReceipt == null)
        {
            throw new ArgumentException("Receipt not found");
        }

        _context.Receipts.Update(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    // Delete a Receipt by ID
    public async Task<bool> DeleteAsync(int id)
    {
        var receipt = await _context.Receipts.FindAsync(id);
        if (receipt == null)
        {
            return false;
        }

        _context.Receipts.Remove(receipt);
        await _context.SaveChangesAsync();
        return true;
    }

    // Get all Receipts
    public async Task<List<Receipt>?> GetAllAsync()
    {
        return await _context.Receipts
            .AsNoTracking()
            .ToListAsync();
    }

    // Get a page of Receipts (pagination)
    public async Task<List<Receipt>?> GetPageAsync(int page, int pageSize)
    {
        return await _context.Receipts
            .AsNoTracking()
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();
    }
}
