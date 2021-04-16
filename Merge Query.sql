select h.SalesOrderID,h.OrderDate,h.DueDate,h.ShipDate,h.CustomerID,d.SalesOrderDetailID,d.OrderQty,d.UnitPrice,d.LineTotal
from
AdventureWorks2014.sales.salesorderheader h inner join
adventureworks2014.sales.salesorderdetail d on
h.SalesOrderID=d.SalesOrderID


merge dbo.factsales2 as target
using( 
select SalesOrderID, SalesOrderDetailID,customerkey,datekey as OrderDateKey,productkey , OrderQty, unitprice, linetotal  
from stagesales2 left join dimcustomer2 
on stagesales2.customerid=dimcustomer2.customerid and dimcustomer2.validto=null
left join dimproduct2
on stagesales2.ProductID=dimproduct2.productid
left join dimdate2 dimorderdate
on stagesales2.orderdate=dimorderdate.fulldate
) as source
on (target.salesorderID=source.salesorderid and target.SalesOrderLineID=source.salesorderdetailid
) when matched then
update set target.orderdatekey=source.orderdatekey,
			target.dimcustomerkey=source.customerkey,
			target.dimproductkey=source.productkey,
			target.orderQty=source.orderqty,
			target.unitprice=source.unitprice,
			target.linetotal=source.linetotal

when not matched then
insert ([OrderDateKey],[dimCustomerKey],[SalesOrderID], [SalesOrderLineID],[dimProductKey], 
[OrderQty], [unitprice], [LineTotal])
values(source.orderdatekey,source.customerkey,source.salesorderid,source.salesorderdetailid,source.productkey,
source.orderqty,source.unitprice,source.linetotal
);