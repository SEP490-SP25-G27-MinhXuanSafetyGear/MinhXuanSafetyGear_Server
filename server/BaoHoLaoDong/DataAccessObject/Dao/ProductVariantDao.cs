using BusinessObject.Entities;
using Microsoft.EntityFrameworkCore;
namespace DataAccessObject.Dao
{
    public class ProductVariantDao : IDao<ProductVariant>
    {
        private readonly MinhXuanDatabaseContext _context;

        public ProductVariantDao(MinhXuanDatabaseContext context)
        {
            _context = context;
        }

        // Get ProductVariant by ID
        public async Task<ProductVariant?> GetByIdAsync(int id)
        {
            return await _context.ProductVariants
                .Include(pv => pv.Product)
                .AsNoTracking()
                .FirstOrDefaultAsync(pv => pv.VariantId == id);
        }

        // Get ProductVariant by ProductId
        public async Task<List<ProductVariant>?> GetByProductIdAsync(int productId)
        {
            return await _context.ProductVariants
                .Where(pv => pv.ProductId == productId)
                .Include(pv => pv.Product)
                .AsNoTracking()
                .ToListAsync();
        }

        // Create a new ProductVariant
        public async Task<ProductVariant?> CreateAsync(ProductVariant entity)
        {
            await _context.ProductVariants.AddAsync(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        // Update an existing ProductVariant
        public async Task<ProductVariant?> UpdateAsync(ProductVariant entity)
        {
            var existingVariant = await _context.ProductVariants
                .AsNoTracking()
                .FirstOrDefaultAsync(pv => pv.VariantId == entity.VariantId);
            if (existingVariant == null)
            {
                throw new ArgumentException("ProductVariant not found");
            }
            _context.Entry(entity).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return entity;
        }

        // Delete a ProductVariant by ID
        public async Task<bool> DeleteAsync(int id)
        {
            var variant = await _context.ProductVariants.FindAsync(id);
            if (variant == null)
            {
                return false;
            }

            _context.ProductVariants.Remove(variant);
            await _context.SaveChangesAsync();
            return true;
        }

        // Get all ProductVariants
        public async Task<List<ProductVariant>?> GetAllAsync()
        {
            return await _context.ProductVariants
                .Include(pv => pv.Product)
                .AsNoTracking()
                .ToListAsync();
        }

        // Get a page of ProductVariants (pagination)
        public async Task<List<ProductVariant>?> GetPageAsync(int page, int pageSize)
        {
            return await _context.ProductVariants
                .AsNoTracking()
                .Include(pv => pv.Product)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
        }

        public async Task<List<ProductVariant>?> GetPageByProductIdAsync(int productId, int page, int pageSize)
        {
            return await _context.ProductVariants
                .AsNoTracking()
                .Where(pv => pv.ProductId == productId)
                .Include(pv => pv.Product)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
        }

        // Count ProductVariants by ProductId
        public async Task<int> CountProductVariantsByProductIdAsync(int productId)
        {
            return await _context.ProductVariants.CountAsync(pv => pv.ProductId == productId);
        }
    }
}
