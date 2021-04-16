Create PROCEDURE ID
as
begin
select OrderDate,Duedate
from Sales.SalesOrderHeader
end;

execute ID;

Alter procedure ID
as
begin
select CustomerID,currencyrateID,SubTotal
from Sales.SalesOrderHeader
order by SubTotal
end;

Alter procedure ID

