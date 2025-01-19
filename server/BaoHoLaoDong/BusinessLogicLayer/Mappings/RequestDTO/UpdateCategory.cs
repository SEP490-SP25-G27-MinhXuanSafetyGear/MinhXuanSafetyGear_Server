namespace BusinessLogicLayer.Mappings.RequestDTO;

public class UpdateCategory
{
    public int CategoryId { get; set; }

    public string CategoryName { get; set; } = null!;

    public string Description { get; set; } = null!;
}