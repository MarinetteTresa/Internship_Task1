--stored function\\

alter function ufn_sales_multi (@salespersonID int)
returns @salespersonamount table (salespersonID int, salesamount decimal(10,2))
begin

declare @salespersonExists BIT

if exists(select * from sales.SalesPerson where BusinessEntityID=@salespersonID)
set @salespersonExists=1
else
set @salespersonExists=0

if @salespersonExists=1
insert into @salespersonamount(salespersonID,salesamount)
select top 3
salespersonID,round(totaldue,2) as salesamount
from
Sales.SalesOrderHeader
where salespersonID=@salespersonID
order by TotalDue desc
return
end

select * from ufn_sales_multi(290)