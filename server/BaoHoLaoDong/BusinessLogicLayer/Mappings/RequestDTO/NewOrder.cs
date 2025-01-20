using BusinessLogicLayer.Mappings.ResponseDTO;

namespace BusinessLogicLayer.Mappings.RequestDTO;

public class NewOrder
{
    public int OrderId { get; set; }    
    public int CustomerId { get; set; }

    public decimal TotalAmount { get; set; }

    public string Status { get; set; } = null!;

    public DateTime OrderDate { get; set; }

    public DateTime? UpdatedAt { get; set; }
   
}