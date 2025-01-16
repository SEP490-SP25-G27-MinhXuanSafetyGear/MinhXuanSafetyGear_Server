using BusinessObject.Entities;
using DataAccessObject.Repository.Interface;

namespace DataAccessObject.Repository;

public class ProductRepo : IProductRepo 
{
    public async Task<Category?> CreateCategoryAsync(Category category)
    {
        throw new NotImplementedException();
    }

    public async Task<Category?> GetCategoryByIdAsync(int categoryId)
    {
        throw new NotImplementedException();
    }

    public async Task<Category?> UpdateCategoryAsync(Category category)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Category>?> GetAllCategoriesAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<Product?> CreateProductAsync(Product product)
    {
        throw new NotImplementedException();
    }

    public async Task<Product?> GetProductByIdAsync(int productId)
    {
        throw new NotImplementedException();
    }

    public async Task<Product?> UpdateProductAsync(Product product)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Product>?> GetAllProductsAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<ProductImage?> CreateProductImageAsync(ProductImage productImage)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductImage?> GetProductImageByIdAsync(int productImageId)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductImage?> UpdateProductImageAsync(ProductImage productImage)
    {
        throw new NotImplementedException();
    }

    public async Task<List<ProductImage>?> GetAllProductImagesAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteProductImageAsync(int productImageId)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductReview?> CreateProductReviewAsync(ProductReview productReview)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductReview?> GetProductReviewByIdAsync(int productReviewId)
    {
        throw new NotImplementedException();
    }

    public async Task<ProductReview?> UpdateProductReviewAsync(ProductReview productReview)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteProductReviewAsync(int productReviewId)
    {
        throw new NotImplementedException();
    }

    public async Task<List<ProductReview>?> GetProductReviewsAsync(int productId)
    {
        throw new NotImplementedException();
    }

    public async Task<List<ProductReview>?> GetProductReviewsPageAsync(int productId, int page, int pageSize)
    {
        throw new NotImplementedException();
    }
}