USE [IndustryConnect_DW]	
CREATE TABLE [dbo].[DimCustomer](	
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[CustomerName] [nvarchar](360) NULL,
	[TerritoryName] [nvarchar](50) NULL,
	[RegionName] [nvarchar](50) NULL,
	[ValidFrom] [datetime] NULL,
	[ValidTo] [datetime] NULL,
 CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED 	
(	
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]	
) ON [PRIMARY]	
GO


USE [IndustryConnect_DW]	
CREATE TABLE [dbo].[DimProduct](	
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductNumber] [nvarchar](25) NULL,
	[Name] [nvarchar](50) NULL,
	[SubCategory] [nvarchar](102) NULL,
	[Category] [nvarchar](102) NULL,
	[Color] [nvarchar](32) NULL,
 CONSTRAINT [PK__dim_prod__A15E99B3FF95647E] PRIMARY KEY CLUSTERED 	
(	
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]	
) ON [PRIMARY]	
GO	