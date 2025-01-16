using AutoMapper;
using BusinessLogicLayer.Services.Interface;
using DataAccessObject.Repository.Interface;
using Microsoft.Extensions.Logging;

namespace BusinessLogicLayer.Services;

public class ProductService : IProductService
{
    private readonly IMapper _mapper;
    private readonly ILogger<ProductService> _logger;
    private readonly IProductRepo _productRepo;
    
    public ProductService(IProductRepo productRepo, IMapper mapper, ILogger<ProductService> logger)
    {
        _productRepo = productRepo;
        _mapper = mapper;
        _logger = logger;
    }
    
}