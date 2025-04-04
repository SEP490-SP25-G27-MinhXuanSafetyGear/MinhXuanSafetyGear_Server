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
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace UnitTest.Products
{
    public class ProductControllerTests
    {
        private Mock<IProductService> _productServiceMock;
        private Mock<IBlogPostService> _blogPostServiceMock;
        private Mock<IHubContext<ProductHub>> _productHubMock;
        private Mock<IMapper> _mapperMock;
        private ProductController _productController;
        private Mock<IServiceProvider> _mockServiceProvider;

        [SetUp]
        public void SetUp()
        {
            _productServiceMock = new Mock<IProductService>();
            _blogPostServiceMock = new Mock<IBlogPostService>();
            _productHubMock = new Mock<IHubContext<ProductHub>>();
            _mapperMock = new Mock<IMapper>();
            _mockServiceProvider = new Mock<IServiceProvider>();

            _mockServiceProvider.Setup(sp => sp.GetService(typeof(IProductService)))
                                .Returns(_productServiceMock.Object);

            _productController = new ProductController(
                _productServiceMock.Object,
                _blogPostServiceMock.Object,
                _productHubMock.Object,
                _mapperMock.Object
            );
        }
        [Test]
        public async Task CreateProduct_ValidName_ReturnsSuccess()
        {
            // Arrange
            var content = "Fake file content";
            var fileName = "test.jpg";
            var stream = new MemoryStream(Encoding.UTF8.GetBytes(content));
            var formFile = new FormFile(stream, 0, stream.Length, "Files", fileName)
            {
                Headers = new HeaderDictionary(),
                ContentType = "image/jpeg"
            };

            var newProduct = new NewProduct
            {
                Name = "Product1", 
                Category = 1,
                Description = "Good product",
                Discount = 1,
                Price = 10.99m,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile> { formFile },
                ProductVariants = new List<NewProductVariant>
        {
            new NewProductVariant
            {
                Size = "M",
                Quantity = 10,
                Color = "Red",
                Price = 10.99m,
                Discount = 10,
                Status = true
            }
        }
            };

            var mockHubClients = new Mock<IHubClients>();
            var mockClientProxy = new Mock<IClientProxy>();
            mockHubClients.Setup(c => c.All).Returns(mockClientProxy.Object);
            _productHubMock.Setup(h => h.Clients).Returns(mockHubClients.Object);

            // Validate the product object
            var validationContext = new ValidationContext(newProduct, _mockServiceProvider.Object, null);
            var validationResults = new List<ValidationResult>();
            Validator.TryValidateObject(newProduct, validationContext, validationResults, true);

            foreach (var validationResult in validationResults)
            {
                foreach (var memberName in validationResult.MemberNames)
                {
                    _productController.ModelState.AddModelError(memberName, validationResult.ErrorMessage);
                }
            }

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<OkObjectResult>());
        }

        [Test]
        public async Task CreateProduct_InvalidQuantity_ReturnsBadRequest()
        {
            // Arrange
            var content = "Fake file content";
            var fileName = "test.jpg";
            var stream = new MemoryStream(Encoding.UTF8.GetBytes(content));
            var formFile = new FormFile(stream, 0, stream.Length, "Files", fileName)
            {
                Headers = new HeaderDictionary(),
                ContentType = "image/jpeg"
            };

            var newProduct = new NewProduct
            {
                Name = "Product Test",
                Category = 1,
                Description = "Test description",
                Discount = 10,
                Origin = "Vietnam",
                Price = 10.99m,
                Quantity = -5,
                Status = true,
                Files = new List<IFormFile> { formFile },
                ProductVariants = new List<NewProductVariant>
            {
                new NewProductVariant
                {
                    Size = "M",
                    Quantity = 10,
                    Color = "Red",
                    Price = 10.99m,
                    Discount = 10,
                    Status = true
                }
            }
            };

            var mockHubClients = new Mock<IHubClients>();
            var mockClientProxy = new Mock<IClientProxy>();
            mockHubClients.Setup(c => c.All).Returns(mockClientProxy.Object);
            _productHubMock.Setup(h => h.Clients).Returns(mockHubClients.Object);

            var validationContext = new ValidationContext(newProduct, _mockServiceProvider.Object, null);
            var validationResults = new List<ValidationResult>();
            Validator.TryValidateObject(newProduct, validationContext, validationResults, true);

            foreach (var validationResult in validationResults)
            {
                foreach (var memberName in validationResult.MemberNames)
                {
                    _productController.ModelState.AddModelError(memberName, validationResult.ErrorMessage);
                }
            }

            var result = await _productController.CreateProduct(newProduct);

            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.TypeOf<SerializableError>());
        }

        [Test]
        public async Task CreateProduct_InvalidDiscount_ReturnsBadRequest()
        {
            // Arrange
            var content = "Fake file content";
            var fileName = "test.jpg";
            var stream = new MemoryStream(Encoding.UTF8.GetBytes(content));
            var formFile = new FormFile(stream, 0, stream.Length, "Files", fileName)
            {
                Headers = new HeaderDictionary(),
                ContentType = "image/jpeg"
            };

            var newProduct = new NewProduct
            {
                Name = "Product Test",
                Category = 1,
                Description = "Test description",
                Discount = -1,
                Origin = "Vietnam",
                Price = 10.99m,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile> { formFile },
                ProductVariants = new List<NewProductVariant>
        {
            new NewProductVariant
            {
                Size = "M",
                Quantity = 10,
                Color = "Red",
                Price = 10.99m,
                Discount = 10,
                Status = true
            }
        }
            };

            // Add validation errors manually to ModelState
            var validationContext = new ValidationContext(newProduct, _mockServiceProvider.Object, null);
            var validationResults = new List<ValidationResult>();
            Validator.TryValidateObject(newProduct, validationContext, validationResults, true);

            foreach (var validationResult in validationResults)
            {
                foreach (var memberName in validationResult.MemberNames)
                {
                    _productController.ModelState.AddModelError(memberName, validationResult.ErrorMessage);
                }
            }

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.TypeOf<SerializableError>());

            var errorDetails = (SerializableError)badRequestResult.Value;
            Assert.That(errorDetails.ContainsKey("Discount"), Is.True, "Discount validation error should be present.");
        }

        [Test]
        public async Task CreateProduct_InvalidPrice_ReturnsBadRequest()
        {
            // Arrange
            var content = "Fake file content";
            var fileName = "test.jpg";
            var stream = new MemoryStream(Encoding.UTF8.GetBytes(content));
            var formFile = new FormFile(stream, 0, stream.Length, "Files", fileName)
            {
                Headers = new HeaderDictionary(),
                ContentType = "image/jpeg"
            };

            var newProduct = new NewProduct
            {
                Name = "Product Test",
                Category = 1,
                Description = "Test description",
                Discount = 10,
                Origin = "Vietnam",
                Price = -10,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile> { formFile },
                ProductVariants = new List<NewProductVariant>
        {
            new NewProductVariant
            {
                Size = "M",
                Quantity = 10,
                Color = "Red",
                Price = 10.99m,
                Discount = 10,
                Status = true
            }
        }
            };

            // Add validation errors manually to ModelState
            var validationContext = new ValidationContext(newProduct, _mockServiceProvider.Object, null);
            var validationResults = new List<ValidationResult>();
            Validator.TryValidateObject(newProduct, validationContext, validationResults, true);

            foreach (var validationResult in validationResults)
            {
                foreach (var memberName in validationResult.MemberNames)
                {
                    _productController.ModelState.AddModelError(memberName, validationResult.ErrorMessage);
                }
            }

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.TypeOf<SerializableError>());

            var errorDetails = (SerializableError)badRequestResult.Value;
            Assert.That(errorDetails.ContainsKey("Price"), Is.True, "Price validation error should be present.");
        }

        [Test]
        public async Task CreateProduct_InvalidName_ReturnsBadRequest()
        {
            // Arrange
            var content = "Fake file content";
            var fileName = "test.jpg";
            var stream = new MemoryStream(Encoding.UTF8.GetBytes(content));
            var formFile = new FormFile(stream, 0, stream.Length, "Files", fileName)
            {
                Headers = new HeaderDictionary(),
                ContentType = "image/jpeg"
            };

            var newProduct = new NewProduct
            {
                Name = "",  
                Category = 1,
                Description = "Test description",
                Discount = 10,
                Price = 10.99m,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile> { formFile },
                ProductVariants = new List<NewProductVariant>
        {
            new NewProductVariant
            {
                Size = "M",
                Quantity = 10,
                Color = "Red",
                Price = 10.99m,
                Discount = 10,
                Status = true
            }
        }
            };

            var validationContext = new ValidationContext(newProduct, _mockServiceProvider.Object, null);
            var validationResults = new List<ValidationResult>();
            Validator.TryValidateObject(newProduct, validationContext, validationResults, true);

            foreach (var validationResult in validationResults)
            {
                foreach (var memberName in validationResult.MemberNames)
                {
                    _productController.ModelState.AddModelError(memberName, validationResult.ErrorMessage);
                }
            }

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.TypeOf<SerializableError>());

            var errorDetails = (SerializableError)badRequestResult.Value;
            Assert.That(errorDetails.ContainsKey("Name"), Is.True, "Name validation error should be present.");
        }

        [Test]
        public async Task CreateProduct_InvalidNameNull_ReturnsBadRequest()
        {
            // Arrange
            var newProduct = new NewProduct
            {
                Name = null,  
                Category = 1,
                Description = "Good product",
                Discount = 1,
                Price = 10.99m,
                Quantity = 5,
                Status = true,
                Files = new List<IFormFile>(),
                ProductVariants = new List<NewProductVariant>()
            };

            var mockHubClients = new Mock<IHubClients>();
            var mockClientProxy = new Mock<IClientProxy>();
            mockHubClients.Setup(c => c.All).Returns(mockClientProxy.Object);
            _productHubMock.Setup(h => h.Clients).Returns(mockHubClients.Object);

            // Validate the product object
            var validationContext = new ValidationContext(newProduct, _mockServiceProvider.Object, null);
            var validationResults = new List<ValidationResult>();
            Validator.TryValidateObject(newProduct, validationContext, validationResults, true);

            foreach (var validationResult in validationResults)
            {
                foreach (var memberName in validationResult.MemberNames)
                {
                    _productController.ModelState.AddModelError(memberName, validationResult.ErrorMessage);
                }
            }

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.TypeOf<SerializableError>());
        }

        [Test]
        public async Task CreateProduct_InvalidQuantityEmpty_ReturnsBadRequest()
        {
            // Arrange
            var newProduct = new NewProduct
            {
                Name = "Product1",
                Category = 1,
                Description = "Good product",
                Discount = 1,
                Price = 10.99m,
                //Quantity = "", 
                Status = true,
                Files = new List<IFormFile>(),
                ProductVariants = new List<NewProductVariant>()
            };

            var mockHubClients = new Mock<IHubClients>();
            var mockClientProxy = new Mock<IClientProxy>();
            mockHubClients.Setup(c => c.All).Returns(mockClientProxy.Object);
            _productHubMock.Setup(h => h.Clients).Returns(mockHubClients.Object);

            var validationContext = new ValidationContext(newProduct, _mockServiceProvider.Object, null);
            var validationResults = new List<ValidationResult>();
            Validator.TryValidateObject(newProduct, validationContext, validationResults, true);

            foreach (var validationResult in validationResults)
            {
                foreach (var memberName in validationResult.MemberNames)
                {
                    _productController.ModelState.AddModelError(memberName, validationResult.ErrorMessage);
                }
            }

            _productController.ModelState.AddModelError("Quantity", "The value '' is not valid for Quantity.");

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.TypeOf<SerializableError>());
        }

        [Test]
        public async Task CreateProduct_InvalidQuantityNull_ReturnsBadRequest()
        {
            // Arrange
            var newProduct = new NewProduct
            {
                Name = "Product1",
                Category = 1,
                Description = "Good product",
                Discount = 1,
                Price = 10.99m,
                Quantity = -1, // Giá trị hợp lệ ban đầu
                Status = true,
                Files = new List<IFormFile>(), // Giả lập các file nếu cần
                ProductVariants = new List<NewProductVariant>()
            };

            var quantityProperty = typeof(NewProduct).GetProperty("Quantity");
            //quantityProperty.SetValue(newProduct, null);  

            // Validate the product object
            var validationContext = new ValidationContext(newProduct, _mockServiceProvider.Object, null);
            var validationResults = new List<ValidationResult>();
            Validator.TryValidateObject(newProduct, validationContext, validationResults, true);

            foreach (var validationResult in validationResults)
            {
                foreach (var memberName in validationResult.MemberNames)
                {
                    _productController.ModelState.AddModelError(memberName, validationResult.ErrorMessage);
                }
            }

            var mockHubClients = new Mock<IHubClients>();
            var mockClientProxy = new Mock<IClientProxy>();
            mockHubClients.Setup(c => c.All).Returns(mockClientProxy.Object);
            _productHubMock.Setup(h => h.Clients).Returns(mockHubClients.Object);

            // Act
            var result = await _productController.CreateProduct(newProduct);

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestObjectResult>());
            var badRequestResult = (BadRequestObjectResult)result;
            Assert.That(badRequestResult.Value, Is.TypeOf<SerializableError>());
        }
    }
}
