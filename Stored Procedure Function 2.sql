alter function ufn_sales(@SalesPersonID int)
returns table
as
return
(
select top 10 SalesPersonID,ROUND(TotalDue,2) as SalesAmount
from Sales.SalesOrderHeader
where
SalesPersonID=@SalesPersonID
order by
TotalDue desc

)

select *
from ufn_sales(281)