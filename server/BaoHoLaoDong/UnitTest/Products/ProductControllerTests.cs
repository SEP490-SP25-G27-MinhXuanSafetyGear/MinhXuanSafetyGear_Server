using NUnit.Framework;
using Moq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Services.Interface;
using ManagementAPI.Controllers;
using AutoMapper;
using BusinessLogicLayer.Hubs;
using BusinessLogicLayer.Mappings.ResponseDTO;

namespace UnitTest.Products
{
    public class ProductControllerTests
    {
        private readonly Mock<IProductService> _productServiceMock;
        private readonly Mock<IHubContext<ProductHub>> _productHubMock;
        private readonly Mock<IMapper> _mapperMock;
        private ProductController _productController;

        public ProductControllerTests()
        {
            _productServiceMock = new Mock<IProductService>();
            _productHubMock = new Mock<IHubContext<ProductHub>>();
            _mapperMock = new Mock<IMapper>();
            _productController = new ProductController(_productServiceMock.Object, null, _productHubMock.Object, _mapperMock.Object);
        }

        [Test]
        public async Task CreateProduct_ValidProduct_ReturnsOk()
        {
            // Arrange
            var fileMock = new Mock<IFormFile>();
            fileMock.Setup(f => f.Length).Returns(1024);
            fileMock.Setup(f => f.FileName).Returns("test.jpg");

            var newProduct = new NewProduct
            {
                Name = "Product 12312312",
                Category = 1,
                Description = "description",
                Discount = 10,
                Origin = "Vietnam",
                Price = 10.99m,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile> { fileMock.Object },
                ProductVariants = new List<NewProductVariant> {
            new NewProductVariant {
                Size = "M",
                Quantity = 10,
                Color = "Red",
                Price = 10.99m,
                Discount = 10,
                Status = true }
            }
            };

            var mockProductResponse = new ProductResponse
            {
                Id = 1,
                Name = newProduct.Name,
                Origin = newProduct.Origin,
                CategoryId = newProduct.Category,
                Description = newProduct.Description,
                Price = newProduct.Price,
                Quantity = newProduct.Quantity,
                Status = newProduct.Status,
                Discount = newProduct.Discount,
            };


            _productServiceMock.Setup(s => s.CreateNewProductAsync(It.IsAny<NewProduct>())).ReturnsAsync(mockProductResponse);

            var mockClientProxy = new Mock<IClientProxy>();
            mockClientProxy.Setup(x => x.SendCoreAsync(It.IsAny<string>(), It.IsAny<object[]>(), default)).Returns(Task.CompletedTask);

            var mockHubClients = new Mock<IHubClients>();
            mockHubClients.Setup(c => c.All).Returns(mockClientProxy.Object);

            var mockHubContext = new Mock<IHubContext<ProductHub>>();
            mockHubContext.Setup(h => h.Clients).Returns(mockHubClients.Object);

            _productController = new ProductController(_productServiceMock.Object, null, mockHubContext.Object, _mapperMock.Object);

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<OkObjectResult>());
            var okResult = (OkObjectResult)result;
            Assert.That(okResult.Value, Is.Not.Null);
            Assert.That(okResult.Value, Is.TypeOf<ProductResponse>());
        }


        [Test]
        public async Task CreateProduct_MissingName_ReturnsBadRequest()
        {
            // Arrange
            var newProduct = new NewProduct
            {
                Category = 1,
                Price = 10.99m,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile> { Mock.Of<IFormFile>() }
            };

            _productController.ModelState.AddModelError("Name", "Tên không được để trống");

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.Not.Null);
        }

        [Test]
        public async Task CreateProduct_InvalidPrice_ReturnsBadRequest()
        {
            // Arrange
            var newProduct = new NewProduct
            {
                Name = "Test Product",
                Category = 1,
                Price = -10.99m,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile> { Mock.Of<IFormFile>() }
            };

            _productController.ModelState.AddModelError("Price", "Price must be a positive number more than 0.01");

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.Not.Null);
        }

        [Test]
        public async Task CreateProduct_MissingFiles_ReturnsBadRequest()
        {
            // Arrange
            var newProduct = new NewProduct
            {
                Name = "Test Product",
                Category = 1,
                Price = 10.99m,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile>() // No files uploaded
            };

            _productController.ModelState.AddModelError("Files", "Phải tải lên ít nhất 1 hình ảnh");

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.Not.Null);
        }
    }
}
