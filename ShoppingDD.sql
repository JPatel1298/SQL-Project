USE [master]
GO
/****** Object:  Database [ShoppingDB]    Script Date: 25-05-2023 13:10:59 ******/
CREATE DATABASE [ShoppingDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ShoppingDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ShoppingDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ShoppingDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ShoppingDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ShoppingDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShoppingDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShoppingDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShoppingDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShoppingDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShoppingDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShoppingDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShoppingDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShoppingDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShoppingDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShoppingDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShoppingDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShoppingDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShoppingDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShoppingDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShoppingDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShoppingDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShoppingDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ShoppingDB] SET  MULTI_USER 
GO
ALTER DATABASE [ShoppingDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShoppingDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShoppingDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShoppingDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ShoppingDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ShoppingDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ShoppingDB', N'ON'
GO
ALTER DATABASE [ShoppingDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [ShoppingDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ShoppingDB]
GO
/****** Object:  UserDefinedFunction [dbo].[Getpricewithtaxdiscount]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Getpricewithtaxdiscount]
(	
	@Productid int,@quantity int
)
RETURNS @Totalprice TABLE 
(
productName Nvarchar(100),
Quanty int,
price decimal(10,3),
pricewithquantity decimal(10,3),
Tax decimal(10,3),
Pricewithtax decimal(10,3),
discount decimal(10,3),
pricewithdiscount decimal(10,3)
)
AS
BEGIN

Declare @productName nvarchar(100)
Declare @price decimal(10,3)
Declare @pricewithquantity decimal(10,3)
Declare @tax int
Declare @Taxcal decimal(10,3)
Declare @Pricewithtax decimal(10,3)
Declare @discount decimal(10,3)
declare @discountcal decimal(10,3)
Declare @pricewithdiscount decimal(10,3)


Set @productName =(select productName from Products where productId=@Productid)
set @price=(select price from Products where productId=@Productid)
set @pricewithquantity =@price*@quantity
set @Tax =(select taxid from Products where productId=@Productid )
set @Taxcal=@pricewithquantity *(select taxper from TaxTable where Taxid=@tax)
set @Pricewithtax =@pricewithquantity+@Taxcal
set @discount =(select offerid from Products where productId=@Productid )
set @discountcal =(@Pricewithtax * (select offerPer from ProductOffersTable where offerId=@discount))/100
set @pricewithdiscount =@Pricewithtax - @discountcal

insert into @Totalprice (productName,Quanty,price,pricewithquantity,Tax,Pricewithtax,discount,pricewithdiscount)
values (@productName,@quantity,@price,@pricewithquantity,@Taxcal,@Pricewithtax,@discountcal,@pricewithdiscount)
RETURN 
end

--select*from [dbo].[Getpricewithtaxdiscount](1,5)
GO
/****** Object:  UserDefinedFunction [dbo].[Getpricewithtaxdiscountandcgst]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Getpricewithtaxdiscountandcgst]
(	
	@Productid int,@quantity int
)
RETURNS @Totalprice TABLE 
(
productName Nvarchar(100),
Quanty int,
price decimal(10,3),
total int,
PricewithCGST decimal(10,3),
PricewithSGST decimal(10,3),
discount decimal(10,3)
)
AS
BEGIN

Declare @productName nvarchar(100)
Declare @price decimal(10,3)
Declare @PricewithCGST decimal(10,3)
declare @PricewithSGST decimal(10,3)
Declare @discount decimal(10,3)
declare @total int


Set @productName =(select productName from Products where productId=@Productid)
set @price=(select price from Products where productId=@Productid)
set @total =@price*@quantity

set @PricewithCGST =(@total*0.06)/100
set @PricewithSGST =(@total*0.06)/100
set @discount =(select offerid from Products where productId=@Productid )


insert into @Totalprice (productName,Quanty,price,total,PricewithCGST,PricewithSGST,discount)
values (@productName,@quantity,@price,@total,@PricewithCGST,@PricewithSGST,@discount)
RETURN 
end
GO
/****** Object:  Table [dbo].[CartTable]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartTable](
	[CartProductId] [int] IDENTITY(1,1) NOT NULL,
	[Categoryid] [int] NULL,
	[ProductId] [int] NULL,
	[ProductSize] [nvarchar](50) NULL,
	[SelectItems] [int] NULL,
	[ProductColour] [nvarchar](50) NULL,
 CONSTRAINT [PK_CartTable] PRIMARY KEY CLUSTERED 
(
	[CartProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[catagoryName] [nvarchar](150) NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_CategoryId] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CityMaster]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityMaster](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[Stateid] [int] NULL,
	[CityName] [nvarchar](150) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CityMaster] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CountryMaster]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryMaster](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryNmae] [nvarchar](150) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CountryMaster] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoustomerDetails]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoustomerDetails](
	[CustomerId] [int] NULL,
	[FirstName] [nvarchar](150) NULL,
	[MiddleName] [nvarchar](150) NULL,
	[LastName] [nvarchar](150) NULL,
	[Gender] [nvarchar](150) NULL,
	[Mobileno] [nvarchar](50) NULL,
	[Emailid] [nvarchar](50) NULL,
	[Address] [nvarchar](150) NULL,
	[Pincode] [int] NULL,
	[CityNmae] [nvarchar](50) NULL,
	[CountryNmae] [nvarchar](50) NULL,
	[StateName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order1Table]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order1Table](
	[orderid] [int] IDENTITY(1,1) NOT NULL,
	[taxid] [int] NULL,
	[mobileno] [nvarchar](100) NULL,
	[customerid] [int] NULL,
	[paymentmode] [nvarchar](100) NULL,
	[deliverydetails] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order1Table] PRIMARY KEY CLUSTERED 
(
	[orderid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderDetailsTable]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderDetailsTable](
	[Orderdetailsid] [int] NOT NULL,
	[customerId] [int] NULL,
	[CartProductId] [int] NULL,
	[Taxid] [int] NULL,
	[Deliveryaddress] [nvarchar](150) NULL,
	[ProductofferId] [int] NULL,
	[Mobileno] [nvarchar](50) NULL,
	[TyPeofdelivery] [nvarchar](50) NULL,
	[PaymentOptions] [nvarchar](150) NULL,
	[orderid] [int] NULL,
 CONSTRAINT [PK_orderTable] PRIMARY KEY CLUSTERED 
(
	[Orderdetailsid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentTable]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTable](
	[paymentId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[ProductofferId] [int] NULL,
	[TypeofDelivery] [nvarchar](50) NULL,
	[PaymentOption] [nvarchar](150) NULL,
	[BankName] [nvarchar](50) NULL,
	[AccountNo] [int] NULL,
	[OTP] [int] NULL,
	[ATMcardNO] [int] NULL,
	[NameonATMcard] [nvarchar](50) NULL,
	[ExpiryATMcard] [nvarchar](50) NULL,
	[UPINo] [nvarchar](50) NULL,
 CONSTRAINT [PK_PaymentTable] PRIMARY KEY CLUSTERED 
(
	[paymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductOffersTable]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductOffersTable](
	[offerId] [int] IDENTITY(1,1) NOT NULL,
	[offerName] [nvarchar](150) NULL,
	[offerPer] [decimal](10, 2) NULL,
 CONSTRAINT [PK_ProductOffersTable] PRIMARY KEY CLUSTERED 
(
	[offerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[productId] [int] IDENTITY(1,1) NOT NULL,
	[catagoryID] [int] NULL,
	[offerid] [int] NULL,
	[productName] [nvarchar](500) NULL,
	[price] [nvarchar](500) NULL,
	[Image] [nvarchar](50) NULL,
	[discription] [nvarchar](500) NULL,
	[taxid] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTaxTable]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTaxTable](
	[productTaxID] [int] NULL,
	[productName] [nvarchar](500) NULL,
	[productid] [int] NULL,
	[taxid] [int] NULL,
	[tax] [decimal](5, 5) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaxTable]    Script Date: 25-05-2023 13:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxTable](
	[Taxid] [int] IDENTITY(1,1) NOT NULL,
	[taxName] [nvarchar](50) NULL,
	[taxper] [decimal](18, 0) NULL,
 CONSTRAINT [PK_TaxTable] PRIMARY KEY CLUSTERED 
(
	[Taxid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [ShoppingDB] SET  READ_WRITE 
GO
