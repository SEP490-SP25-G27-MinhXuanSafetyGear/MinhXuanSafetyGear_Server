using System.ComponentModel.DataAnnotations;
using BusinessObject.Entities;
using Microsoft.AspNetCore.Http;

namespace BusinessLogicLayer.Mappings.RequestDTO;

public class NewBlogPost
{
    [Required]
    public string Title { get; set; } = null!;
    [Required]
    public string Content { get; set; } = null!;
    [Required]
    public string Status { get; set; } = null!;
    [Required]
    public int CategoryId { get; set; }
    public IFormFile? File { get; set; }
}