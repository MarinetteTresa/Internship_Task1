use IndustryConnect_DW
go
select * from DimProduct2

select p.ProductID, p.Name as ProductName,p.ProductNumber,p.Color,s.Name as SubCategory,c.Name as Category
from AdventureWorks2014.production.Product p
left join AdventureWorks2014.Production.ProductSubcategory s
on p.ProductSubcategoryID=s.ProductSubcategoryID
left join AdventureWorks2014.Production.ProductCategory c
on s.ProductCategoryID=c.ProductCategoryID

select * from AdventureWorks2014.Production.Product

update AdventureWorks2014.Production.Product
set Color='Blue' where ProductID=1




merge dimproduct2 as target
using(
select p.ProductID, p.Name as ProductName,p.ProductNumber,p.Color,s.Name as SubCategory,c.Name as Category
from AdventureWorks2014.production.Product p
left join AdventureWorks2014.Production.ProductSubcategory s
on p.ProductSubcategoryID=s.ProductSubcategoryID
left join AdventureWorks2014.Production.ProductCategory c
on s.ProductCategoryID=c.ProductCategoryID
)source
on target.productID=source.productID
when matched then
update set
target.[ProductNumber]=source.[ProductNumber],
target.[ProductName]=source.[ProductName],
target.[SubCategory]=source.[SubCategory],
target.[Category]=source.[Category],
target.[Color]=source.[Color]
when not matched then
insert([ProductID], [ProductNumber], [ProductName], [SubCategory], [Category], [Color])
values (source.[ProductID], source.[ProductNumber], source.[ProductName], source.[SubCategory], source.[Category], source.[Color])
;

