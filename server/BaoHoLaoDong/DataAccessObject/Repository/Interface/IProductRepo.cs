using BusinessObject.Entities;

namespace DataAccessObject.Repository.Interface;

public interface IProductRepo
{
    // categories methods
    Task<ProductCategory?> CreateCategoryAsync(ProductCategory category);
    Task<ProductCategory?> GetCategoryByIdAsync(int categoryId);
    Task<ProductCategory?> UpdateCategoryAsync(ProductCategory category);
    Task<List<ProductCategory>?> GetAllCategoriesAsync();
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
    Task<ProductVariant?> CreateProductVariantAsync(ProductVariant productVariant);
    Task<List<ProductVariant>?> GetAllVariantsAsync(int productId);
    Task<ProductVariant?> GetProductVariantByIdAsync(int variantId);
    Task<ProductVariant?> UpdateProductVariantAsync(ProductVariant productVariant);
    Task<ProductTaxis?> AddProductTaxAsync(ProductTaxis productTax);
    Task<ProductTaxis?> DeleteProductTaxAsync(int productTaxid);
}