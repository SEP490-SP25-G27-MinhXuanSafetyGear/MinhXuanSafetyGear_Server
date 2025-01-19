using BusinessObject.Entities;

namespace BusinessLogicLayer.Mappings.RequestDTO;

public class UpdateProduct
{
    public int ProductId { get; set; }

    public string ProductName { get; set; } = null!;

    public int? CategoryId { get; set; }
    
    public int Quantity { get; set; }

    public decimal Price { get; set; }


}