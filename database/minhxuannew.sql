--Go
--use master
---- Tạo cơ sở dữ liệu
--IF EXISTS (SELECT name FROM sys.databases WHERE name = 'MinhXuanDatabase')
--BEGIN
--    -- Nếu cơ sở dữ liệu tồn tại, xóa nó
--    ALTER DATABASE MinhXuanDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--    DROP DATABASE MinhXuanDatabase;
--END
--GO

USE MinhXuanDatabase;
GO
/****** Object:  Table [dbo].[AccountVerifications]    Script Date: 3/8/2025 8:54:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountVerifications](
	[VerificationId] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[AccountType] [nvarchar](50) NOT NULL,
	[VerificationCode] [nvarchar](100) NOT NULL,
	[IsVerified] [bit] NOT NULL,
	[VerificationDate] [datetime] NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VerificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogCategories]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogCategories](
	[CategoryBlogId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryBlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogPosts]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogPosts](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[FileName] [nvarchar](250) NULL,
	[ImageURL] [nvarchar](max) NULL,
	[Status] [varchar](50) NOT NULL,
	[CategoryBlogId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[PasswordHash] [varchar](150) NULL,
	[PhoneNumber] [varchar](10) NULL,
	[Address] [nvarchar](400) NULL,
	[DateOfBirth] [date] NULL,
	[Gender] [bit] NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[UpdateAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[PasswordHash] [varchar](150) NULL,
	[PhoneNumber] [varchar](10) NOT NULL,
	[Address] [nvarchar](400) NULL,
	[DateOfBirth] [date] NULL,
	[Gender] [bit] NULL,
	[Role] [nvarchar](50) NOT NULL,
	[CreateAt] [datetime] NOT NULL,
	[UpdateAt] [datetime] NULL,
	[Status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[InvoiceNumber] [nvarchar](50) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[QRCodeData] [nvarchar](max) NULL,
	[PaymentStatus] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[ImagePath] [varchar] (4000) NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[RecipientId] [int] NOT NULL,
	[RecipientType] [nvarchar](50) NOT NULL,
	[IsRead] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[Status] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ProductName] [nvarchar](250) NOT NULL,
	[ProductPrice] [decimal](18, 2) NOT NULL,
	[ProductDiscount] [decimal](5, 2) NULL,
	[Quantity] [int] NOT NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
	[Size] [nvarchar](50) NULL,
	[Color] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[CustomerInfo] [nvarchar] (4000) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[GroupId] [int] NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategoryGroup]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategoryGroup](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImage](
	[ProductImageId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[FileName] [nvarchar](250) NOT NULL,
	[ImageURL] [nvarchar](max) NULL,
	[Description] [nvarchar](250) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[IsPrimary] [bit] NOT NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductReviews]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductReviews](
	[ReviewId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](250) NOT NULL,
	[CategoryId] [int] NULL,
	[Description] [nvarchar](1200) NULL,
	[Material] [nvarchar](500) NULL,
	[Origin] [nvarchar](500) NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Discount] [decimal](5, 2) NULL,
	[AverageRating] [decimal](3, 2) NULL,
	[QualityCertificate] [nvarchar](1200) NULL,
	[TotalTax] [decimal](5, 2) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTaxes]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTaxes](
	[ProductTaxId] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[TaxID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductTaxId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductVariants]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVariants](
	[VariantId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Size] [nvarchar](50) NULL,
	[Color] [nvarchar](50) NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NULL,
	[Discount] [decimal](5, 2) NULL,
	[Status] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VariantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tax]    Script Date: 3/8/2025 8:54:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tax](
	[TaxID] [int] IDENTITY(1,1) NOT NULL,
	[TaxName] [varchar](100) NOT NULL,
	[TaxRate] [decimal](5, 2) NOT NULL,
	[Description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[TaxID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerId], [FullName], [Email], [IsEmailVerified], [PasswordHash], [PhoneNumber], [Address], [DateOfBirth], [Gender], [CreatedAt], [ImageUrl], [UpdateAt]) VALUES (1, N'k16 Ngô Đình Linh', N'linhndhe163822@fpt.edu.vn', 1, N'$2a$11$cfWFnfL3vkTqThguvbshAO70hi7gOGs3JuBXBUQawMzDQnEAUONIC', NULL, NULL, NULL, NULL, CAST(N'2025-03-07T08:05:19.500' AS DateTime), N'https://lh3.googleusercontent.com/a/ACg8ocICCVFg6OfzQqm5KI2L12Bgul-PBJyMRFsYqL2168eQaAIVzEA=s96-c', NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeId], [FullName], [Email], [PasswordHash], [PhoneNumber], [Address], [DateOfBirth], [Gender], [Role], [CreateAt], [UpdateAt], [Status]) VALUES (1, N'admin', N'ngolinh09032002@gmail.com', N'$2a$11$uQTwwfFB9WBJcvB2PAfg7ejM9Xsp.LJgY/0q82R.4Vk2d4zGvr00G', N'0123456789', N'ha noi', CAST(N'2002-03-09' AS Date), 1, N'Admin', CAST(N'2025-03-07T08:28:38.107' AS DateTime), NULL, N'Active')
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (1, N'Mũ bảo hộ', 1, N'Các loại mũ bảo hộ lao động bảo vệ đầu khỏi va đập và rơi vật nặng.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (2, N'Găng tay bảo hộ', 1, N'Găng tay bảo hộ chống cắt, cách điện, chống hóa chất.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (3, N'Kính bảo hộ', 1, N'Kính bảo hộ chống bụi, chống tia UV, bảo vệ mắt.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (4, N'Giày bảo hộ', 1, N'Giày bảo hộ chống đinh, chống trơn trượt, cách điện.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (5, N'Quần áo bảo hộ', 1, N'Bộ quần áo bảo hộ chống tĩnh điện, chống hóa chất.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (6, N'Khẩu trang bảo hộ', 1, N'Khẩu trang chống bụi mịn, chống hóa chất độc hại.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (7, N'Bịt tai chống ồn', 2, N'Bịt tai giảm tiếng ồn khi làm việc trong môi trường công nghiệp.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (8, N'Áo phản quang', 2, N'Áo phản quang giúp tăng khả năng nhận diện trong điều kiện ánh sáng yếu.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (9, N'Dây đai an toàn', 3, N'Dây đai bảo vệ khi làm việc trên cao, chống ngã.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (10, N'Mặt nạ phòng độc', 3, N'Mặt nạ bảo vệ khỏi khí độc, hơi hóa chất.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (11, N'Găng tay cách điện', 3, N'Găng tay bảo vệ khỏi điện áp cao trong ngành điện lực.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (12, N'Mũ hàn điện tử', 4, N'Mũ hàn tự động đổi màu kính để bảo vệ mắt.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (13, N'Tấm chắn mặt', 4, N'Tấm chắn mặt bảo vệ khỏi hóa chất, bụi bẩn.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (14, N'Giày chống tĩnh điện', 5, N'Giày bảo vệ linh kiện điện tử khỏi tĩnh điện.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (15, N'Bộ đồ chống hóa chất', 6, N'Bộ đồ bảo hộ khi làm việc trong môi trường hóa chất.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (16, N'Bộ sơ cứu y tế', 6, N'Bộ sơ cứu y tế dùng trong trường hợp khẩn cấp.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (17, N'Dây cứu sinh', NULL, N'Dây cứu sinh chịu lực cao cho công trình xây dựng.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (18, N'Áo chống đâm thủng', NULL, N'Áo bảo hộ chống đâm thủng từ vật sắc nhọn.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (19, N'Bốt bảo hộ', NULL, N'Bốt bảo hộ chống nước, chống trơn trượt.')
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (20, N'Túi đựng dụng cụ bảo hộ', NULL, N'Túi đựng dụng cụ bảo hộ an toàn.')
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategoryGroup] ON 

INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (1, N'Trang Thiết bị bảo hộ', N'')
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (2, N'An toàn ngành điện', N'')
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (3, N'An toàn ngành nước', N'')
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (4, N'Thiết bị chống ồn', N'')
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (5, N'Thiết bị phòng độc', N'')
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (6, N'Phòng cháy chữa cháy', N'')
SET IDENTITY_INSERT [dbo].[ProductCategoryGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImage] ON 

INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (1, 11, N'0fbc9e3a-4d02-43cd-9b41-e8d6d407d503.webp', NULL, NULL, CAST(N'2025-03-07T08:44:18.220' AS DateTime), CAST(N'2025-03-07T08:02:25.227' AS DateTime), 1, 0)
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (2, 1, N'5137cc2c-af6d-4c53-ae49-9ab5cccab013.webp', NULL, NULL, CAST(N'2025-03-07T07:46:00.997' AS DateTime), CAST(N'2025-03-07T07:59:20.297' AS DateTime), 0, 0)
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (3, 2, N'd95a0789-21ef-4244-9f3d-176756a0eb34.webp', NULL, NULL, CAST(N'2025-03-07T08:19:04.457' AS DateTime), NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[ProductImage] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (1, N'Mũ bảo hộ lao động ABC', 1, N'Mũ bảo hộ chống va đập, đạt tiêu chuẩn an toàn.', N'Nhựa ABS', N'Việt Nam', 100, CAST(250000.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(4.70 AS Decimal(3, 2)), N'TCVN 6407:1998', CAST(15.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), CAST(N'2025-03-07T08:25:14.257' AS DateTime), 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (2, N'Găng tay chống cắt cấp 5', 2, N'Găng tay bảo hộ chống cắt cấp 5, bảo vệ bàn tay khi làm việc.', N'Sợi HPPE', N'Hàn Quốc', 120, CAST(80000.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(5, 2)), CAST(4.80 AS Decimal(3, 2)), N'EN 388', CAST(5.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), CAST(N'2025-03-07T08:20:27.190' AS DateTime), 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (3, N'Kính bảo hộ chống bụi và tia UV', 3, N'Kính bảo hộ đạt tiêu chuẩn ANSI Z87.1, bảo vệ mắt.', N'Polycarbonate', N'Mỹ', 150, CAST(120000.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(5, 2)), CAST(4.60 AS Decimal(3, 2)), N'ANSI Z87.1', CAST(8.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), CAST(N'2025-03-07T08:21:06.317' AS DateTime), 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (4, N'Giày bảo hộ chống đinh và trượt', 4, N'Giày bảo hộ đạt chuẩn S3, chống đâm xuyên và trơn trượt.', N'Da tổng hợp, đế PU', N'Đức', 90, CAST(850000.00 AS Decimal(18, 2)), CAST(30.00 AS Decimal(5, 2)), CAST(4.90 AS Decimal(3, 2)), N'EN ISO 20345', CAST(12.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), CAST(N'2025-03-07T08:23:03.017' AS DateTime), 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (5, N'Quần áo bảo hộ phòng sạch', 5, N'Bộ quần áo bảo hộ chống bụi, chống tĩnh điện.', N'Vải polyester', N'Nhật Bản', 75, CAST(450000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.70 AS Decimal(3, 2)), N'ISO 14644', CAST(7.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (6, N'Khẩu trang chống bụi mịn N95', 6, N'Khẩu trang bảo vệ khỏi bụi mịn PM2.5, đạt tiêu chuẩn N95.', N'Vải không dệt', N'Việt Nam', 200, CAST(25000.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(5, 2)), CAST(4.50 AS Decimal(3, 2)), N'N95, NIOSH', CAST(3.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), CAST(N'2025-03-07T08:24:43.537' AS DateTime), 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (7, N'Bịt tai chống ồn', 7, N'Bịt tai giảm tiếng ồn hiệu quả, phù hợp môi trường công nghiệp.', N'Mút xốp, nhựa ABS', N'Pháp', 130, CAST(95000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.60 AS Decimal(3, 2)), N'ANSI S3.19', CAST(5.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (8, N'Áo phản quang', 8, N'Áo phản quang giúp tăng khả năng nhận diện trong môi trường tối.', N'Vải lưới, băng phản quang', N'Việt Nam', 180, CAST(60000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.40 AS Decimal(3, 2)), N'TCVN 8856:2010', CAST(4.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (9, N'Dây đai an toàn toàn thân', 9, N'Dây đai an toàn bảo vệ khi làm việc trên cao.', N'Sợi polyester, móc thép', N'Mỹ', 50, CAST(750000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.90 AS Decimal(3, 2)), N'ANSI Z359.1', CAST(12.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (10, N'Mặt nạ phòng độc 3M 6200', 10, N'Mặt nạ bảo hộ chống khí độc, hơi hóa chất.', N'Silicone', N'Mỹ', 60, CAST(550000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.80 AS Decimal(3, 2)), N'EN 140:1998', CAST(10.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (11, N'Găng tay cách điện 35kV', 11, N'Găng tay cách điện bảo vệ khi làm việc với điện áp cao.', N'Cao su cách điện', N'Đức', 40, CAST(650000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.70 AS Decimal(3, 2)), N'IEC 60903', CAST(8.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (12, N'Mũ hàn điện tử tự động', 12, N'Mũ hàn tự động đổi màu kính bảo vệ mắt.', N'Nhựa ABS, kính cảm biến', N'Hàn Quốc', 70, CAST(850000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.90 AS Decimal(3, 2)), N'ANSI Z87.1', CAST(10.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (13, N'Tấm chắn mặt bảo hộ', 13, N'Tấm chắn mặt bảo vệ khỏi hóa chất, tia lửa.', N'Nhựa Polycarbonate', N'Việt Nam', 90, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.60 AS Decimal(3, 2)), N'EN 166', CAST(6.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (14, N'Giày chống tĩnh điện ESD', 14, N'Giày chống tĩnh điện giúp bảo vệ linh kiện điện tử.', N'Da PU, đế PVC', N'Nhật Bản', 80, CAST(400000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.80 AS Decimal(3, 2)), N'ANSI/ESD STM9.1', CAST(7.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (15, N'Bộ đồ chống hóa chất', 15, N'Bộ đồ bảo vệ khi làm việc trong môi trường hóa chất độc hại.', N'Vải chống hóa chất', N'Mỹ', 30, CAST(1200000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.90 AS Decimal(3, 2)), N'EN 14605', CAST(15.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (16, N'Bộ sơ cứu y tế cá nhân', 16, N'Bộ sơ cứu y tế đầy đủ dụng cụ cấp cứu khẩn cấp.', N'Nhựa + vật tư y tế', N'Việt Nam', 100, CAST(180000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.70 AS Decimal(3, 2)), N'CE, FDA', CAST(5.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (17, N'Dây cứu sinh', 17, N'Dây cứu sinh chịu lực cao, sử dụng trong công trình xây dựng.', N'Sợi tổng hợp', N'Pháp', 60, CAST(600000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.80 AS Decimal(3, 2)), N'ANSI Z359.1', CAST(9.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (18, N'Áo chống đâm thủng', 18, N'Áo bảo hộ chống đâm thủng từ vật sắc nhọn.', N'Sợi Kevlar', N'Mỹ', 25, CAST(2500000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(4.90 AS Decimal(3, 2)), N'NIJ 0115.00', CAST(20.00 AS Decimal(5, 2)), CAST(N'2025-03-07T08:28:40.897' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTaxes] ON 

INSERT [dbo].[ProductTaxes] ([ProductTaxId], [ProductID], [TaxID]) VALUES (1, 1, 1)
INSERT [dbo].[ProductTaxes] ([ProductTaxId], [ProductID], [TaxID]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[ProductTaxes] OFF
GO
SET IDENTITY_INSERT [dbo].[Tax] ON 

INSERT [dbo].[Tax] ([TaxID], [TaxName], [TaxRate], [Description]) VALUES (1, N'VAT', CAST(10.00 AS Decimal(5, 2)), N'Thu? giá tr? gia tăng')
INSERT [dbo].[Tax] ([TaxID], [TaxName], [TaxRate], [Description]) VALUES (2, N'Import Tax', CAST(5.00 AS Decimal(5, 2)), N'Thu? nh?p kh?u')
INSERT [dbo].[Tax] ([TaxID], [TaxName], [TaxRate], [Description]) VALUES (3, N'Environmental Tax', CAST(2.00 AS Decimal(5, 2)), N'Thu? môi trư?ng')
SET IDENTITY_INSERT [dbo].[Tax] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__A9D105341C40389D]    Script Date: 3/8/2025 8:54:14 AM ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Employee__A9D10534477075AD]    Script Date: 3/8/2025 8:54:14 AM ******/
ALTER TABLE [dbo].[Employees] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Invoices__D776E981097972E6]    Script Date: 3/8/2025 8:54:14 AM ******/
ALTER TABLE [dbo].[Invoices] ADD UNIQUE NONCLUSTERED 
(
	[InvoiceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ProductI__589E6EEC4DAA3631]    Script Date: 3/8/2025 8:54:14 AM ******/
ALTER TABLE [dbo].[ProductImage] ADD UNIQUE NONCLUSTERED 
(
	[FileName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__ProductT__631D78E4A19A8122]    Script Date: 3/8/2025 8:54:14 AM ******/
ALTER TABLE [dbo].[ProductTaxes] ADD UNIQUE NONCLUSTERED 
(
	[ProductID] ASC,
	[TaxID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountVerifications] ADD  DEFAULT ((0)) FOR [IsVerified]
GO
ALTER TABLE [dbo].[AccountVerifications] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[BlogPosts] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[BlogPosts] ADD  DEFAULT ('Draft') FOR [Status]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT ((0)) FOR [IsEmailVerified]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT ('Active') FOR [Status]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ('Paid') FOR [Status]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ('Active') FOR [Status]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  DEFAULT ((0.00)) FOR [ProductDiscount]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[ProductImage] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ProductImage] ADD  DEFAULT ((0)) FOR [IsPrimary]
GO
ALTER TABLE [dbo].[ProductImage] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ProductReviews] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0.00)) FOR [Discount]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0.00)) FOR [AverageRating]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT ((0.00)) FOR [Discount]
GO
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[AccountVerifications]  WITH CHECK ADD  CONSTRAINT [FK_AccountVerifications_Customers] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccountVerifications] CHECK CONSTRAINT [FK_AccountVerifications_Customers]
GO
ALTER TABLE [dbo].[BlogPosts]  WITH CHECK ADD  CONSTRAINT [FK_BlogPosts_BlogCategories] FOREIGN KEY([CategoryBlogId])
REFERENCES [dbo].[BlogCategories] ([CategoryBlogId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[BlogPosts] CHECK CONSTRAINT [FK_BlogPosts_BlogCategories]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Receipts_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Receipts_Orders]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Customers] FOREIGN KEY([RecipientId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Customers]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Employees] FOREIGN KEY([RecipientId])
REFERENCES [dbo].[Employees] ([EmployeeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Employees]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_ProductCategoryGroup] FOREIGN KEY([GroupId])
REFERENCES [dbo].[ProductCategoryGroup] ([GroupId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_ProductCategoryGroup]
GO
ALTER TABLE [dbo].[ProductImage]  WITH CHECK ADD  CONSTRAINT [FK_ProductImage_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductImage] CHECK CONSTRAINT [FK_ProductImage_Product]
GO
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviews_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReviews] CHECK CONSTRAINT [FK_ProductReviews_Customers]
GO
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviews_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReviews] CHECK CONSTRAINT [FK_ProductReviews_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[ProductCategory] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category]
GO
ALTER TABLE [dbo].[ProductTaxes]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductTaxes]  WITH CHECK ADD FOREIGN KEY([TaxID])
REFERENCES [dbo].[Tax] ([TaxID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductVariants]  WITH CHECK ADD  CONSTRAINT [FK_ProductVariants_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductVariants] CHECK CONSTRAINT [FK_ProductVariants_Products]
GO
ALTER TABLE [dbo].[AccountVerifications]  WITH CHECK ADD CHECK  (([AccountType]='Employee' OR [AccountType]='Customer'))
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CHK_Gender] CHECK  (([Gender]=(1) OR [Gender]=(0)))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CHK_Gender]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_Role] CHECK  (([Role]='Manager' OR [Role]='Admin'))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CHK_Role]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_Status] CHECK  (([Status]='Suspended' OR [Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CHK_Status]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD CHECK  (([RecipientType]='Employee' OR [RecipientType]='Customer'))
GO
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
