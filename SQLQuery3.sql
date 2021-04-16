select ba.BusinessEntityID,ba.AddressID,ba.AddressTypeID,
a.AddressTypeID,a.ModifiedDate,a.Name,
ad.AddressLine1,ad.AddressLine2,ad.City
from adventureworks2014.Person.BusinessEntityAddress ba
left join AdventureWorks2014.Person.AddressType a
on ba.AddressTypeID=a.AddressTypeID
left join AdventureWorks2014.Person.Address ad
on ba.AddressID=ad.AddressID
order by ba.BusinessEntityID


select bea.BusinessEntityID,count(bea.BusinessEntityID)
from AdventureWorks2014.Person.BusinessEntityAddress bea
inner join
(select bea.BusinessEntityID, MAX(bea.ModifiedDate) as Maxdate
from AdventureWorks2014.Person.BusinessEntityAddress bea
group by bea.BusinessEntityID) mxquery on bea.BusinessEntityID=mxquery.BusinessEntityID and bea.ModifiedDate=mxquery.Maxdate
group by bea.BusinessEntityID
having count(bea.BusinessEntityID)>1

select bea.BusinessEntityID,count(bea.BusinessEntityID)
from AdventureWorks2014.Person.BusinessEntityAddress bea
inner join
(select bea.BusinessEntityID, MAX(bea.ModifiedDate) as Maxdate
from AdventureWorks2014.Person.BusinessEntityAddress bea
group by bea.BusinessEntityID) mxquery on bea.BusinessEntityID=mxquery.BusinessEntityID and bea.ModifiedDate=mxquery.Maxdate
group by bea.BusinessEntityID
having count(bea.BusinessEntityID)>1

select *,row_number() over (partition by bea.businessEntityID order by bea.modifieddate desc, bea.AddressID desc)Rowrank from
AdventureWorks2014.Person.BusinessEntityAddress bea
where bea.BusinessEntityID=332

select * from DimCustomer2

truncate table DimCustomer2


alter table DimCustomer2 add
constraint UK_DimCustomer_CusotmerID Unique(CustomerID, validfrom)

alter table DimCustomer2 
drop constraint UK_DimCustomer_CusotmerID 


delete DimCustomer2
where CustomerID like '%9%4%'
