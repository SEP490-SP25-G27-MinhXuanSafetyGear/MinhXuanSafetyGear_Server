
namespace BusinessLogicLayer.Mappings.ResponseDTO;

public class ProductResponse
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }
    
    public int? CategoryId { get; set; }

    public string CategoryName { get; set; } =string.Empty;
    
    public int Quantity { get; set; }

    public decimal Price { get; set; }

    public decimal? Discount { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public bool Status { get; set; }
    public int Rate { get; set; }
    public List<ProductImageResponse> ProductImages { get; set; } = new List<ProductImageResponse>();
    public List<ProductVariantResponse> ProductVariants { get; set; } = new List<ProductVariantResponse>();
}