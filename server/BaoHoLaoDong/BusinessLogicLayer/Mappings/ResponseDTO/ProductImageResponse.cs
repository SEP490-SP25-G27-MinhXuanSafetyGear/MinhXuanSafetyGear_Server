namespace BusinessLogicLayer.Mappings.ResponseDTO;

public class ProductImageResponse
{
    public int ProductImageId { get; set; }

    public string FileName { get; set; } = null!;

    public string? ImageUrl { get; set; }

    public string? Description { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

}