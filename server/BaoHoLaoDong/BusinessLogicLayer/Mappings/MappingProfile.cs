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
            CreateMap<NewProductCategory, ProductCategory>();
            CreateMap<ProductCategory, CategoryResponse>();
            CreateMap<UpdateProductCategory, ProductCategory>();
            CreateMap<NewProductVariant, ProductVariant>()
                .ForMember(dest => dest.VariantId, opt => opt.Ignore()) // Ignore VariantId, as it will be auto-generated
                .ForMember(dest => dest.CreatedAt, opt => opt.MapFrom(_ => DateTime.UtcNow)) // Set CreatedAt
                .ForMember(dest => dest.UpdatedAt, opt => opt.Ignore()) // Optional, will remain null
                .ForMember(dest => dest.Product, opt => opt.Ignore());  // Ignore navigation property
            CreateMap<NewProduct, Product>()
                .ForMember(dest => dest.ProductName, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.CategoryId, opt => opt.MapFrom(src => src.Category))
                .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
                .ForMember(dest => dest.Material, opt => opt.MapFrom(src => src.Material))
                .ForMember(dest => dest.Origin, opt => opt.MapFrom(src => src.Origin))
                .ForMember(dest => dest.Quantity, opt => opt.MapFrom(src => src.Quantity))
                .ForMember(dest => dest.Price, opt => opt.MapFrom(src => src.Price))
                .ForMember(dest => dest.Discount, opt => opt.MapFrom(src => src.Discount))
                .ForMember(dest => dest.Status, opt => opt.MapFrom(src => src.Status))
                .ForMember(dest => dest.ProductVariants, opt => opt.MapFrom(src => src.ProductVariants))
                .ForMember(dest => dest.Category, opt => opt.Ignore());

            CreateMap<Product, ProductResponse>()
                .ForMember(dest => dest.Id, otp => otp.MapFrom(src => src.ProductId))
                .ForMember(dest => dest.Name, otp => otp.MapFrom(src => src.ProductName))
                .ForMember(dest => dest.CategoryName, otp => otp.MapFrom(src => src.Category.CategoryName));
            CreateMap<ProductVariant, ProductVariantResponse>();
            CreateMap<ProductImage, ProductImageResponse>()
                .ForMember(dest=>dest.Id,otp=>otp.MapFrom(src=>src.ProductImageId))
                .ForMember(dest => dest.Image,
                    otp => otp.MapFrom(src => $"{applicationUrl}/images/{src.FileName}"));
            CreateMap<UpdateProduct, Product>()
                .ForMember(dest => dest.ProductId, opt => opt.MapFrom(src => src.Id))
                .ForMember(dest => dest.ProductName, opt => opt.MapFrom(src => src.Name))
                .ForMember(dest => dest.CategoryId, opt => opt.MapFrom(src => src.CategoryId))
                .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
                .ForMember(dest => dest.Material, opt => opt.MapFrom(src => src.Material))
                .ForMember(dest => dest.Origin, opt => opt.MapFrom(src => src.Origin))
                .ForMember(dest => dest.Quantity, opt => opt.MapFrom(src => src.Quantity))
                .ForMember(dest => dest.Price, opt => opt.MapFrom(src => src.Price))
                .ForMember(dest => dest.Discount, opt => opt.MapFrom(src => src.Discount))
                .ForMember(dest => dest.Status, opt => opt.MapFrom(src => src.Status))
                .ForMember(dest => dest.UpdatedAt, opt => opt.MapFrom(src => DateTime.UtcNow));
            CreateMap<UpdateProductVariant, ProductVariant>();
            CreateMap<NewBlogPost, BlogPost>();
            CreateMap<BlogPost, BlogPostResponse>()
                .ForMember(dest=>dest.ImageUrl,otp=>otp.MapFrom(src=>$"{applicationUrl}/images/{src.FileName}"));
            CreateMap<UpdateBlogPost, BlogPost>()
                .ForMember(dest => dest.FileName, opt => opt.Ignore()); // FileName sẽ được xử lý riêng

            CreateMap<NewBlogCategory, BlogCategory>()
                .ForMember(d=>d.CategoryName,otp=>otp.MapFrom(s=>s.Name))
                .ForMember(d=>d.Description,otp=>otp.MapFrom(s=>s.Description));
            CreateMap<UpdateBlogCategory,BlogCategory>()
                .ForMember(d=>d.CategoryBlogId,otp=>otp.MapFrom(s=>s.Id))
                .ForMember(d=>d.CategoryName,otp=>otp.MapFrom(s=>s.Name))
                .ForMember(d=>d.Description,otp=>otp.MapFrom(s=>s.Description));
            CreateMap<BlogCategory,BlogCategoryResponse>()
                .ForMember(d=>d.Id,otp=>otp.MapFrom(s=>s.CategoryBlogId))
                .ForMember(d=>d.Name,otp=>otp.MapFrom(s=>s.CategoryName));

            //Order
            CreateMap<Order, OrderResponse>()
                 .ForMember(dest => dest.CustomerId, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.CustomerId : (int?)null))
                 .ForMember(dest => dest.FullName, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.FullName : null))
                 .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.Email : null))
                 .ForMember(dest => dest.IsEmailVerified, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.IsEmailVerified : false))
                 .ForMember(dest => dest.PhoneNumber, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.PhoneNumber : null))
                 .ForMember(dest => dest.Address, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.Address : "Undefined"))
                 .ForMember(dest => dest.DateOfBirth, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.DateOfBirth : null))
                 .ForMember(dest => dest.Gender, opt => opt.MapFrom(src => src.Customer != null && src.Customer.Gender.HasValue ? src.Customer.Gender.Value : (bool?)null))
                 .ForMember(dest => dest.CreatedAt, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.CreatedAt : (DateTime?)null))
                 .ForMember(dest => dest.ImageUrl, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.ImageUrl : null))
                 .ForMember(dest => dest.UpdateAt, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.UpdateAt : (DateTime?)null));

            CreateMap<OrderDetail, OrderDetailResponse>();
            CreateMap<Invoice, InvoiceResponse>();
            CreateMap<NewOrder, Order>()
                .ForMember(dest => dest.CustomerId, opt => opt.MapFrom(src => src.CustomerId))
                .ForMember(dest => dest.Customer, opt => opt.Ignore())
                .ForMember(dest => dest.TotalAmount, opt => opt.MapFrom(src => src.TotalAmount))
                .ForMember(dest => dest.Status, opt => opt.MapFrom(src => src.Status))
                .ForMember(dest => dest.OrderDate, opt => opt.MapFrom(src => src.OrderDate))
                .ForMember(dest => dest.UpdatedAt, opt => opt.MapFrom(src => src.UpdatedAt));
            CreateMap<Order, NewOrder>();
        }
    }
}