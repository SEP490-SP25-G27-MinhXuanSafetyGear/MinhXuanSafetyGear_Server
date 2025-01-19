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
        }
    }
}