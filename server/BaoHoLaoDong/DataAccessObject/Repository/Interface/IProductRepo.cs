using BusinessObject.Entities;

namespace DataAccessObject.Repository.Interface;

public interface IProductRepo
{
    // categories methods
    Task<Category?> CreateCategoryAsync(Category category);
    Task<Category?> GetCategoryByIdAsync(int categoryId);
    Task<Category?> UpdateCategoryAsync(Category category);
    Task<List<Category>?> GetAllCategoriesAsync();
    // products methods
    Task<Product?> CreateProductAsync(Product product);
    Task<Product?> GetProductByIdAsync(int productId);
    Task<Product?> UpdateProductAsync(Product product);
    Task<List<Product>?> GetAllProductsAsync();

    Task<List<Product>?> GetProductPageAsync(int category, int page, int pageSize);
    // productimages methods
    Task<ProductImage?> CreateProductImageAsync(ProductImage productImage);
    Task<ProductImage?> GetProductImageByIdAsync(int productImageId);
    Task<ProductImage?> UpdateProductImageAsync(ProductImage productImage);
    Task<List<ProductImage>?> GetAllProductImagesAsync();
    Task<bool> DeleteProductImageAsync(int productImageId);
    // productreviews methods
    Task<ProductReview?> CreateProductReviewAsync(ProductReview productReview);
    Task<ProductReview?> GetProductReviewByIdAsync(int productReviewId);
    Task<ProductReview?> UpdateProductReviewAsync(ProductReview productReview);
    Task<bool> DeleteProductReviewAsync(int productReviewId);
    Task<List<ProductReview>?> GetProductReviewsAsync(int productId);
    Task<List<ProductReview>?> GetProductReviewsPageAsync(int productId, int page, int pageSize);
    Task<int> CountProductByCategory(int category);
}