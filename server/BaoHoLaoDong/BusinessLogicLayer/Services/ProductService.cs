using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository;
using DataAccessObject.Repository.Interface;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Formats.Jpeg;
using SixLabors.ImageSharp.Processing;

namespace BusinessLogicLayer.Services;

public class ProductService : IProductService
{
    private readonly IMapper _mapper;
    private readonly ILogger<ProductService> _logger;
    private readonly IProductRepo _productRepo;
    private readonly string _imageDirectoryProduct;

    public ProductService(MinhXuanDatabaseContext context, IMapper mapper, ILogger<ProductService> logger,
        string imageDirectoryProduct)
    {
        _productRepo = new ProductRepo(context);
        _mapper = mapper;
        _logger = logger;
        _imageDirectoryProduct = imageDirectoryProduct;
    }

    private async Task<string?> SaveImageAsync(IFormFile file)
    {
        try
        {
            if (!Directory.Exists(_imageDirectoryProduct))
            {
                Directory.CreateDirectory(_imageDirectoryProduct);
            }

            var uniqueFileName = Guid.NewGuid() + Path.GetExtension(file.FileName);
            var filePath = Path.Combine(_imageDirectoryProduct, uniqueFileName);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }

            return uniqueFileName;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error saving image.");
            return null;
        }
    }

    public async Task<CategoryResponse?> CreateNewCategory(NewCategory newCategory)
    {
        var category = _mapper.Map<Category>(newCategory);
        category = await _productRepo.CreateCategoryAsync(category);
        return _mapper.Map<CategoryResponse>(category);
    }

    public async Task<List<CategoryResponse>?> GetAllCategory()
    {
        var categories = await _productRepo.GetAllCategoriesAsync();
        return _mapper.Map<List<CategoryResponse>>(categories);
    }

    public async Task<List<ProductResponse>?> GetProductByPage(int category = 0, int page = 1, int pageSize = 20)
    {
        var products = await _productRepo.GetProductPageAsync(category, page, pageSize);
        return _mapper.Map<List<ProductResponse>>(products);
    }

    public async Task<CategoryResponse?> UpdateCategoryAsync(UpdateCategory updateCategory)
    {
        try
        {
            var category = await _productRepo.GetCategoryByIdAsync(updateCategory.CategoryId);
            if (category == null)
            {
                throw new Exception("Category not found.");
            }

            _mapper.Map(updateCategory, category);
            category = await _productRepo.UpdateCategoryAsync(category);
            return _mapper.Map<CategoryResponse>(category);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating category with ID: {CategoryId}", updateCategory.CategoryId);
            throw;
        }
    }

    public async Task<ProductResponse> CreateNewProductAsync(NewProduct newProduct)
    {
        try
        {
            var product = _mapper.Map<Product>(newProduct);
            product = await _productRepo.CreateProductAsync(product);

            var file = newProduct.File;
            if (file != null && file.Length > 0)
            {
                var fileName = await SaveImageAsync(file);
                if (fileName == null)
                {
                    throw new Exception("Failed to save product image. Product creation rolled back.");
                }

                product.ProductImages.Add(new ProductImage
                {
                    FileName = fileName,
                    IsPrimary = true,
                });

                product = await _productRepo.UpdateProductAsync(product);
            }

            return _mapper.Map<ProductResponse>(product);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating new product.");
            throw;
        }
    }

    public async Task<int> CountProductByCategory(int category)
    {
        return await _productRepo.CountProductByCategory(category);
    }

    public async Task<ProductResponse?> UpdateProductAsync(UpdateProduct updateProduct)
    {
        try
        {
            var product = await _productRepo.GetProductByIdAsync(updateProduct.ProductId);
            if (product == null)
            {
                throw new Exception("Product not found.");
            }

            _mapper.Map(updateProduct, product);
            product = await _productRepo.UpdateProductAsync(product);
            return _mapper.Map<ProductResponse>(product);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating product with ID: {ProductId}", updateProduct.ProductId);
            throw;
        }
    }

    public async Task<bool?> UpdateProductImageAsync(UpdateProductImage updateProductImage)
    {
        try
        {
            var productImage = await _productRepo.GetProductImageByIdAsync(updateProductImage.ProductImageId);
            if (productImage == null)
            {
                return false;
            }

            var file = updateProductImage.File;
            if (file != null && file.Length > 0)
            {
                var fileName = await SaveImageAsync(file);
                if (fileName == null)
                {
                    throw new Exception("Failed to save new product image.");
                }

                productImage.FileName = fileName;
                productImage.IsPrimary = updateProductImage.IsPrimary;
                var result = await _productRepo.UpdateProductImageAsync(productImage);
                return result != null;
            }

            return false;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating product image with ID: {ProductImageId}",
                updateProductImage.ProductImageId);
            throw;
        }
    }

    public async Task<bool?> DeleteImageAsync(int id)
    {
        try
        {
            var productImageExit = await _productRepo.GetProductImageByIdAsync(id);
            if (productImageExit != null)
            {
                var result =await _productRepo.DeleteProductImageAsync(id);
                var fileName = productImageExit.FileName;
                var oldFilePath = Path.Combine(_imageDirectoryProduct, fileName);
                if (File.Exists(oldFilePath) && result)
                {
                    File.Delete(oldFilePath);
                    return true;
                }
            }

            return false;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error delete image with ID: " + id);
            throw;
        }
    }

    public async Task<bool?> CreateNewProductImageAsync(NewProductImage productImage)
    {
        try
        {
            var productExit = await _productRepo.GetProductByIdAsync(productImage.ProductId);
            if (productExit == null) throw new Exception("Product not found");
            var file = productImage.File;
            if (file != null && file.Length > 0)
            {
                var fileName = await SaveImageAsync(file);
                var newProductImage = new ProductImage()
                {
                    ProductId = productExit.ProductId,
                    FileName = fileName,
                    IsPrimary = productImage.IsPrimary

                };
                newProductImage = await _productRepo.CreateProductImageAsync(newProductImage);
                return true;
            }

            return false;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex,"Error create new image");
            throw;
        }
    }
}
