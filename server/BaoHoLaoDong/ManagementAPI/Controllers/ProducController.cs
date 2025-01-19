using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Services.Interface;
using ManagementAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
public class ProducController : ControllerBase
{
    private readonly IProductService _productService;
    public ProducController(IProductService productService)
    {
        _productService = productService;
    }
    /// <summary>
    /// Crate new category
    /// </summary>
    /// <param name="category"></param>
    /// <returns>CategoryRequest</returns>
    [HttpPost("create-category")]
    public async Task<IActionResult> CreateNewCategory([FromBody] NewCategory category)
    {
        try
        {
            var result = await _productService.CreateNewCategory(category);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    /// <summary>
    /// get all category
    /// </summary>
    /// <returns>List CategoryRequest</returns>
    [HttpGet("getall-category")]
    public async Task<IActionResult> GetALlCategory()
    {
        try
        {
            var categorys = await _productService.GetAllCategory();
            return Ok(categorys);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    /// <summary>
    /// update category
    /// </summary>
    /// <param name="category"></param>
    /// <returns>CategoryResponse</returns>
    [HttpPut("update-category")]
    public async Task<IActionResult> UpdateCategory([FromBody] UpdateCategory category)
    {
        try
        {
            var result = await _productService.UpdateCategoryAsync(category);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }

    /// <summary>
    /// Create new product
    /// </summary>
    /// <param name="newProduct"></param>
    /// <returns></returns>
    [HttpPost("create-product")]
    public async Task<IActionResult> CreateProduct( NewProduct newProduct)
    {
        try
        {
            var product = await _productService.CreateNewProductAsync(newProduct);
            return Ok(product);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    /// <summary>
    /// Get product page
    /// </summary>
    /// <param name="category"></param>
    /// <param name="page"></param>
    /// <param name="pagesize"></param>
    /// <returns>List productResponse</returns>
    [HttpGet("get-product-page/{category}/{page}/{pagesize}")]
    public async Task<IActionResult> GetProductPage([FromRoute] int category =0,[FromRoute] int page =1,int pagesize =20)
    {
        try
        {
            var products = await _productService.GetProductByPage(category, page, pagesize);
            int totalProduct = await _productService.CountProductByCategory(category);
            var pageResult = new Page<ProductResponse>(products, page, pagesize,totalProduct);
            return Ok(pageResult);
        }
        catch (Exception ex)
        {
            return BadRequest(ex);
        }
    }
    /// <summary>
    /// Update product
    /// </summary>
    /// <param name="updateProduct"></param>
    /// <returns>Productresponse</returns>
    [HttpPut("update-product")]
    public async Task<IActionResult> UpdateProduct([FromBody] UpdateProduct updateProduct)
    {
        try
        {
            var product = await _productService.UpdateProductAsync(updateProduct);
            return Ok(product);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    /// <summary>
    /// Update image product
    /// </summary>
    /// <param name="updateProductImage"></param>
    /// <returns>bool</returns>
    [HttpPut("update-image")]
    public async Task<IActionResult> UpdateImage([FromForm] UpdateProductImage updateProductImage)
    {
        try
        {
            var result = await _productService.UpdateProductImageAsync(updateProductImage);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpPost("create-image")]
    public async Task<IActionResult> CreateImage([FromForm] NewProductImage productImage)
    {
        try
        {
            var productResult = await _productService.CreateNewProductImageAsync(productImage);
            return Ok(productResult);
        }
        catch (Exception ex)
        {
            return BadRequest(ex);
        }
    }
    [HttpDelete("delete-image/{id}")]
    public async Task<IActionResult> DeleteImage([FromRoute] int id)
    {
        try
        {
            var result = await _productService.DeleteImageAsync(id);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}