using BusinessObject.Entities;

namespace DataAccessObject.Dao;

public class ProductReviewDao : IDao<ProductReview>
{
    private readonly MinhXuanDatabaseContext _context;
    
    public ProductReviewDao(MinhXuanDatabaseContext context)
    {
        _context = context;
    }

    public async Task<ProductReview?> GetByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductReview?> CreateAsync(ProductReview entity)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductReview?> UpdateAsync(ProductReview entity)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<ProductReview>?> GetAllAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<List<ProductReview>?> GetPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}