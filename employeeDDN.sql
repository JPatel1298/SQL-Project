USE [master]
GO
/****** Object:  Database [EmployDD]    Script Date: 12-02-2023 15:56:04 ******/
CREATE DATABASE [EmployDD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployDD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\EmployDD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EmployDD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\EmployDD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [EmployDD] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployDD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployDD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployDD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployDD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployDD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployDD] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployDD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployDD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployDD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployDD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployDD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployDD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployDD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployDD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployDD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployDD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployDD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployDD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployDD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployDD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployDD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployDD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployDD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployDD] SET RECOVERY FULL 
GO
ALTER DATABASE [EmployDD] SET  MULTI_USER 
GO
ALTER DATABASE [EmployDD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployDD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployDD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployDD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmployDD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EmployDD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmployDD', N'ON'
GO
ALTER DATABASE [EmployDD] SET QUERY_STORE = ON
GO
ALTER DATABASE [EmployDD] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EmployDD]
GO
/****** Object:  Table [dbo].[BloodGroupMaster]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BloodGroupMaster](
	[BloodGroupId] [int] IDENTITY(1,1) NOT NULL,
	[BloodGroupName] [nvarchar](50) NULL,
	[Isactive] [bit] NULL,
 CONSTRAINT [PK_Blood] PRIMARY KEY CLUSTERED 
(
	[BloodGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CasteMasterTable]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CasteMasterTable](
	[CasteId] [int] IDENTITY(1,1) NOT NULL,
	[CasteName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CasteMasterTable] PRIMARY KEY CLUSTERED 
(
	[CasteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CitizenshipMasterTable]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CitizenshipMasterTable](
	[Citizenship] [int] IDENTITY(1,1) NOT NULL,
	[CitizenshipName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CitizenshipMasterTable] PRIMARY KEY CLUSTERED 
(
	[Citizenship] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CityMasterTable]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityMasterTable](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[StateId] [int] NULL,
	[CityNames] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CityMasterTable] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CountryMasterTable]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryMasterTable](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CountryMasterTable] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeBankDetails]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeBankDetails](
	[BankId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[BankAccountNo] [nvarchar](50) NULL,
	[EmployeeName] [nvarchar](150) NULL,
	[BankName] [nvarchar](50) NULL,
	[Branch] [nvarchar](50) NULL,
	[AccountType] [nvarchar](50) NULL,
	[IFSCCode] [nvarchar](50) NULL,
	[MICRno] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_EmployeeBankDetails] PRIMARY KEY CLUSTERED 
(
	[BankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeContactDetails]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeContactDetails](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[HomeAddress] [nvarchar](max) NULL,
	[MobileNo] [nvarchar](50) NULL,
	[LandlineNo] [nvarchar](50) NULL,
	[EmailId] [nvarchar](150) NULL,
	[SkypeId] [nvarchar](150) NULL,
	[LinkedinId] [nvarchar](150) NULL,
	[OfficeAddress] [nvarchar](max) NULL,
	[OfficeNo] [nvarchar](50) NULL,
	[CountryId] [int] NULL,
	[StateId] [int] NULL,
	[CityId] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_EmployeeContactDetails] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeEducationDetails]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeEducationDetails](
	[EducationId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[Qualification] [nvarchar](150) NULL,
	[School] [nvarchar](150) NULL,
	[College/University] [nvarchar](150) NULL,
	[PassOutYear] [int] NULL,
	[Field] [nvarchar](50) NULL,
	[Percentage] [decimal](6, 2) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_EmployeeEducationDetails] PRIMARY KEY CLUSTERED 
(
	[EducationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeePersonalDetails]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeePersonalDetails](
	[EmployeeId] [int] IDENTITY(1001,1) NOT NULL,
	[FirstName] [nvarchar](300) NULL,
	[LastName] [nvarchar](300) NULL,
	[DateOfBirth] [date] NULL,
	[Age] [int] NULL,
	[Father/HusbandName] [nvarchar](350) NULL,
	[Gender] [nvarchar](20) NULL,
	[MaritalStatus] [nvarchar](20) NULL,
	[Citizenship] [int] NULL,
	[Height] [decimal](10, 2) NULL,
	[Weight] [int] NULL,
	[BloodGroupId] [int] NULL,
	[CasteId] [int] NULL,
	[SubCasteId] [int] NULL,
	[ReligionId] [int] NULL,
	[CreateBy] [int] NULL,
	[CreateOn] [datetime] NULL,
	[UpDateBy] [int] NULL,
	[UpdateOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_EmployeePersonalDetails] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExperienceDetailsTable]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExperienceDetailsTable](
	[Experience Id] [int] IDENTITY(1,1) NOT NULL,
	[employeeId] [int] NULL,
	[occupation] [nvarchar](100) NULL,
	[Dateofjoining] [date] NULL,
	[experience] [nvarchar](50) NULL,
	[Designation] [nvarchar](100) NULL,
	[Currentcompany] [nvarchar](100) NULL,
	[previouscompany] [nvarchar](100) NULL,
 CONSTRAINT [PK_ExperienceDetailsTable] PRIMARY KEY CLUSTERED 
(
	[Experience Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReligionMasterTable]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReligionMasterTable](
	[ReligionId] [int] IDENTITY(1,1) NOT NULL,
	[ReligionName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ReligionMasterTable] PRIMARY KEY CLUSTERED 
(
	[ReligionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StateMasterTable]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateMasterTable](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NULL,
	[StateNames] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_StateMasterTable] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCasteMasterTable]    Script Date: 12-02-2023 15:56:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCasteMasterTable](
	[SubCasteId] [int] IDENTITY(1,1) NOT NULL,
	[CasteId] [int] NULL,
	[SubCasteName] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_SubCasteMasterTable] PRIMARY KEY CLUSTERED 
(
	[SubCasteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [EmployDD] SET  READ_WRITE 
GO
