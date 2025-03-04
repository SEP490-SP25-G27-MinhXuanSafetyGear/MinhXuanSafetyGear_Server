namespace BusinessLogicLayer.Mappings.ResponseDTO;

public class BlogCategoryResponse
{
    public int CategoryBlogId { get; set; }

    public string CategoryName { get; set; } = null!;

    public string? Description { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }
}