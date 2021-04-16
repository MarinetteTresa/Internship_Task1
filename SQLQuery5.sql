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


USE [IndustryConnect_DW]GOINSERT INTO [dbo].[DimCustomer]           ([CustomerID]           ,[CustomerName]           ,[TerritoryName]           ,[RegionName]           )SELECT        AdventureWorks2014.Sales.Customer.CustomerID, AdventureWorks2014.Sales.Store.Name as 'storename', AdventureWorks2014.Sales.SalesTerritory.Name AS 'territory name', AdventureWorks2014.Sales.SalesTerritory.CountryRegionCodeFROM            AdventureWorks2014.sales.Customer INNER JOIN                         AdventureWorks2014.Sales.SalesTerritory ON AdventureWorks2014.Sales.Customer.TerritoryID = AdventureWorks2014.Sales.SalesTerritory.TerritoryID INNER JOIN                         AdventureWorks2014.Sales.Store ON AdventureWorks2014.Sales.Customer.StoreID = AdventureWorks2014.Sales.Store.BusinessEntityID           GO


