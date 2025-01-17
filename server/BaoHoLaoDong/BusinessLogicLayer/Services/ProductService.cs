using AutoMapper;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository;
using DataAccessObject.Repository.Interface;
using Microsoft.Extensions.Logging;

namespace BusinessLogicLayer.Services;

public class ProductService : IProductService
{
    private readonly IMapper _mapper;
    private readonly ILogger<ProductService> _logger;
    private readonly IProductRepo _productRepo;
    
    public ProductService(MinhXuanDatabaseContext _context, IMapper mapper, ILogger<ProductService> logger)
    {
        _productRepo = new ProductRepo(_context);
        _mapper = mapper;
        _logger = logger;
    }
}