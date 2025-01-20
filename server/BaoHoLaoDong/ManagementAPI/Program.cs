using System.Text;
using BusinessLogicLayer.Mappings;
using BusinessLogicLayer.Models;
using BusinessLogicLayer.Services;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository.Interface;
using DataAccessObject.Repository;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);

#region JWT
// Lấy cấu hình JWT từ appsettings.json
var jwtConfig = builder.Configuration.GetSection("Jwt");
// JWT
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
    .AddJwtBearer(options =>
    {
        var token = jwtConfig.Get<Token>(); // Sử dụng Get<T> để dễ dàng ánh xạ cấu hình từ JSON

        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = token.issuer,
            ValidAudience = token.audience,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(token.key))
        };
    });

// Cấu hình Authorization
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("Admin", policy => policy.RequireRole("Admin"));
    options.AddPolicy("Customer", policy => policy.RequireRole("Customer"));
    options.AddPolicy("Manager", policy => policy.RequireRole("Manager"));
    options.AddPolicy("AdminOrManager", policy =>
    {
        policy.RequireRole("Admin", "Manager");
    });
});
#endregion JWT





// Add services to the container.
builder.Services.AddControllers();
  
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add database context
builder.Services.AddDbContext<MinhXuanDatabaseContext>();

// Add AutoMapper
builder.Services.AddAutoMapper(cfg =>
{
    var configuration = builder.Configuration;
    var applicationUrl = configuration["ApplicationSettings:BaseUrl"] ?? "http://localhost:5000";
    cfg.AddProfile(new MappingProfile(applicationUrl));
});


#region services
// Add services from BusinessLogicLayer
builder.Services.AddScoped<IUserService, UserService>();
var imagePathProduct = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images","product");
builder.Services.AddSingleton(imagePathProduct);
builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<IOrderService, OrderService>();
builder.Services.AddScoped<IBlogPostService, BlogPostService>();
// Đọc cấu hình SMTP từ appsettings.json
builder.Services.Configure<EmailSettings>(builder.Configuration.GetSection("EmailSettings"));
// Đăng ký MailService
builder.Services.AddScoped<IMailService, MailService>();
// Add TokenService
builder.Services.AddScoped<TokenService>(provier =>
{
    var token = jwtConfig.Get<Token>();
    return new TokenService(token);
});
#endregion services



// Cấu hình CORS cho phép tất cả
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}




app.UseHttpsRedirection();

app.UseCors("AllowAll"); // Thêm middleware CORS vào pipeline xử lý HTTP
app.UseAuthentication(); 
app.UseAuthorization();
app.UseStaticFiles();
app.MapControllers();

app.Run();