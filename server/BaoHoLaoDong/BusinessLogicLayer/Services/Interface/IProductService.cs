using System.Collections.Generic;
using System.Threading.Tasks;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Models;

namespace BusinessLogicLayer.Services.Interface;

public interface IProductService
{
     Task<CategoryResponse?> CreateNewCategory(NewProductCategory productCategory);
     Task<List<CategoryResponse>?> GetAllCategory();
     
     Task<Page<ProductResponse>?> GetProductByPage(int category = 0, int page = 1, int pageSize = 20);
     Task<CategoryResponse?> UpdateCategoryAsync(UpdateProductCategory productCategory);
     Task<ProductResponse> CreateNewProductAsync(NewProduct newProduct);
     Task<int> CountProductByCategory(int category);
     Task<ProductResponse?> UpdateProductAsync(UpdateProduct updateProduct);
     Task<ProductResponse?> UpdateProductImageAsync(UpdateProductImage updateProductImage);
     Task<bool?> DeleteImageAsync(int id);
     Task<bool?> CreateNewProductImageAsync(NewProductImage productImage);
     Task<ProductResponse?> CreateNewProductVariantAsync(NewProductVariant newProductVariant);
     Task<ProductResponse?> UpdateProductVariantAsync(UpdateProductVariant updateProductVariant);
     Task<List<ProductResponse>?> SearchProductAsync(string title);
     Task<ProductResponse?> GetProductByIdAsync(int id);
     Task<List<ProductResponse>?> GetTopSaleProduct(int size);
     Task<ProductResponse?> AddTaxProductAsync(NewProductTax productTax);
     Task<ProductResponse?> DeleteTaxAsync(int productTaxid);
}