

--1. Find all Products in the product category “Accessories”

USE AdventureWorks2014
GO

select p.Name as 'Product',c.Name as 'Product Category',s.Name as 'Subcategory'
from Production.Product p
join Production.ProductSubcategory s
on p.ProductSubcategoryID=s.ProductSubcategoryID
join Production.ProductCategory c
on s.ProductCategoryID=c.ProductCategoryID
where c.Name='Accessories'



--2. Find all Products that have “seat” in its name

select p.Name
from Production.Product p
where p.Name like '%seat%'


--3. Find the number of products in each product category

select COUNT(c.ProductCategoryID) as 'No. of Products', c.Name as 'category' from Production.Product p
join Production.ProductSubcategory s
on p.ProductSubcategoryID=s.ProductSubcategoryID
join Production.ProductCategory c
on s.ProductCategoryID=c.ProductCategoryID
group by c.Name


--4. Find the average price of the products in each product subcategory

select COLUMN_NAME, DATA_TYPE
from INFORMATION_SCHEMA.COLUMNS
where
TABLE_NAME='ProductListPriceHistory' 


select distinct(s.Name) as 'SubCategory', avg(lp.ListPrice)over (partition by(s.Name)) as 'Average Price' from Production.Product p
full join Production.ProductSubcategory s
on p.ProductSubcategoryID=s.ProductSubcategoryID
join Production.ProductListPriceHistory lp
on lp.ProductID=p.ProductID
group by s.Name,lp.ListPrice


select distinct (s.Name) as 'SubCategory', avg(lp.ListPrice) as 'Average Price' from Production.Product p
full join Production.ProductSubcategory s
on p.ProductSubcategoryID=s.ProductSubcategoryID
join Production.ProductListPriceHistory lp
on lp.ProductID=p.ProductID
group by s.Name

--5. Find the orders that were made between the dates “2011-06-13” and “2011-06-18”

select * from Sales.SalesOrderHeader s
where s.OrderDate between '2011-06-13' and '2011-06-18'




--6. Find the highest price of order for each customer.

select distinct concat(p.FirstName,' '+isnull(p.MiddleName,'')+' '+isnull(p.LastName,'')) as 'Customer Name', 
max(sod.UnitPrice) OVER (partition by sod.SalesOrderID) as 'Highest Price' from
Sales.SalesOrderDetail sod
join Sales.SalesOrderHeader soh
on sod.SalesOrderID=soh.SalesOrderID
join Sales.Customer sc
on soh.CustomerID=sc.CustomerID
join Person.Person p
on sc.PersonID=p.BusinessEntityID
group by p.FirstName,p.MiddleName,p.LastName,sod.UnitPrice,sod.SalesOrderID
order by [Highest Price] desc

select distinct concat(p.FirstName,' ', p.MiddleName,' ',p.LastName) as 'Customer Name', p.BusinessEntityID,
max(sod.UnitPrice) as 'Highest Price' from
Sales.SalesOrderDetail sod
join Sales.SalesOrderHeader soh
on sod.SalesOrderID=soh.SalesOrderID
join Sales.Customer sc
on soh.CustomerID=sc.CustomerID
join Person.Person p
on sc.PersonID=p.BusinessEntityID
group by p.FirstName,p.MiddleName,p.LastName,sod.UnitPrice,sod.SalesOrderID,p.BusinessEntityID
order by [Customer Name] desc

select distinct concat(p.FirstName,' '+isnull(p.MiddleName,'')+' '+isnull(p.LastName,'')) as 'Customer Name', max(sod.UnitPrice) OVER (partition by p.BusinessEntityID) as 'Highest Price' from
Sales.SalesOrderDetail sod
join Sales.SalesOrderHeader soh
on sod.SalesOrderID=soh.SalesOrderID
join Sales.Customer sc
on soh.CustomerID=sc.CustomerID
join Person.Person p
on sc.PersonID=p.BusinessEntityID
group by p.FirstName,p.MiddleName,p.LastName,sod.UnitPrice,p.BusinessEntityID
order by [Highest Price] desc

SELECT
    fk.name 'FK Name',
    tp.name 'Parent table',
    cp.name, cp.column_id,
    tr.name 'Refrenced table',
    cr.name, cr.column_id
FROM 
    sys.foreign_keys fk
INNER JOIN 
    sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN 
    sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN 
    sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
INNER JOIN 
    sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
INNER JOIN 
    sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id
ORDER BY
    tp.name, cp.column_id

	select * from 
	INFORMATION_SCHEMA.VIEWS
	where TABLE_NAME= 'foreign_keys'

	select * from sys.foreign_keys

	select * from sys.objects where name='sys.foreign_keys'