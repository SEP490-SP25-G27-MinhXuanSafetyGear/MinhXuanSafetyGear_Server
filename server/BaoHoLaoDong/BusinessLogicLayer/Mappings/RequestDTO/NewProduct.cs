using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace BusinessLogicLayer.Mappings.RequestDTO
{
    public class NewProduct
    {
        [Required]
        public string ProductName { get; set; } = null!;
        [Required]
        public int? CategoryId { get; set; }
        
        public string? Description { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Quantity must be a positive number.")]
        public int Quantity { get; set; }

        [Range(0.01, double.MaxValue, ErrorMessage = "Price must be a positive number.")]
        public decimal Price { get; set; }

        public decimal? Discount { get; set; }

        public bool Status { get; set; }
        public IFormFile File { get; set; } = null!;

    }
}