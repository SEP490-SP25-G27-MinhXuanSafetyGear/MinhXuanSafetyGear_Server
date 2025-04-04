USE [master]
GO
/****** Object:  Database [MinhXuanDatabase]    Script Date: 4/4/2025 5:32:37 PM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'MinhXuanDatabase')
BEGIN
CREATE DATABASE [MinhXuanDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MinhXuanDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MinhXuanDatabase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MinhXuanDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MinhXuanDatabase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
END
GO
ALTER DATABASE [MinhXuanDatabase] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MinhXuanDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MinhXuanDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MinhXuanDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MinhXuanDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MinhXuanDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MinhXuanDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MinhXuanDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MinhXuanDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [MinhXuanDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MinhXuanDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MinhXuanDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MinhXuanDatabase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MinhXuanDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MinhXuanDatabase] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MinhXuanDatabase] SET QUERY_STORE = ON
GO
ALTER DATABASE [MinhXuanDatabase] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MinhXuanDatabase]
GO
/****** Object:  Table [dbo].[AccountVerifications]    Script Date: 4/4/2025 5:32:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccountVerifications]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[BlogCategories]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BlogCategories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BlogCategories](
	[CategoryBlogId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Slug] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryBlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BlogPosts]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BlogPosts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BlogPosts](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[PostURL] [nvarchar](500) NULL,
	[Slug] [nvarchar](255) NOT NULL,
	[CategoryBlogId] [int] NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Summary] [nvarchar](500) NULL,
	[Tags] [nvarchar](255) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[CreateBy] [int] NULL,
	[UpdateBy] [int] NULL,
	[Status] [varchar](50) NOT NULL,
	[FileName] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customers]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[PasswordHash] [varchar](150) NULL,
	[PhoneNumber] [varchar](10) NOT NULL,
	[Address] [nvarchar](400) NULL,
	[DateOfBirth] [date] NULL,
	[Gender] [bit] NULL,
	[RoleId] [int] NOT NULL,
	[CreateAt] [datetime] NOT NULL,
	[UpdateAt] [datetime] NULL,
	[Status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoices]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoices](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[InvoiceNumber] [nvarchar](50) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[QRCodeData] [nvarchar](max) NULL,
	[PaymentStatus] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentConfirmOfCustomer] [bit] NULL,
	[ImagePath] [varchar](4000) NULL,
	[FileName] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Notifications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Notifications](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[RecipientId] [int] NULL,
	[RecipientType] [nvarchar](50) NOT NULL,
	[IsRead] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[OrderId] [int] NULL,
	[Status] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[VariantId] [int] NULL,
	[ProductName] [nvarchar](250) NOT NULL,
	[ProductPrice] [decimal](18, 2) NOT NULL,
	[ProductDiscount] [decimal](5, 2) NOT NULL,
	[ProductTax] [decimal](5, 2) NULL,
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
END
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[CustomerPhone] [nvarchar](10) NOT NULL,
	[CustomerEmail] [nvarchar](100) NULL,
	[CustomerAddress] [nvarchar](500) NULL,
	[Notes] [nvarchar](500) NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductCategory]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[ProductCategoryGroup]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductCategoryGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductCategoryGroup](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductImage]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[ProductReviews]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductReviews]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[Products]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](250) NOT NULL,
	[Slug] [nvarchar](250) NOT NULL,
	[CategoryId] [int] NULL,
	[Description] [nvarchar](1200) NULL,
	[Material] [nvarchar](500) NULL,
	[Origin] [nvarchar](500) NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Discount] [decimal](5, 2) NULL,
	[AverageRating] [decimal](4, 2) NULL,
	[TotalSale] [int] NULL,
	[FreeShip] [bit] NULL,
	[Guarantee] [int] NULL,
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
END
GO
/****** Object:  Table [dbo].[ProductTaxes]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductTaxes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductTaxes](
	[ProductTaxId] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[TaxID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductTaxId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProductVariants]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductVariants]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductVariants](
	[VariantId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Size] [nvarchar](50) NULL,
	[Color] [nvarchar](50) NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NULL,
	[Discount] [decimal](5, 2) NOT NULL,
	[Status] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VariantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Tax]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tax]') AND type in (N'U'))
BEGIN
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
END
GO
SET IDENTITY_INSERT [dbo].[BlogCategories] ON 
GO
INSERT [dbo].[BlogCategories] ([CategoryBlogId], [CategoryName], [Slug], [Description]) VALUES (1, N'Liên hệ', N'lien-he', N'')
GO
INSERT [dbo].[BlogCategories] ([CategoryBlogId], [CategoryName], [Slug], [Description]) VALUES (2, N'Chính Sách', N'chinh-sach', NULL)
GO
INSERT [dbo].[BlogCategories] ([CategoryBlogId], [CategoryName], [Slug], [Description]) VALUES (3, N'Hướng Dẫn', N'huong-dan', NULL)
GO
INSERT [dbo].[BlogCategories] ([CategoryBlogId], [CategoryName], [Slug], [Description]) VALUES (4, N'KIẾN THỨC AN TOÀN LAO ĐỘNG', N'kien-thuc-an-toan-lao-dong', NULL)
GO
INSERT [dbo].[BlogCategories] ([CategoryBlogId], [CategoryName], [Slug], [Description]) VALUES (5, N'Banner', N'banner', NULL)
GO
INSERT [dbo].[BlogCategories] ([CategoryBlogId], [CategoryName], [Slug], [Description]) VALUES (6, N'Khách Hàng Nói về Chúng tôi', N'khach-hang-noi-ve-chung-toi', NULL)
GO
SET IDENTITY_INSERT [dbo].[BlogCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[BlogPosts] ON 
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (1, N'Địa chỉ', NULL, N'dia-chi', 1, N'Hai Bà Trưng, Hà Nội', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (2, N'Điện thoại', NULL, N'dien-thoai', 1, N'0912.423.062', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (3, N'Email', NULL, N'email', 1, N'minhxuanbhld@gmail.com', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (4, N'Zalo', NULL, N'zalo', 1, N'0912.423.062', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (5, N'Chính sách mua hàng', NULL, N'chinh-sach-mua-hang', 2, N'<p>Quý khách có thể mua hàng qua:</p><ul><li>Trực tiếp tại cửa hàng.</li><li>Đặt hàng qua website,hoặc hotline.</li><li>Mua hàng sỉ theo hợp đồng (đối với doanh nghiệp).</li></ul><p>Hỗ trợ tư vấn sản phẩm phù hợp theo nhu cầu sử dụng (công trình, cơ khí, điện lực, thực phẩm…).</p>', N'null', N'null', CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (6, N'Chính sách thanh toán', NULL, N'chinh-sach-thanh-toan', 2, N'', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (7, N'Chính sách vận chuyển', NULL, N'chinh-sach-van-chuyen', 2, N'<ul><li><strong>Giao hàng toàn quốc</strong> qua các đơn vị vận chuyển uy tín (GHN, GHTK, Viettel Post,…).</li><li>Miễn phí giao hàng với đơn từ 2.000.000đ trở lên (áp dụng nội thành HN/HCM).</li><li>Thời gian giao hàng: 1 – 5 ngày tùy khu vực.</li></ul>', N'null', N'null', CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (8, N'Hướng dẫn mua hàng', NULL, N'huong-dan-mua-hang', 3, N'', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (9, N'Hướng dẫn đổi trả', NULL, N'huong-dan-doi-tra', 3, N'', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (10, N'Hướng dẫn chuyển khoản', NULL, N'huong-dan-chuyen-khoan', 3, N'', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (11, N'Hướng dẫn trả góp', NULL, N'huong-dan-tra-gop', 3, N'', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (12, N'Hướng dẫn hoàn hàng', NULL, N'huong-dan-hoan-hang', 3, N'', NULL, NULL, CAST(N'2025-04-07T23:39:46.747' AS DateTime), NULL, NULL, NULL, N'Draft', NULL)
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (13, N'Banner1', NULL, N'banner1', 5, N'<p>banner1</p>', N'Banner1', NULL, CAST(N'2025-04-07T23:43:41.427' AS DateTime), NULL, NULL, NULL, N'Published', N'02a48656-8522-4e52-bfd1-eb902ad176bf.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (14, N'Banner2', NULL, N'banner2', 5, N'<p>Banner2<span class="ql-cursor">﻿</span></p>', N'Banner2', NULL, CAST(N'2025-04-07T23:44:07.940' AS DateTime), NULL, NULL, NULL, N'Published', N'e187206f-b2d1-4fd7-9188-c8c54555c904.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (15, N'Banner3', NULL, N'banner3', 5, N'<p>Banner3<span class="ql-cursor">﻿</span></p>', N'Banner3', NULL, CAST(N'2025-04-07T23:44:31.147' AS DateTime), NULL, NULL, NULL, N'Published', N'e078f70e-fbe1-4dde-833b-0704c84991de.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (16, N'Anh Minh', NULL, N'anh-minh', 6, N'<p>"Tôi đã mua bộ đồ bảo hộ tại cửa hàng và rất hài lòng với chất lượng. Áo quần chắc chắn, vải dày nhưng vẫn thoáng, chịu được môi trường bụi bẩn và nắng gắt. Mũ bảo hộ có lớp lót bên trong giúp đội lâu mà không bị đau đầu. Tôi sẽ tiếp tục đặt hàng cho đội công trình của mình."</p>', N'Kỹ sư công trình', NULL, CAST(N'2025-04-07T23:47:06.863' AS DateTime), NULL, NULL, NULL, N'Published', N'51b660a9-10d6-4a9e-9e76-894c2abe06f9.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (17, N'Chị Hồng', NULL, N'chi-hong', 6, N'<p>"Tôi đặt 20 bộ bảo hộ cho thợ trong xưởng, hàng giao đúng hẹn và chất lượng vượt mong đợi. Găng tay chịu nhiệt tốt, ủng chống trơn rất an toàn. Nhân viên tư vấn rất chuyên nghiệp và hỗ trợ nhiệt tình. Sẽ tiếp tục hợp tác lâu dài."</p>', N' Chủ xưởng cơ khí', N'null', CAST(N'2025-04-07T23:47:30.763' AS DateTime), NULL, NULL, NULL, N'Published', N'd2950529-63e9-4a9d-ac7c-0fb72dc5f62f.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (18, N'Anh Tùng', NULL, N'anh-tung', 6, N'<p>"Găng tay hàn và kính chắn tia UV ở đây dùng rất bền. Không bị rách sau vài lần dùng như mấy chỗ trước tôi mua. Cảm ơn shop đã giới thiệu đúng sản phẩm tôi cần!"</p>', N'Thợ hàn', NULL, CAST(N'2025-04-07T23:47:58.343' AS DateTime), NULL, NULL, NULL, N'Published', N'f7734b2b-aaaa-4ee5-bdf9-a9f0647245a7.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (19, N'Công ty TNHH Thành Đạt ', NULL, N'cong-ty-tnhh-thanh-dat', 6, N'<p>"Công ty chúng tôi đã tìm kiếm đối tác cung cấp thiết bị bảo hộ đạt chuẩn cho công nhân. Sau nhiều đơn vị, chúng tôi chọn bên bạn vì chất lượng ổn định, giá cả hợp lý và dịch vụ hậu mãi tốt. Sản phẩm luôn đầy đủ chứng nhận an toàn."</p>', N'Đại diện phòng vật tư', N'null', CAST(N'2025-04-07T23:48:25.737' AS DateTime), NULL, NULL, NULL, N'Published', N'7c2bd3dd-5997-4be2-81cb-714ebb426f53.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (20, N' Anh Dũng', NULL, N'anh-dung', 6, N'<p>"Nhân viên kho của tôi thường xuyên phải nâng vác hàng hóa. Giày bảo hộ mua từ bên bạn giúp họ an toàn hơn rất nhiều. Đế giày chống trơn, mũi giày chịu lực, lại không quá nặng nên đi thoải mái cả ngày."</p>', N'Quản lý kho', N'null', CAST(N'2025-04-07T23:48:58.307' AS DateTime), NULL, NULL, NULL, N'Published', N'3baf499d-d393-40e2-aac3-2b1d3ee3ef03.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (21, N'Chị Lan', NULL, N'chi-lan', 6, N'<p>"Tôi đặc biệt ấn tượng với khẩu trang chống bụi mịn bên bạn. Vừa khít mặt, không bị hở như các loại thường. Nhân viên mình làm việc trong môi trường bụi nhiều, từ khi dùng khẩu trang này thấy đỡ ho hẳn."</p>', N'Mua hàng ngành may mặc', N'null', CAST(N'2025-04-07T23:49:34.780' AS DateTime), NULL, NULL, NULL, N'Published', N'e631f418-dce1-4b40-8d6e-ba51b712a685.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (22, N'Cô Thảo', NULL, N'co-thao', 6, N'<p>"Chúng tôi yêu cầu trang phục bảo hộ phải sạch sẽ, thoáng mát, và đúng quy chuẩn HACCP. Bộ đồ của shop đáp ứng rất tốt, nhân viên mặc cảm thấy thoải mái trong ca làm việc dài."</p>', N'Quản lý nhà máy thực phẩm', N'null', CAST(N'2025-04-07T23:50:06.420' AS DateTime), NULL, NULL, NULL, N'Published', N'76de083b-7037-4a4a-98cd-37de7e6dcf41.webp')
GO
INSERT [dbo].[BlogPosts] ([PostId], [Title], [PostURL], [Slug], [CategoryBlogId], [Content], [Summary], [Tags], [CreatedAt], [UpdatedAt], [CreateBy], [UpdateBy], [Status], [FileName]) VALUES (23, N'Anh Quang', NULL, N'anh-quang', 6, N'<p>"Tôi dùng giày chống tĩnh điện và găng tay cách điện mua tại shop. Hoàn toàn yên tâm khi làm việc. Sản phẩm có đầy đủ tem nhãn, rõ nguồn gốc và được kiểm định chất lượng."</p>', N' Kỹ thuật viên điện', NULL, CAST(N'2025-04-07T23:50:40.210' AS DateTime), NULL, NULL, NULL, N'Published', N'91bc2343-4ed6-49dd-889e-3142ad42cd2b.webp')
GO
SET IDENTITY_INSERT [dbo].[BlogPosts] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 
GO
INSERT [dbo].[Employees] ([EmployeeId], [FullName], [Email], [PasswordHash], [PhoneNumber], [Address], [DateOfBirth], [Gender], [RoleId], [CreateAt], [UpdateAt], [Status]) VALUES (1, N'admin', N'admin@gmail.com', N'$2a$11$uQTwwfFB9WBJcvB2PAfg7ejM9Xsp.LJgY/0q82R.4Vk2d4zGvr00G', N'0123456789', N'ha noi', CAST(N'2002-03-09' AS Date), 1, 1, CAST(N'2025-04-07T23:39:46.727' AS DateTime), NULL, N'Active')
GO
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (1, N'Mũ bảo hộ', 1, N'Các loại mũ bảo hộ lao động bảo vệ đầu khỏi va đập và rơi vật nặng.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (2, N'Găng tay bảo hộ', 1, N'Găng tay bảo hộ chống cắt, cách điện, chống hóa chất.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (3, N'Kính bảo hộ', 1, N'Kính bảo hộ chống bụi, chống tia UV, bảo vệ mắt.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (4, N'Giày da,giày vải', 1, N'Giày bảo hộ chống đinh, chống trơn trượt, cách điện.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (5, N'Quần áo bảo hộ', 1, N'Bộ quần áo bảo hộ chống tĩnh điện, chống hóa chất.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (6, N'Khẩu trang bảo hộ', 1, N'Khẩu trang chống bụi mịn, chống hóa chất độc hại.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (7, N' Chụp tai chống ồn, nút nhét tai sử dụng nhiều lần', 4, N'Bịt tai giảm tiếng ồn khi làm việc trong môi trường công nghiệp.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (8, N'Áo phản quang', 2, N'Áo phản quang giúp tăng khả năng nhận diện trong điều kiện ánh sáng yếu.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (9, N'Dây đai an toàn', 1, N'Dây đai bảo vệ khi làm việc trên cao, chống ngã.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (10, N'Mặt nạ phòng độc', 5, N'Mặt nạ bảo vệ khỏi khí độc, hơi hóa chất.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (11, N'Găng tay cách điện', 2, N'Găng tay bảo vệ khỏi điện áp cao trong ngành điện lực.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (12, N'Mũ hàn điện tử', 4, N'Mũ hàn tự động đổi màu kính để bảo vệ mắt.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (13, N'Tấm chắn mặt', 4, N'Tấm chắn mặt bảo vệ khỏi hóa chất, bụi bẩn.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (14, N'Giày chống tĩnh điện', 5, N'Giày bảo vệ linh kiện điện tử khỏi tĩnh điện.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (15, N'Bộ đồ chống hóa chất', 5, N'Bộ đồ bảo hộ khi làm việc trong môi trường hóa chất.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (16, N'Bình cứu hoả Ôtô, bình cứu hoả MFZ4; MFZL4...', 6, N'')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (17, N'Dây cứu sinh', NULL, N'Dây cứu sinh chịu lực cao cho công trình xây dựng.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (18, N'Áo chống đâm thủng', NULL, N'Áo bảo hộ chống đâm thủng từ vật sắc nhọn.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (19, N'Bốt bảo hộ', NULL, N'Bốt bảo hộ chống nước, chống trơn trượt.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (20, N'Túi đựng dụng cụ bảo hộ', NULL, N'Túi đựng dụng cụ bảo hộ an toàn.')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (21, N'Quần áo blu, công nghệ, mũ, khẩu trang y tế', 1, N'Quần áo blu, công nghệ, mũ, khẩu trang y tế')
GO
INSERT [dbo].[ProductCategory] ([CategoryId], [CategoryName], [GroupId], [Description]) VALUES (22, N'Phao cứu sinh,áo phao', 3, N'')
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategoryGroup] ON 
GO
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (1, N'Trang Thiết bị bảo hộ', N'')
GO
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (2, N'An toàn ngành điện', N'')
GO
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (3, N'An toàn ngành nước', N'')
GO
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (4, N'Thiết bị chống ồn', N'')
GO
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (5, N'Thiết bị phòng độc', N'')
GO
INSERT [dbo].[ProductCategoryGroup] ([GroupId], [GroupName], [Description]) VALUES (6, N'Phòng cháy chữa cháy', N'')
GO
SET IDENTITY_INSERT [dbo].[ProductCategoryGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImage] ON 
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (1, 1, N'ba2fedf9-9df3-4c5a-8c1e-24b5eb22fb49.webp', NULL, NULL, CAST(N'2025-04-07T23:55:41.303' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (2, 2, N'4a17fe0d-dd5f-42ca-a5a7-4c48928cbd1b.webp', NULL, NULL, CAST(N'2025-04-07T22:59:19.590' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (3, 3, N'923936d2-87db-4edf-bb95-b41c8f73d3f0.webp', NULL, NULL, CAST(N'2025-04-07T23:03:58.617' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (4, 4, N'd253883b-48bf-4a27-bb9b-ce6d140e822c.webp', NULL, NULL, CAST(N'2025-04-07T23:07:23.100' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (5, 5, N'894c9be4-0059-4e85-9a89-3aef4b387a52.webp', NULL, NULL, CAST(N'2025-04-07T23:13:47.170' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (6, 6, N'f2153b9e-51a7-4cb9-abbc-9878c292a44e.webp', NULL, NULL, CAST(N'2025-04-07T23:18:43.437' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (7, 7, N'7c076311-0df9-4aea-8fa6-d96e339db8fc.webp', NULL, NULL, CAST(N'2025-04-07T23:24:00.033' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (8, 8, N'6b0cd874-637d-424e-8120-b884cbbcf833.webp', NULL, NULL, CAST(N'2025-04-07T23:26:21.790' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (9, 9, N'a8f37240-a078-48be-a0be-8000def8ff06.webp', NULL, NULL, CAST(N'2025-04-07T23:27:53.803' AS DateTime), NULL, 1, 0)
GO
INSERT [dbo].[ProductImage] ([ProductImageId], [ProductId], [FileName], [ImageURL], [Description], [CreatedAt], [UpdatedAt], [IsPrimary], [Status]) VALUES (10, 10, N'206090f9-56bb-4de9-a028-b85fea51fad6.webp', NULL, NULL, CAST(N'2025-04-07T23:31:53.400' AS DateTime), NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[ProductImage] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (1, N'Mũ bảo hộ lao động kết hợp kính che mặt', N'mu-bao-ho-lao-dong-ket-hop-kinh-che-mat', 1, N'<ul><li>Mũ nhựa ABS kết hợp kính chắn bụi FC45 và gọng gắn kính A2</li><li>Dùng trong các nhà máy, xí nghiệp mài bảo vệ mặt, mắt và đầu</li></ul>', N'Nhựa ABS', N'Việt Nam', 101, CAST(125000.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 1, 0, N'<p><br></p>', CAST(10.00 AS Decimal(5, 2)), CAST(N'2025-04-07T23:55:39.560' AS DateTime), CAST(N'2025-04-07T23:37:11.490' AS DateTime), 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (2, N'Mũ chùm đầu hàn hồ quang', N'mu-chum-dau-han-ho-quang', 1, N'<p>Mũ hàn chùm đầu chất liệu da nhập ngoại 100%</p><p>Mũ&nbsp;hàn chùm đầu bằng da NP-901 Blue Eagle - Đài Loan nhẹ rất thích hợp&nbsp;cho&nbsp;hàn Hồ Quang đảm&nbsp;bảo&nbsp;an toàn tuyệt đối khi sử dụng. Kính hàn đạt tiêu chuẩn:&nbsp;ANSI Z87.1</p><p><br></p><p>Sản phẩm của Tập Đoàn Blue Eagle - Đài Loan</p>', N'Da NP-901', N'Tập Đoàn Blue Eagle - Đài Loan', 100, CAST(250000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 1, 0, N'<p> </p>', NULL, CAST(N'2025-04-07T22:59:18.357' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (3, N'Giầy da trơn mũi bịt sắt', N'giay-da-tron-mui-bit-sat', 4, N'<p>Giầy da trơn mũi bịt sắt thấp cổ đế kếp</p><p>Giầy da đế kếp chống dầu, chống đinh, mũi bịt sắt, chống trơn trợt, da sần</p>', N'Da', N'Việt Nam', 140, CAST(250000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 0, 0, N'<p> </p>', NULL, CAST(N'2025-04-07T23:03:57.570' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (4, N'Giày da bảo hộ lao động 136-93A', N'giay-da-bao-ho-lao-dong-136-93a', 4, N'<p>Giầy bảo hộ dạng cao cổ</p><p>- Làm từ da thật chất lượng cao</p><p>- Lớp thép ở mũi giày có khả năng chống được va đập ở mức 200J</p><p><strong>- Đế giầy có khả năng:</strong></p><p>+ Lớp thép ở đế giày có khả năng chống được lực đâm xuyên ở mức 1100 N</p><p>+ Đế giày được làm từ cao su tổng hợp nên có độ bền cao và dễ uốn nên tạo cảm giấc thoải mái khi sử dụng</p><p>+ Cấu tạo của đế giày có khả năng giảm sóc tốt&nbsp;&nbsp;giúp cho người sử dụng tránh được hiện tượng đau cột sống</p><p>+ Chống dầu nhớt: giúp cho việc sử dụng trong môi trường có dầu nhớt mà giầy không bị biến dạng hoặc hỏng</p><p>+ Chống được kiềm và axit thông thường</p><p>+ Chống trơn trượt: đế giầy có độ bám tốt</p><p>+ Lớp lót bên trong đế giày được làm từ vật liệu Polyamide có khả năng hút là làm khô nhanh mồ hôi</p><p>+ Đế giày chịu được nhiệt độ 300oC</p><p><strong>Nhãn mác trên từng sản phẩm đều thể hiện rõ: thời gian sản xuất, tiêu chuẩn sản xuất, nhà sản xuât</strong></p><p>Tiêu chuẩn Châu Âu&nbsp;<strong>CE</strong>&nbsp;&nbsp;<strong>EN 345-1: 1993</strong></p><p>Nhà sản xuất&nbsp;:&nbsp;<strong>Oscar/Malaysia</strong></p><p><br></p>', N'Polyamide', N'Oscar/Malaysia', 100, CAST(300000.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 0, 0, N'<p><strong>CE</strong>&nbsp;&nbsp;<strong>EN 345-1: 1993</strong></p>', NULL, CAST(N'2025-04-07T23:07:22.370' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (5, N'Quần áo blu MS 01', N'quan-ao-blu-ms-01', 21, N'<p>Quần áo blu MS 01. Do chính Công ty Minh Xuân sản xuất theo yêu cầu của quý khách</p><p>Quần áo blu MS 01. Do chính Công ty Minh Xuân sản xuất theo yêu cầu của quý khách. Chất liệu vải thô, vải lon, vải kaki.</p><p><br></p>', N'vải thô, vải lon, vải kaki.', N'Việt Nam', 150, CAST(230000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 1, 0, N'<p> </p>', NULL, CAST(N'2025-04-07T23:13:46.687' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (6, N'Găng tay cách điện MS01', N'gang-tay-cach-dien-ms01', 11, N'<p>Găng tay cách điện hạ thế, trung thế và cao thế</p><p>Tên hàng - <strong>Găng cách điện hạ thế - trung thế</strong></p><p>Điện áp sử dụng 0.4/1KV - 10 KV - 15KV - 22/24KV - 35KV</p><p>Tần số hoạt động 50/50HZ</p>', N'Cao su', N'Việt Nam', 100, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 0, 12, N'<p>IEC và TCVN 5586-1991</p>', NULL, CAST(N'2025-04-07T23:18:42.287' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (7, N'Áo phao', N'ao-phao', 22, N'<p>Chất liệu vải gió, xốp</p><p>Áo phao dùng trong ngành sông nước, người lớn và trẻ em đều có thể sử dụng, rất an toàn khi mặc áo phao vào người</p>', NULL, N'Việt Nam', 100, CAST(70000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 0, 0, N'<p> </p>', NULL, CAST(N'2025-04-07T23:23:58.890' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (8, N'Phông chống ồn kết hợp mũ BHLĐ', N'phong-chong-on-ket-hop-mu-bhld', 7, N'<p>Phông chống ồn kết hợp mũ BHLĐ có thể làm việc trên cao và chịu được những tiếng ồn lớn, dùng trong các nhà máy, xí nghiệp, công trình xây dựng</p>', N'Nhựa ABS', N'Việt Nam', 100, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 0, 0, N'<p> </p>', NULL, CAST(N'2025-04-07T23:26:20.877' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (9, N'Mặt nạ phòng độc 3M', N'mat-na-phong-doc-3m', 10, N'<p>Mặt nạ phòng độc 3M có tác dụng chống lại các mùi khí độc hại</p>', NULL, NULL, 50, CAST(350000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 0, 12, N'<p> </p>', NULL, CAST(N'2025-04-07T23:27:53.073' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductName], [Slug], [CategoryId], [Description], [Material], [Origin], [Quantity], [Price], [Discount], [AverageRating], [TotalSale], [FreeShip], [Guarantee], [QualityCertificate], [TotalTax], [CreatedAt], [UpdatedAt], [Status]) VALUES (10, N'Bình bột chữa cháy MFZ1, MFZ2, MFZ4', N'binh-bot-chua-chay-mfz1-mfz2-mfz4', 16, N'<p>Bình bột chữa cháy trước khi sử dụng phải lắc bình và rút chốt an toàn, khoảng cách an toàn để dập lửa là 3 mét đối với đám cháy nhỏ, rút&nbsp;chốt chĩa thẳng vói vào đám cháy và kẹp tay cầm.</p><p>&nbsp;</p><p>Hộp cứu hỏa dùng để đựng bình và đựng vòi cứu hỏa dùng trong toàn bộ các ngành cơ quan xí nghiệp, nhà xưởng, bệnh viện, trường học...</p>', NULL, N'Việt Nam', 100, CAST(350000.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(4, 2)), 0, 0, 12, N'<p> </p>', NULL, CAST(N'2025-04-07T23:31:52.833' AS DateTime), NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTaxes] ON 
GO
INSERT [dbo].[ProductTaxes] ([ProductTaxId], [ProductID], [TaxID]) VALUES (1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[ProductTaxes] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductVariants] ON 
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (1, 1, N'L(58 - 62 cm)', N'Vàng', 101, CAST(125000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:55:39.367' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (2, 2, N'L', N'Xám', 100, CAST(250000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T15:59:18.350' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (3, 3, N'38', N'Đen', 50, CAST(250000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:03:57.553' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (4, 3, N'39', N'Đen', 50, CAST(250000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:03:57.553' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (5, 3, N'40', N'Đen', 40, CAST(250000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:03:57.553' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (6, 4, N'38', N'Đen', 50, CAST(300000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:07:22.367' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (7, 4, N'39', N'Đen', 50, CAST(300000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:07:22.367' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (8, 5, N'M', N'Trắng', 50, CAST(230000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:13:46.677' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (9, 5, N'L', N'Trắng', 50, CAST(230000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:13:46.677' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (10, 5, N'XL', N'Trắng', 50, CAST(230000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:13:46.677' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (11, 6, N'L', N'Vàng', 100, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:18:42.280' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (12, 7, N'L', N'Đỏ', 100, CAST(70000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:23:58.883' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (13, 8, N'L(58 - 62 cm)', N'Đỏ', 100, CAST(150000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:26:20.870' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (14, 10, N'M', N'Đỏ', 50, CAST(350000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:31:52.830' AS DateTime), NULL)
GO
INSERT [dbo].[ProductVariants] ([VariantId], [ProductId], [Size], [Color], [Quantity], [Price], [Discount], [Status], [CreatedAt], [UpdatedAt]) VALUES (15, 10, N'L', N'Đỏ', 50, CAST(370000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(5, 2)), 1, CAST(N'2025-04-07T16:31:52.830' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[ProductVariants] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([RoleId], [Name], [Description]) VALUES (1, N'Admin', NULL)
GO
INSERT [dbo].[Roles] ([RoleId], [Name], [Description]) VALUES (2, N'Manager', NULL)
GO
INSERT [dbo].[Roles] ([RoleId], [Name], [Description]) VALUES (3, N'Admin', NULL)
GO
INSERT [dbo].[Roles] ([RoleId], [Name], [Description]) VALUES (4, N'Manager', NULL)
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Tax] ON 
GO
INSERT [dbo].[Tax] ([TaxID], [TaxName], [TaxRate], [Description]) VALUES (1, N'VAT', CAST(10.00 AS Decimal(5, 2)), N'Thu? giá tr? gia tăng')
GO
INSERT [dbo].[Tax] ([TaxID], [TaxName], [TaxRate], [Description]) VALUES (2, N'Import Tax', CAST(5.00 AS Decimal(5, 2)), N'Thu? nh?p kh?u')
GO
INSERT [dbo].[Tax] ([TaxID], [TaxName], [TaxRate], [Description]) VALUES (3, N'Environmental Tax', CAST(2.00 AS Decimal(5, 2)), N'Thu? môi trư?ng')
GO
SET IDENTITY_INSERT [dbo].[Tax] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__BlogCate__BC7B5FB67FA630F8]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BlogCategories]') AND name = N'UQ__BlogCate__BC7B5FB67FA630F8')
ALTER TABLE [dbo].[BlogCategories] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__BlogPost__BC7B5FB6492D10E5]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BlogPosts]') AND name = N'UQ__BlogPost__BC7B5FB6492D10E5')
ALTER TABLE [dbo].[BlogPosts] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__A9D10534B6542203]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Customers]') AND name = N'UQ__Customer__A9D10534B6542203')
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Employee__A9D10534CF67CDFB]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND name = N'UQ__Employee__A9D10534CF67CDFB')
ALTER TABLE [dbo].[Employees] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Invoices__C3905BCEC2FC355E]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoices]') AND name = N'UQ__Invoices__C3905BCEC2FC355E')
ALTER TABLE [dbo].[Invoices] ADD UNIQUE NONCLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Invoices__D776E981C7207F94]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoices]') AND name = N'UQ__Invoices__D776E981C7207F94')
ALTER TABLE [dbo].[Invoices] ADD UNIQUE NONCLUSTERED 
(
	[InvoiceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ProductI__589E6EEC6FD28A47]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProductImage]') AND name = N'UQ__ProductI__589E6EEC6FD28A47')
ALTER TABLE [dbo].[ProductImage] ADD UNIQUE NONCLUSTERED 
(
	[FileName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Products__BC7B5FB6ED131AAE]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND name = N'UQ__Products__BC7B5FB6ED131AAE')
ALTER TABLE [dbo].[Products] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__ProductT__631D78E42910A2FF]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProductTaxes]') AND name = N'UQ__ProductT__631D78E42910A2FF')
ALTER TABLE [dbo].[ProductTaxes] ADD UNIQUE NONCLUSTERED 
(
	[ProductID] ASC,
	[TaxID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ProductV__9BDF8B244566E86A]    Script Date: 4/4/2025 5:32:38 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProductVariants]') AND name = N'UQ__ProductV__9BDF8B244566E86A')
ALTER TABLE [dbo].[ProductVariants] ADD UNIQUE NONCLUSTERED 
(
	[ProductId] ASC,
	[Size] ASC,
	[Color] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AccountVe__IsVer__628FA481]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AccountVerifications] ADD  DEFAULT ((0)) FOR [IsVerified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AccountVe__Creat__6383C8BA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AccountVerifications] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__BlogPosts__Creat__6477ECF3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BlogPosts] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__BlogPosts__Statu__656C112C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BlogPosts] ADD  DEFAULT ('Draft') FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Customers__IsEma__66603565]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Customers] ADD  DEFAULT ((0)) FOR [IsEmailVerified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Customers__Creat__6754599E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Customers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Employees__Creat__68487DD7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Employees] ADD  DEFAULT (getdate()) FOR [CreateAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Employees__Statu__693CA210]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Employees] ADD  DEFAULT ('Active') FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Invoices__Paymen__6A30C649]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ('Cash') FOR [PaymentMethod]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Invoices__Paymen__6B24EA82]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ('Pending') FOR [PaymentStatus]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Invoices__Create__6C190EBB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Notificat__IsRea__6D0D32F4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [IsRead]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Notificat__Creat__6E01572D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Notificat__Statu__6EF57B66]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ('Active') FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__OrderDeta__Varia__6FE99F9F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrderDetails] ADD  DEFAULT (NULL) FOR [VariantId]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__OrderDeta__Produ__70DDC3D8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrderDetails] ADD  DEFAULT ((0.00)) FOR [ProductDiscount]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__OrderDeta__Produ__71D1E811]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrderDetails] ADD  DEFAULT ((0.00)) FOR [ProductTax]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__OrderDeta__Creat__72C60C4A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrderDetails] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Orders__Status__73BA3083]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Orders__OrderDat__74AE54BC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ProductIm__Creat__75A278F5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductImage] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ProductIm__IsPri__76969D2E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductImage] ADD  DEFAULT ((0)) FOR [IsPrimary]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ProductIm__Statu__778AC167]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductImage] ADD  DEFAULT ((1)) FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ProductRe__Creat__787EE5A0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductReviews] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__Price__797309D9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [Price]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__Discou__7A672E12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0.00)) FOR [Discount]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__Averag__7B5B524B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0.00)) FOR [AverageRating]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__TotalS__7C4F7684]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [TotalSale]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__FreeSh__7D439ABD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [FreeShip]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__Guaran__7E37BEF6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [Guarantee]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__TotalT__5070F446]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [TotalTax]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__Create__7F2BE32F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Products__Status__00200768]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ProductVa__Disco__01142BA1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT ((0.00)) FOR [Discount]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ProductVa__Statu__02084FDA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT ((1)) FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ProductVa__Creat__02FC7413]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AccountVerifications_Customers]') AND parent_object_id = OBJECT_ID(N'[dbo].[AccountVerifications]'))
ALTER TABLE [dbo].[AccountVerifications]  WITH CHECK ADD  CONSTRAINT [FK_AccountVerifications_Customers] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AccountVerifications_Customers]') AND parent_object_id = OBJECT_ID(N'[dbo].[AccountVerifications]'))
ALTER TABLE [dbo].[AccountVerifications] CHECK CONSTRAINT [FK_AccountVerifications_Customers]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BlogPosts_BlogCategories]') AND parent_object_id = OBJECT_ID(N'[dbo].[BlogPosts]'))
ALTER TABLE [dbo].[BlogPosts]  WITH CHECK ADD  CONSTRAINT [FK_BlogPosts_BlogCategories] FOREIGN KEY([CategoryBlogId])
REFERENCES [dbo].[BlogCategories] ([CategoryBlogId])
ON DELETE SET NULL
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BlogPosts_BlogCategories]') AND parent_object_id = OBJECT_ID(N'[dbo].[BlogPosts]'))
ALTER TABLE [dbo].[BlogPosts] CHECK CONSTRAINT [FK_BlogPosts_BlogCategories]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BlogPosts_Employee_CreateBy]') AND parent_object_id = OBJECT_ID(N'[dbo].[BlogPosts]'))
ALTER TABLE [dbo].[BlogPosts]  WITH CHECK ADD  CONSTRAINT [FK_BlogPosts_Employee_CreateBy] FOREIGN KEY([CreateBy])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BlogPosts_Employee_CreateBy]') AND parent_object_id = OBJECT_ID(N'[dbo].[BlogPosts]'))
ALTER TABLE [dbo].[BlogPosts] CHECK CONSTRAINT [FK_BlogPosts_Employee_CreateBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BlogPosts_Employee_UpdateBy]') AND parent_object_id = OBJECT_ID(N'[dbo].[BlogPosts]'))
ALTER TABLE [dbo].[BlogPosts]  WITH CHECK ADD  CONSTRAINT [FK_BlogPosts_Employee_UpdateBy] FOREIGN KEY([UpdateBy])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BlogPosts_Employee_UpdateBy]') AND parent_object_id = OBJECT_ID(N'[dbo].[BlogPosts]'))
ALTER TABLE [dbo].[BlogPosts] CHECK CONSTRAINT [FK_BlogPosts_Employee_UpdateBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Employees_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[Employees]'))
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Employees_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[Employees]'))
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Roles]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Receipts_Orders]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoices]'))
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Receipts_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Receipts_Orders]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoices]'))
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Receipts_Orders]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Notifications_Employees]') AND parent_object_id = OBJECT_ID(N'[dbo].[Notifications]'))
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Employees] FOREIGN KEY([RecipientId])
REFERENCES [dbo].[Employees] ([EmployeeId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Notifications_Employees]') AND parent_object_id = OBJECT_ID(N'[dbo].[Notifications]'))
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Employees]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetails_Orders]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetails]'))
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetails_Orders]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetails]'))
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetails_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetails]'))
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetails_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetails]'))
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Orders_Customers]') AND parent_object_id = OBJECT_ID(N'[dbo].[Orders]'))
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Orders_Customers]') AND parent_object_id = OBJECT_ID(N'[dbo].[Orders]'))
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductCategory_ProductCategoryGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductCategory]'))
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_ProductCategoryGroup] FOREIGN KEY([GroupId])
REFERENCES [dbo].[ProductCategoryGroup] ([GroupId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductCategory_ProductCategoryGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductCategory]'))
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_ProductCategoryGroup]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductImage_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductImage]'))
ALTER TABLE [dbo].[ProductImage]  WITH CHECK ADD  CONSTRAINT [FK_ProductImage_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductImage_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductImage]'))
ALTER TABLE [dbo].[ProductImage] CHECK CONSTRAINT [FK_ProductImage_Product]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductReviews_Customers]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductReviews]'))
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviews_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductReviews_Customers]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductReviews]'))
ALTER TABLE [dbo].[ProductReviews] CHECK CONSTRAINT [FK_ProductReviews_Customers]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductReviews_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductReviews]'))
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviews_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductReviews_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductReviews]'))
ALTER TABLE [dbo].[ProductReviews] CHECK CONSTRAINT [FK_ProductReviews_Products]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Products_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[Products]'))
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[ProductCategory] ([CategoryId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Products_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[Products]'))
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ProductTa__Produ__123EB7A3]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductTaxes]'))
ALTER TABLE [dbo].[ProductTaxes]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ProductTa__TaxID__1332DBDC]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductTaxes]'))
ALTER TABLE [dbo].[ProductTaxes]  WITH CHECK ADD FOREIGN KEY([TaxID])
REFERENCES [dbo].[Tax] ([TaxID])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductVariants_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductVariants]'))
ALTER TABLE [dbo].[ProductVariants]  WITH CHECK ADD  CONSTRAINT [FK_ProductVariants_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductVariants_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductVariants]'))
ALTER TABLE [dbo].[ProductVariants] CHECK CONSTRAINT [FK_ProductVariants_Products]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK__AccountVe__Accou__151B244E]') AND parent_object_id = OBJECT_ID(N'[dbo].[AccountVerifications]'))
ALTER TABLE [dbo].[AccountVerifications]  WITH CHECK ADD CHECK  (([AccountType]='Employee' OR [AccountType]='Customer'))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Gender]') AND parent_object_id = OBJECT_ID(N'[dbo].[Customers]'))
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CHK_Gender] CHECK  (([Gender]=(1) OR [Gender]=(0)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Gender]') AND parent_object_id = OBJECT_ID(N'[dbo].[Customers]'))
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CHK_Gender]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Status]') AND parent_object_id = OBJECT_ID(N'[dbo].[Employees]'))
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_Status] CHECK  (([Status]='Suspended' OR [Status]='Inactive' OR [Status]='Active'))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CHK_Status]') AND parent_object_id = OBJECT_ID(N'[dbo].[Employees]'))
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CHK_Status]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK__Notificat__Recip__17F790F9]') AND parent_object_id = OBJECT_ID(N'[dbo].[Notifications]'))
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD CHECK  (([RecipientType]='Employee' OR [RecipientType]='Customer'))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK__ProductRe__Ratin__18EBB532]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductReviews]'))
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
/****** Object:  Trigger [dbo].[trg_UpdateTotalSale]    Script Date: 4/4/2025 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trg_UpdateTotalSale]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[trg_UpdateTotalSale]
ON [dbo].[Orders]
AFTER UPDATE
AS
BEGIN
    -- Chỉ cập nhật khi trạng thái đơn hàng là ''Completed''
    IF UPDATE(Status)
    BEGIN
        UPDATE p
        SET p.TotalSale = p.TotalSale + od.Quantity
        FROM Products p
        INNER JOIN OrderDetails od ON p.ProductId = od.ProductId
        INNER JOIN inserted i ON od.OrderId = i.OrderId
        WHERE i.Status = ''Completed'';
    END
END;
' 
GO
ALTER TABLE [dbo].[Orders] ENABLE TRIGGER [trg_UpdateTotalSale]
GO
/****** Object:  Trigger [dbo].[trg_Update_AverageRating]    Script Date: 4/4/2025 5:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trg_Update_AverageRating]'))
EXEC dbo.sp_executesql @statement = N'

CREATE TRIGGER [dbo].[trg_Update_AverageRating]
ON [dbo].[ProductReviews]
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    -- Cập nhật AverageRating của sản phẩm khi có thay đổi trong bảng Reviews
    UPDATE Products
    SET AverageRating = (
        SELECT COALESCE(CAST(ROUND(AVG(Rating), 1) AS DECIMAL(4,2)), 0)
        FROM ProductReviews
        WHERE ProductReviews.ProductId = Products.ProductId
    )
    WHERE ProductId IN (
        SELECT DISTINCT ProductId FROM inserted
        UNION
        SELECT DISTINCT ProductId FROM deleted
    );
END;
' 
GO
ALTER TABLE [dbo].[ProductReviews] ENABLE TRIGGER [trg_Update_AverageRating]
GO
/****** Object:  Trigger [dbo].[trg_Update_Quantity_Products]    Script Date: 4/4/2025 5:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trg_Update_Quantity_Products]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[trg_Update_Quantity_Products]
ON [dbo].[Products]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Products
    SET Quantity = (
        SELECT COALESCE(SUM(Quantity), 0)
        FROM ProductVariants
        WHERE ProductVariants.ProductId = Products.ProductId
    )
    WHERE ProductId IN (
        SELECT DISTINCT ProductId 
        FROM inserted
        UNION
        SELECT DISTINCT ProductId 
        FROM deleted
    )
    AND EXISTS (
        SELECT 1 FROM ProductVariants 
        WHERE ProductVariants.ProductId = Products.ProductId
    ); -- Chỉ cập nhật nếu có biến thể
END;
' 
GO
ALTER TABLE [dbo].[Products] ENABLE TRIGGER [trg_Update_Quantity_Products]
GO
/****** Object:  Trigger [dbo].[trg_CalculateTotalTax]    Script Date: 4/4/2025 5:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trg_CalculateTotalTax]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[trg_CalculateTotalTax]
ON [dbo].[ProductTaxes]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật TotalTax trong bảng Products
    UPDATE p
    SET p.TotalTax = (
        SELECT COALESCE(SUM(t.TaxRate), 0)
        FROM ProductTaxes pt
        JOIN Tax t ON pt.TaxID = t.TaxID
        WHERE pt.ProductID = p.ProductId
    )
    FROM Products p
    WHERE p.ProductId IN (
        SELECT DISTINCT ProductID FROM inserted
        UNION
        SELECT DISTINCT ProductID FROM deleted
    );
END;
' 
GO
ALTER TABLE [dbo].[ProductTaxes] ENABLE TRIGGER [trg_CalculateTotalTax]
GO
/****** Object:  Trigger [dbo].[trg_Update_Quantity_ProductVariants]    Script Date: 4/4/2025 5:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trg_Update_Quantity_ProductVariants]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[trg_Update_Quantity_ProductVariants]
ON [dbo].[ProductVariants]
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật số lượng tổng của sản phẩm khi có thay đổi trong bảng ProductVariants
    UPDATE Products
    SET Quantity = (
        SELECT COALESCE(SUM(Quantity), 0)
        FROM ProductVariants
        WHERE ProductVariants.ProductId = Products.ProductId
    )
    WHERE ProductId IN (
        SELECT DISTINCT ProductId FROM inserted
        UNION
        SELECT DISTINCT ProductId FROM deleted
    );
END;
' 
GO
ALTER TABLE [dbo].[ProductVariants] ENABLE TRIGGER [trg_Update_Quantity_ProductVariants]
GO
USE [master]
GO
ALTER DATABASE [MinhXuanDatabase] SET  READ_WRITE 
GO
