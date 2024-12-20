USE [master]
GO
/****** Object:  Database [mit_tax_bda_project]    Script Date: 11/14/2024 10:40:52 PM ******/
CREATE DATABASE [mit_tax_bda_project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tax_bda', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\tax_bda.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tax_bda_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\tax_bda_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [mit_tax_bda_project] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [mit_tax_bda_project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [mit_tax_bda_project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET ARITHABORT OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [mit_tax_bda_project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [mit_tax_bda_project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [mit_tax_bda_project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [mit_tax_bda_project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [mit_tax_bda_project] SET  MULTI_USER 
GO
ALTER DATABASE [mit_tax_bda_project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [mit_tax_bda_project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [mit_tax_bda_project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [mit_tax_bda_project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [mit_tax_bda_project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [mit_tax_bda_project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [mit_tax_bda_project] SET QUERY_STORE = ON
GO
ALTER DATABASE [mit_tax_bda_project] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [mit_tax_bda_project]
GO
/****** Object:  Table [dbo].[Dim_Date]    Script Date: 11/14/2024 10:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Date](
	[date_key] [date] NOT NULL,
	[day] [int] NULL,
	[month] [int] NULL,
	[quarter] [int] NULL,
	[year] [int] NULL,
	[day_name] [varchar](10) NULL,
	[month_name] [varchar](15) NULL,
	[is_weekend] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[date_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Employee]    Script Date: 11/14/2024 10:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Employee](
	[employee_key] [int] IDENTITY(1,1) NOT NULL,
	[employee_nic] [varchar](15) NOT NULL,
	[employee_name] [varchar](100) NOT NULL,
	[designation] [varchar](50) NULL,
	[employment_from_date] [date] NOT NULL,
	[employment_to_date] [date] NULL,
	[passport_no] [varchar](20) NULL,
	[tin] [varchar](20) NULL,
	[income_tax_file_no] [varchar](20) NULL,
	[is_current_record] [tinyint] NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Remuneration]    Script Date: 11/14/2024 10:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Remuneration](
	[remuneration_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_key] [int] NOT NULL,
	[employment_from_date_key] [date] NULL,
	[employment_to_date_key] [date] NULL,
	[cash_payment] [decimal](15, 2) NULL,
	[non_cash_benefits] [decimal](15, 2) NULL,
	[total_remuneration] [decimal](15, 2) NULL,
	[total_tax_exempt_income] [decimal](15, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[remuneration_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Tax_Deduction]    Script Date: 11/14/2024 10:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Tax_Deduction](
	[deduction_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_key] [int] NOT NULL,
	[deduction_date_key] [date] NULL,
	[tax_deducted_section_114] [decimal](15, 2) NULL,
	[tax_deducted_section_117] [decimal](15, 2) NULL,
	[total_tax_deducted] [decimal](15, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[deduction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dim_Date] ADD  DEFAULT ((0)) FOR [is_weekend]
GO
ALTER TABLE [dbo].[Dim_Employee] ADD  DEFAULT ((1)) FOR [is_current_record]
GO
ALTER TABLE [dbo].[Dim_Employee] ADD  DEFAULT (getdate()) FOR [start_date]
GO
ALTER TABLE [dbo].[Fact_Remuneration]  WITH CHECK ADD FOREIGN KEY([employee_key])
REFERENCES [dbo].[Dim_Employee] ([employee_key])
GO
ALTER TABLE [dbo].[Fact_Remuneration]  WITH CHECK ADD FOREIGN KEY([employment_from_date_key])
REFERENCES [dbo].[Dim_Date] ([date_key])
GO
ALTER TABLE [dbo].[Fact_Remuneration]  WITH CHECK ADD FOREIGN KEY([employment_to_date_key])
REFERENCES [dbo].[Dim_Date] ([date_key])
GO
ALTER TABLE [dbo].[Fact_Tax_Deduction]  WITH CHECK ADD FOREIGN KEY([deduction_date_key])
REFERENCES [dbo].[Dim_Date] ([date_key])
GO
ALTER TABLE [dbo].[Fact_Tax_Deduction]  WITH CHECK ADD FOREIGN KEY([employee_key])
REFERENCES [dbo].[Dim_Employee] ([employee_key])
GO
USE [master]
GO
ALTER DATABASE [mit_tax_bda_project] SET  READ_WRITE 
GO
