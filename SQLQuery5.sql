USE [IndustryConnect_DW]
GO

INSERT INTO [dbo].[DimCustomer]
           ([CustomerID]
           ,[CustomerName]
           ,[TerritoryName]
           ,[RegionName]
           ,[ValidFrom]
           ,[ValidTo])
     VALUES
           (<CustomerID, int,>
           ,<CustomerName, nvarchar(360),>
           ,<TerritoryName, nvarchar(50),>
           ,<RegionName, nvarchar(50),>
           ,<ValidFrom, datetime,>
           ,<ValidTo, datetime,>)
GO


USE [IndustryConnect_DW]

