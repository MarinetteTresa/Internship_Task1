--1 a--
select p.Name as PropertyName,p.id as PropertyID, op.OwnerId as OwnerID from OwnerProperty op
left join Property p
on op.PropertyId=p.Id
where op.OwnerId='1426'
 --1 b--
select p.Name as PropertyName,pf.CurrentHomeValue,p.id as PropetyID from PropertyFinance pf
inner join Property p
on pf.PropertyId=p.Id
inner join OwnerProperty op
on op.PropertyId=p.Id
where op.OwnerId='1426'
--1 c i--
select p.name as PropertyName,p.id as PropetyID,p.name as PropertyName,
type.Name as Rent_Type, 
cast(round((case when tp.PaymentFrequencyId=3 
then tp.PaymentAmount*(datediff(month, tp.startdate,tp.EndDate)+1)
when tp.PaymentFrequencyId=2 
then tp.PaymentAmount*(datediff(WEEK, tp.startdate,tp.EndDate))/2
when tp.PaymentFrequencyId=1 
then tp.PaymentAmount*datediff(WEEK, tp.startdate,tp.EndDate)
end),2) as int) as Total_Rent_Received
from Property p left join OwnerProperty op
on p.Id=op.PropertyId left join TenantProperty tp
on tp.PropertyId=p.Id 
 inner join TargetRentType type on type.Id=tp.PaymentFrequencyId
where op.OwnerId='1426'


--1 c ii--
select p.name as PropertyName,p.id as PropetyID,p.name as PropertyName,
type.Name,
((((case when tp.PaymentFrequencyId=3 
then tp.PaymentAmount*(datediff(month, tp.startdate,tp.EndDate)+1)
when tp.PaymentFrequencyId=2 
then tp.PaymentAmount*(datediff(WEEK, tp.startdate,tp.EndDate))/2
when tp.PaymentFrequencyId=1 
then tp.PaymentAmount*datediff(WEEK, tp.startdate,tp.EndDate)
end)/(datediff(week, tp.StartDate,tp.EndDate)/52)-pf.TotalExpense))/pf.CurrentHomeValue)*100  as Yield_Percentage
from Property p left join OwnerProperty op on p.Id=op.PropertyId 
left join TenantProperty tp on tp.PropertyId=p.Id 
inner join TargetRentType type on type.Id=tp.PaymentFrequencyId
inner join [PropertyFinance] pf on pf.PropertyId=p.Id
where op.OwnerId='1426'

-- 1 d--
select j.JobDescription, s.Status from Job j
inner join [dbo].[JobStatus] s
on j.JobStatusId=s.Id
where s.Status='open'

--1 e--

select pr.name as PropertyName, p.FirstName+' '+p.LastName as Tenant_Full_Name,
pr.id as propertyID,
tp.PaymentAmount as PaymentAmount,type.Name as Payment_Method
from person p
inner  join Tenant t on p.Id=t.Id
inner join TenantProperty tp on t.Id=tp.TenantId
inner join property pr on tp.PropertyId=pr.Id
inner join OwnerProperty op on pr.Id=op.PropertyId
inner join TargetRentType type on type.Id=tp.PaymentFrequencyId
where t.IsActive=1 and op.OwnerId ='1426'
