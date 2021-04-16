--stored function

alter function ufn_salestotal_byperson(@salespersonID int)
returns int
as
begin
declare @salesamount decimal
select @salesamount=round(totaldue,2)
from Sales.SalesOrderHeader
where SalesPersonID=@salespersonID
return @salesamount
end
Go
select * 
from ufn_salestotal_byperson(290)
