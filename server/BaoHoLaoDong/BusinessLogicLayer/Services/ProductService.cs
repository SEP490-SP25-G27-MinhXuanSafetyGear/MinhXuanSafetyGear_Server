
using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Models;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository;
using DataAccessObject.Repository.Interface;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace BusinessLogicLayer.Services;

public class ProductService : IProductService
{
    private readonly IMapper _mapper;
    private readonly ILogger<ProductService> _logger;
    private readonly IProductRepo _productRepo;
    private readonly string _imageDirectory;

    public ProductService(MinhXuanDatabaseContext context, IMapper mapper, ILogger<ProductService> logger,
        string imageDirectory)
    {
        _productRepo = new ProductRepo(context);
        _mapper = mapper;
        _logger = logger;
        _imageDirectory = imageDirectory;
    }

    // Method to generate unique filename using product name and GUID
    private string GenerateFileNameWithGuid(string productName, string originalFileName)
    {
        var fileExtension = Path.GetExtension(originalFileName);
        var cleanProductName = productName.Replace(" ", "_");  // Optional: Clean the name (remove spaces, etc.)
        return $"{cleanProductName}_{Guid.NewGuid()}{fileExtension}";
    }

    // Method to save image file and return its file name
    private async Task<string?> SaveImageAsync(IFormFile file, string? productName = null)
    {
        try
        {
            if (!Directory.Exists(_imageDirectory))
            {
                Directory.CreateDirectory(_imageDirectory);
            }

            var fileName = productName != null
                ? GenerateFileNameWithGuid(productName, file.FileName)  // Generate a unique file name based on product name
                : Guid.NewGuid() + Path.GetExtension(file.FileName);    // Generate a GUID-based file name

            var filePath = Path.Combine(_imageDirectory, fileName);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
                _logger.LogInformation($"Image saved to {_imageDirectory}");
            }

            return fileName;
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

    public async Task<Page<ProductResponse>?> GetProductByPage(int category = 0, int page = 1, int pageSize = 20)
    {
        var products = await _productRepo.GetProductPageAsync(category, page, pageSize);
        var totalProduct = await _productRepo.CountProductByCategory(category);
        var productsResponse = _mapper.Map<List<ProductResponse>>(products);
        var pageResult = new Page<ProductResponse>(productsResponse, page, pageSize, totalProduct);
        return pageResult;
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
                var fileName = await SaveImageAsync(file, product.ProductName);
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
    IFormFile file = null;
    string? oldPath = null;
    string? fileName = null;
    try
    {
        // Get the existing product image by its ID
        var productImage = await _productRepo.GetProductImageByIdAsync(updateProductImage.ProductImageId);
        if (productImage == null)
        {
            _logger.LogWarning("Product image with ID: {ProductImageId} not found.", updateProductImage.ProductImageId);
            return false;
        }

        file = updateProductImage.File;

        // Construct the path for the existing image to be deleted later
        oldPath = Path.Combine(_imageDirectory, productImage.FileName);

        // Check if a new file is uploaded
        if (file != null && file.Length > 0)
        {
            // Save the new image and get the new file name
            fileName = await SaveImageAsync(file, productImage.Product.ProductName);
            if (fileName == null)
            {
                throw new Exception("Failed to save new product image.");
            }

            // Update the product image details with the new file name
            productImage.FileName = fileName;
            productImage.IsPrimary = updateProductImage.IsPrimary;

            // Update the product image in the repository
            var result = await _productRepo.UpdateProductImageAsync(productImage);
            if (result != null)
            {
                // Delete the old image if it exists
                if (!string.IsNullOrEmpty(oldPath) && File.Exists(oldPath))
                {
                    try
                    {
                        File.Delete(oldPath);
                        _logger.LogInformation("Old image file deleted: {OldImagePath}", oldPath);
                    }
                    catch (Exception deleteEx)
                    {
                        _logger.LogError(deleteEx, "Failed to delete old image file: {OldImagePath}", oldPath);
                    }
                }

                return true;
            }
        }

        return false;
    }
    catch (Exception ex)
    {
        // Handle unexpected errors
        _logger.LogError(ex, "Error updating product image with ID: {ProductImageId}", updateProductImage.ProductImageId);
        // If an error occurs, delete the newly uploaded image if it was partially saved
        if (!string.IsNullOrEmpty(fileName))
        {
            try
            {
                File.Delete(Path.Combine(_imageDirectory, fileName));
                _logger.LogInformation("Deleted partially uploaded image: {NewImagePath}", Path.Combine(_imageDirectory, fileName));
            }
            catch (Exception deleteEx)
            {
                _logger.LogError(deleteEx, "Failed to delete partially uploaded image: {NewImagePath}", Path.Combine(_imageDirectory, fileName));
            }
        }
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
                var oldFilePath = Path.Combine(_imageDirectory, fileName);
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

    public async Task<ProductResponse?> CreateNewProductVariantAsync(NewProductVariant newProductVariant)
    {
        try
        {
            var productId = newProductVariant.ProductId;
            var product = await _productRepo.GetProductByIdAsync(productId);
            if (product == null)
            {
                throw new Exception("Product not found.");
            }
            var productVariant = _mapper.Map<ProductVariant>(newProductVariant);
            productVariant = await _productRepo.CreateProductVariantAsync(productVariant);
            var listProductVariant =  await _productRepo.GetAllVariantsAsync(productId);
            int totalQuantity = listProductVariant.Where(p=>p.Status).Sum(v => v.Quantity);
            product.Quantity = totalQuantity;
            product = await _productRepo.UpdateProductAsync(product);
            return _mapper.Map<ProductResponse>(product);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating new product variant.");
            throw;
        }
    }

    public async Task<ProductResponse?> UpdateProductVariantAsync(UpdateProductVariant updateProductVariant)
    {
        try
        {
            var productVariant = await _productRepo.GetProductVariantByIdAsync(updateProductVariant.VariantId);
            if (productVariant == null)
            {
                throw new Exception("Product variant not found.");
            }

            _mapper.Map(updateProductVariant, productVariant);
            productVariant = await _productRepo.UpdateProductVariantAsync(productVariant);
            var productId = productVariant.ProductId;
            var product = await _productRepo.GetProductByIdAsync(productId);
            var listProductVariant = await _productRepo.GetAllVariantsAsync(productId);
            int totalQuantity = listProductVariant.Where(p=>p.Status).Sum(v => v.Quantity);
            product.Quantity = totalQuantity;
            await _productRepo.UpdateProductAsync(product);
            var newProduct = await _productRepo.GetProductByIdAsync(productId);
            return _mapper.Map<ProductResponse>(newProduct);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating product variant with ID: {VariantId}", updateProductVariant.VariantId);
            throw;
        }
    }
}
