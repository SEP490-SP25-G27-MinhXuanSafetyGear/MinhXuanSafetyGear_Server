using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace BusinessLogicLayer.Mappings.RequestDTO
{
    public class NewProduct
    {
        [Required]
        public string Name { get; set; } = null!;
        public int Category { get; set; }
        
        public string? Description { get; set; }
        
        public string? Material { get; set; }

        public string? Origin { get; set; }


        [Range(0, int.MaxValue, ErrorMessage = "Quantity must be a positive number.")]
        public int Quantity { get; set; }

        [Range(0.01, double.MaxValue, ErrorMessage = "Price must be a positive number.")]
        public decimal Price { get; set; }

        public decimal? Discount { get; set; }

        public bool Status { get; set; }
        
        public List<IFormFile> Files { get; set; } = null!;
        public ICollection<NewProductVariant> ProductVariants { get; set; } = new List<NewProductVariant>();

    }
}