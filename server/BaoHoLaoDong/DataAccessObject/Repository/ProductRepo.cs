using BusinessObject.Entities;
using DataAccessObject.Dao;
using DataAccessObject.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DataAccessObject.Repository
{
    public class ProductRepo : IProductRepo
    {
        private readonly CategoryDao _categoryDao;
        private readonly ProductDao _productDao;
        private readonly ProductImageDao _productImageDao;
        private readonly ProductReviewDao _productReviewDao;

        public ProductRepo(MinhXuanDatabaseContext context)
        {
            _categoryDao = new CategoryDao(context);
            _productDao = new ProductDao(context);
            _productImageDao = new ProductImageDao(context);
            _productReviewDao = new ProductReviewDao(context);
        }

        #region Category

        public async Task<Category?> CreateCategoryAsync(Category category)
        {
            var existingCategory = await _categoryDao.GetByNameAsync(category.CategoryName);
            if (existingCategory != null)
            {
                throw new ArgumentException("Category with this name already exists.");
            }
            return await _categoryDao.CreateAsync(category);
        }

        public async Task<Category?> GetCategoryByIdAsync(int categoryId)
        {
            return await _categoryDao.GetByIdAsync(categoryId);
        }

        public async Task<Category?> UpdateCategoryAsync(Category category)
        {
            var existingCategory = await _categoryDao.GetByIdAsync(category.CategoryId);
            if (existingCategory == null)
            {
                throw new ArgumentException("Category not found.");
            }
            return await _categoryDao.UpdateAsync(category);
        }

        public async Task<List<Category>?> GetAllCategoriesAsync()
        {
            return await _categoryDao.GetAllAsync();
        }

        #endregion Category

        #region Product

        public async Task<Product?> CreateProductAsync(Product product)
        {
            var existingProduct = await _productDao.GetByNameAsync(product.ProductName);
            if (existingProduct != null)
            {
                throw new ArgumentException("Product with this name already exists.");
            }
            return await _productDao.CreateAsync(product);
        }

        public async Task<Product?> GetProductByIdAsync(int productId)
        {
            return await _productDao.GetByIdAsync(productId);
        }

        public async Task<Product?> UpdateProductAsync(Product product)
        {
            var existingProduct = await _productDao.GetByIdAsync(product.ProductId);
            if (existingProduct == null)
            {
                throw new ArgumentException("Product not found.");
            }
            product.UpdatedAt = DateTime.Now;
            return await _productDao.UpdateAsync(product);
        }

        public async Task<List<Product>?> GetAllProductsAsync()
        {
            return await _productDao.GetAllAsync();
        }

        public async Task<List<Product>?> GetProductPageAsync(int category, int page, int pageSize)
        {
            return await _productDao.GetPageAsync(category,page,pageSize);
        }

        #endregion Product

        #region ProductImage

        public async Task<ProductImage?> CreateProductImageAsync(ProductImage productImage)
        {
            return await _productImageDao.CreateAsync(productImage);
        }

        public async Task<ProductImage?> GetProductImageByIdAsync(int productImageId)
        {
            return await _productImageDao.GetByIdAsync(productImageId);
        }

        public async Task<ProductImage?> UpdateProductImageAsync(ProductImage productImage)
        {
            var existingProductImage = await _productImageDao.GetByIdAsync(productImage.ProductImageId);
            if (existingProductImage == null)
            {
                throw new ArgumentException("Product image not found.");
            }

            productImage.UpdatedAt = DateTime.Now;
            return await _productImageDao.UpdateAsync(productImage);
        }

        public async Task<List<ProductImage>?> GetAllProductImagesAsync()
        {
            return await _productImageDao.GetAllAsync();
        }

        public async Task<bool> DeleteProductImageAsync(int productImageId)
        {
            var productImage = await _productImageDao.GetByIdAsync(productImageId);
            if (productImage != null)
            {
                await _productImageDao.DeleteAsync(productImageId);
                return true;
            }
            return false;
        }

        #endregion ProductImage

        #region ProductReview

        public async Task<ProductReview?> CreateProductReviewAsync(ProductReview productReview)
        {
            return await _productReviewDao.CreateAsync(productReview);
        }

        public async Task<ProductReview?> GetProductReviewByIdAsync(int productReviewId)
        {
            return await _productReviewDao.GetByIdAsync(productReviewId);
        }

        public async Task<ProductReview?> UpdateProductReviewAsync(ProductReview productReview)
        {
            var existingProductReview = await _productReviewDao.GetByIdAsync(productReview.ReviewId);
            if (existingProductReview == null)
            {
                throw new ArgumentException("Product review not found.");
            }
            return await _productReviewDao.UpdateAsync(productReview);
        }

        public async Task<bool> DeleteProductReviewAsync(int productReviewId)
        {
            var productReview = await _productReviewDao.GetByIdAsync(productReviewId);
            if (productReview != null)
            {
                await _productReviewDao.DeleteAsync(productReviewId);
                return true;
            }
            return false;
        }

        public async Task<List<ProductReview>?> GetProductReviewsAsync(int productId)
        {
            return await _productReviewDao.GetByProductIdAsync(productId);
        }

        public async Task<List<ProductReview>?> GetProductReviewsPageAsync(int productId, int page, int pageSize)
        {
            var reviews = await _productReviewDao.GetByProductIdAsync(productId);
            return reviews.Skip((page - 1) * pageSize).Take(pageSize).ToList();
        }

        public async Task<int> CountProductByCategory(int category)
        {
            return await _productDao.CountProductByCategory(category);
        }

        #endregion ProductReview
    }
}
