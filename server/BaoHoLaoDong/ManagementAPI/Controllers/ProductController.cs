using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using ManagementAPI.Hubs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.OData.Query;
using Microsoft.AspNetCore.SignalR;

namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
public class ProductController : ControllerBase
{
    private readonly IProductService _productService;
    private readonly IHubContext<ProductHub> _productHub;
    private readonly IMapper _mapper;
    public ProductController(IProductService productService,IHubContext<ProductHub> productHub ,IMapper mapper)
    {
        _productService = productService;
        _productHub = productHub;
        _mapper = mapper;
    }
    /// <summary>
    /// Crate new category
    /// </summary>
    /// <param name="productCategory"></param>
    /// <returns>CategoryRequest</returns>
    [HttpPost("create-category")]
    public async Task<IActionResult> CreateNewCategory([FromBody] NewProductCategory productCategory)
    {
        try
        {
            var result = await _productService.CreateNewCategory(productCategory);
            await _productHub.Clients.All.SendAsync("ProductCategoryAdded");
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
    /// <param name="productCategory"></param>
    /// <returns>CategoryResponse</returns>
    [HttpPut("update-category")]
    public async Task<IActionResult> UpdateCategory([FromBody] UpdateProductCategory productCategory)
    {
        try
        {
            var result = await _productService.UpdateCategoryAsync(productCategory);
            if (result!=null)
            {
                _productHub.Clients.All.SendAsync("ProductCategoryUpdated", productCategory.CategoryId);
            }
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
    public async Task<IActionResult> CreateProduct( [FromForm] NewProduct newProduct)
    {
        try
        {
            var product = await _productService.CreateNewProductAsync(newProduct);
            _productHub.Clients.All.SendAsync("ProductAdded", newProduct);
            return Ok(product);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    /// <summary>
    /// create new product variant
    /// </summary>
    /// <param name="newProductVariant"></param>
    /// <returns></returns>
    [HttpPost("create-product-variant")]
    public async Task<IActionResult> CreateProductVariant([FromBody] NewProductVariant newProductVariant)
    {
        try
        {
            var product = await _productService.CreateNewProductVariantAsync(newProductVariant);
            return Ok(product);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    [HttpPut("update-product-variant")]
    public async Task<IActionResult> UpdateProductVariant([FromBody] UpdateProductVariant updateProductVariant)
    {
        try
        {
            var product = await _productService.UpdateProductVariantAsync(updateProductVariant);
            return Ok(product);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    /// <summary>
    /// Get product page {{base_url}}/api/product/get-product-page?category=1&page=1&pagesize=20&
    /// </summary>
    /// <param name="category"></param>
    /// <param name="page"></param>
    /// <param name="pagesize"></param>
    /// <returns>List productResponse</returns>
    [EnableQuery]
    [HttpGet("get-product-page")]
    public async Task<IActionResult> GetProductPage([FromQuery] int category = 0, [FromQuery] int page = 1, [FromQuery] int pagesize = 20)
    {
        try
        {
            var pageResult = await _productService.GetProductByPage(category, page, pagesize);
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
            if (product != null)
            {
                await _productHub.Clients.All.SendAsync("ProductUpdated", product.Id);
            }
            return Ok(product);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpGet("get-product-by-id/{id}")]
    public async Task<IActionResult> GetProductById([FromRoute] int id)
    {
        try
        {
            var product = await _productService.GetProductByIdAsync(id);
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
            await _productHub.Clients.All.SendAsync("ProductUpdated", updateProductImage.ProductImageId);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    /// <summary>
    /// search product
    /// </summary>
    /// <param name="title"></param>
    /// <returns></returns>
    [HttpGet("search-product")]
    public async Task<IActionResult> SearchProduct([FromQuery] string title)
    {
        try
        {
            var result = await _productService.SearchProductAsync(title);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(ex);
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