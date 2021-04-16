--1. Find out all employees and their department by joining employee table with department table with DepartmentID

USE IndustryConnect_DW  
Go

select e.FirstName, e.LastName, d.Name
from Employee e
join Department d
on e.DepartmentId=d.DepartmentId


--2. Find out how many employees in each department and what is the average budget for each employee in each department 

 select d.Name,d.budget as 'Department Budget', COUNT(e.departmentID) as 'Employee Count', 
 d.Budget/nullif(count(e.departmentID),0) as 'AVG'
 from Employee e
 right join Department d
 on e.DepartmentId=d.DepartmentId
 group by d.Name,d.Budget





 --Alberts--
  select  *, count(e.DepartmentId),count(*), count(e.DepartmentId) over (partition by e.DepartmentId ),d.Budget/nullif(count(e.departmentID),0) as 'AVG'
 from Employee e
 right join Department d
 on e.DepartmentId=d.DepartmentId
 group by e.PersonID,e.LastName,	e.FirstName,	e.HireDate,e.DepartmentId,	d.DepartmentId,	d.Name,	d.Budget