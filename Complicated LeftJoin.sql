select * from dimdate

drop table DimCustomer2

CREATE TABLE [dbo].[DimCustomer2](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[CustomerName] [nvarchar](360) NULL,
	[TerritoryName] [nvarchar](50) NULL,
	[RegionName] [nvarchar](50) NULL,
	[ValidFrom] [datetime] NULL,
	[ValidTo] [datetime] NULL,
 CONSTRAINT [PK_DimCustomer2] PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


select c.CustomerID,
case when s.Name is null then p.FirstName+' '+ISNULL(p.MiddleName,'')+' '+ p.LastName else s.Name end as CustomrName, t.Name as TerriotyName,
case when r.name is null then r2.Name else r.Name end as RegionName

from AdventureWorks2014.Sales.Customer c left join AdventureWorks2014.Person.Person p
on c.CustomerID=p.BusinessEntityID left join AdventureWorks2014.Sales.Store s
on c.StoreID=s.BusinessEntityID 
left join AdventureWorks2014.Sales.SalesTerritory t
on c.TerritoryID = t.TerritoryID 
left join (select *,row_number() over (partition by bea.businessEntityID order by bea.modifieddate desc, bea.AddressID desc)Rowrank from
AdventureWorks2014.Person.BusinessEntityAddress bea)ba

on c.PersonID=ba.BusinessEntityID and ba.rowrank=1

left join AdventureWorks2014.Person.Address a
on a.AddressID=ba.AddressID 
left join AdventureWorks2014.Person.StateProvince st
on a.StateProvinceID=st.StateProvinceID left join AdventureWorks2014.Person.CountryRegion r
on st.CountryRegionCode=r.CountryRegionCode left join AdventureWorks2014.Person.CountryRegion r2
on t.CountryRegionCode=r2.CountryRegionCode

select * from AdventureWorks2014.person.BusinessEntityAddress
where BusinessEntityID=332