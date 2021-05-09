--This is my DimStation. Need to create an Index Column StationID as surrogate key
select Train_Station,Entrance_Type,postcode,suburb,LAT,LONG 
from 
(select s.Train_Station,s.Entrance_Type,postcode,suburb,s.LAT,LONG, 
row_number()over (partition by Train_Station,Entrance_Type,s.lat,s.long order by ( p1.STDistance(geography::Point(s.LAT,s.LONG,4326))) asc ) as row
from Station_Data  s 
cross apply
(select lat,lon,postcode,suburb,geography::Point(d.lat,d.lon,4326) as p1 from Suburb_Data d) as f) as fo
where row=1
order by Train_Station,Entrance_Type

--Creation of DimSchool
Create table DimSchool(
SchoolKey int identity(1,1) Primary key,
SchoolCode float not null, SchoolPostCode float,
SchoolName nvarchar(255) not null,
SchoolAddress nvarchar(255) not null,
TownSuburb nvarchar(255),
StudentNumber float, ICSEAValue float,SchoolGender nvarchar(2255),
SchoolSubType nvarchar(255),SchoolEmail nvarchar(255),
SchoolLatitude float, SchoolLongitude float
) 
--inserting values into DinSchool
insert into dimschool(SchoolCode,SchoolPostCode,SchoolName,SchoolAddress,
TownSuburb,StudentNumber,ICSEAValue,SchoolGender,SchoolSubType,SchoolLatitude,SchoolLongitude)
select school_code,postcode,school_name,School_Address,
town_suburb,student_number,ICSEA_Value,school_gender,school_subtype,School_latitude,
School_longitude
from School_Data

--Creating DimStation
create table DimStation(
StationKey int identity(1,1) Primary key,
StationName nvarchar(2255) not null,
Postcode float, Suburb nvarchar(255),
StreetType nvarchar(255) ,
StreetName nvarchar(255) ,
StationEntranceType nvarchar(255) not null,
StationExitnumber int,
StationLatitude float, StationLongitude float
)

--insert values into dimstation
insert into DimStation(StationName,Postcode,suburb,StreetType,StreetName,StationEntranceType,StationExitnumber,
StationLatitude,StationLongitude)
 select  Train_Station,postcode,suburb,Street_Type,Street_Name,Entrance_Type,Exit_Number,
 LAT,LONG from (select s.Train_Station,postcode,suburb,s.Street_Type,s.Street_Name,s.Entrance_Type,
 s.Exit_Number,s.LAT,LONG, 
row_number()over (partition by Train_Station,Entrance_Type,s.lat,s.long 
order by ( p1.STDistance(geography::Point(s.LAT,s.LONG,4326))) asc ) as row
from Station_Data  s cross apply(
select lat,lon,postcode,suburb,geography::Point(d.lat,d.lon,4326) as p1 
from Suburb_Data d
) as f) as fo
where row=1
order by Train_Station,Entrance_Type

--create DimLocation
create table DimLocation(
LocationKey int identity (1,1) primary key,
PostCode float, Suburb nvarchar(255),
City nvarchar(255),
State nvarchar(255),
StateCode nvarchar(255),
LocationLatitude float, LocationLongitude float
)

--insert values into DimLocation
insert into DimLocation(PostCode,Suburb,City,State,StateCode,LocationLatitude,LocationLongitude)
select postcode,suburb,city,state,state_code,lat,lon
from Suburb_Data


--DimDate
alter table Dimdate alter column DateKey float not null
alter table dimdate 
add constraint DateKey primary key(DateKey)


--DimProperty
create table DimProperty(
propertyKey int identity(1,1) primary key,
PropertyPostCode nvarchar (255), City nvarchar(255),StateCode nvarchar(50),
StateName nvarchar(255),PropertySuburb nvarchar(255),updatedMonth int,updatedYear int, 
) 

select * from PropertyMedian
insert into DimProperty (PropertyPostCode,City,StateCode,Statename,PropertySuburb,updatedMonth,updatedYear)
select Postcode,[City/Town],StateCode,PropertyMedian.StateName,Suburb, cast(Updated_Month as int),cast(Updated_Year as int)
from PropertyMedian

--Create FactPropertymedian
Create table FactPropertyMedian(
--PropertyMedianID int identity(1,1) primary key,
LocationKey int,
PropertyKey int,
SchoolKey int,Stationkey int,
Datekey float, 
PropertyMedian float
) 
