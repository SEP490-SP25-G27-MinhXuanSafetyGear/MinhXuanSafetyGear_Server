using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessObject.Entities;
namespace BusinessLogicLayer.Mappings
{
    public class MappingProfile : Profile
    {
        public MappingProfile(string applicationUrl)
        {
            // Ánh xạ từ Employee sang EmployeeRequest
            CreateMap<Employee, EmployeeResponse>()
                .ForMember(dest => dest.Gender, opt =>
                    opt.MapFrom(src =>
                        src.Gender.HasValue
                            ? (src.Gender.Value ? "Male" : "Female")
                            : "Undefined")); // Nếu null thì trả về null
            // Ánh xạ từ newEmployee sang Employee
            CreateMap<NewEmployee, Employee>();
            // mapping fromg newcustomer => customer
            CreateMap<NewCustomer, Customer>();
            CreateMap<Customer, CustomerResponse>()
                .ForMember(dest=>dest.Id,otp=>otp.MapFrom(src=>src.CustomerId));
            CreateMap<UpdateEmployee, Employee>();
            CreateMap<NewCategory, Category>();
            CreateMap<Category, CategoryResponse>();
            CreateMap<UpdateCategory, Category>();
            CreateMap<NewProductVariant, ProductVariant>()
                .ForMember(dest => dest.VariantId, opt => opt.Ignore()) // Ignore VariantId, as it will be auto-generated
                .ForMember(dest => dest.CreatedAt, opt => opt.MapFrom(_ => DateTime.UtcNow)) // Set CreatedAt
                .ForMember(dest => dest.UpdatedAt, opt => opt.Ignore()) // Optional, will remain null
                .ForMember(dest => dest.Product, opt => opt.Ignore());  // Ignore navigation property
            CreateMap<NewProduct, Product>();
            CreateMap<Product, ProductResponse>()
                .ForMember(dest=>dest.Id,otp=>otp.MapFrom(src=>src.ProductId))
                .ForMember(dest=>dest.Name,otp=>otp.MapFrom(src=>src.ProductName))
                .ForMember(dest => dest.CategoryName, otp => otp.MapFrom(src => src.Category.CategoryName))
                .ForMember(dest => dest.Rate, otp => otp.MapFrom(src => 
                    src.ProductReviews.Any() 
                        ? src.ProductReviews.Sum(p => p.Rating) / (double)src.ProductReviews.Count 
                        : 0));
            CreateMap<ProductVariant, ProductVariantResponse>();
            CreateMap<ProductImage, ProductImageResponse>()
                .ForMember(dest=>dest.Id,otp=>otp.MapFrom(src=>src.ProductImageId))
                .ForMember(dest => dest.ImageUrl,
                    otp => otp.MapFrom(src => $"{applicationUrl}/images/{src.FileName}"));
            CreateMap<UpdateProduct, Product>();
            CreateMap<UpdateProductVariant, ProductVariant>();
            CreateMap<NewBlogPost, BlogPost>();
            CreateMap<BlogPost, BlogPostResponse>()
                .ForMember(dest=>dest.ImageUrl,otp=>otp.MapFrom(src=>$"{applicationUrl}/images/{src.FileName}"));
            CreateMap<UpdateBlogPost, BlogPost>()
                .ForMember(dest => dest.FileName, opt => opt.Ignore()); // FileName sẽ được xử lý riêng
        }
    }
}