using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessObject.Entities;
using static BusinessLogicLayer.Mappings.ResponseDTO.OrderResponse;

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
            CreateMap<Customer, CustomerResponse>();
            CreateMap<UpdateEmployee, Employee>();
            CreateMap<NewCategory, Category>();
            CreateMap<Category, CategoryResponse>();
            CreateMap<UpdateCategory, Category>();

            CreateMap<NewProduct, Product>();
            CreateMap<Product, ProductResponse>()
                .ForMember(dest => dest.CategoryName, otp => otp.MapFrom(src => src.Category.CategoryName));
            CreateMap<ProductImage, ProductImageResponse>()
                .ForMember(dest => dest.ImageUrl,
                    otp => otp.MapFrom(src => $"{applicationUrl}/images/product/{src.FileName}"));
            CreateMap<UpdateProduct, Product>();


            //Order
            CreateMap<Order, OrderResponse>()
     .ForMember(dest => dest.CustomerId, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.CustomerId : (int?)null))
     .ForMember(dest => dest.FullName, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.FullName : null))
     .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.Email : null))
     .ForMember(dest => dest.IsEmailVerified, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.IsEmailVerified : false))
     .ForMember(dest => dest.PhoneNumber, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.PhoneNumber : null))
     .ForMember(dest => dest.Address, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.Address : null))
     .ForMember(dest => dest.DateOfBirth, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.DateOfBirth.ToString() : "Undefined"))
     .ForMember(dest => dest.Gender, opt => opt.MapFrom(src => src.Customer != null && src.Customer.Gender.HasValue ? src.Customer.Gender.Value : (bool?)null))
     .ForMember(dest => dest.CreatedAt, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.CreatedAt : (DateTime?)null))
     .ForMember(dest => dest.ImageUrl, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.ImageUrl : null))
     .ForMember(dest => dest.UpdateAt, opt => opt.MapFrom(src => src.Customer != null ? src.Customer.UpdateAt : (DateTime?)null));

            CreateMap<OrderDetail, OrderDetailResponse>();
            CreateMap<Receipt, ReceiptResponse>();


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
