GO
USE RoCALink
--1.	Display CustomerID, CustomerName, Total Item Variety (obtained from total varieties of bike in transaction and ends with 'Types') for every male customer whose name starts with 'A'.

select c.CustomerId                                                              
,      CustomerName                                                              
,      [Total Item Variety] = convert(varchar, COUNT(distinct BikeId)) + ' Types'
from TblCustomer          c 
join TblTransaction       t  on c.CustomerId = t.CustomerId
join TblTransactionDetail td on t.TransactionId = td.TransactionId
where CustomerName like('A%')
	and CustomerGender like('Male')
group by c.CustomerId
,        CustomerName

--2.	Display BikeTypeName, BikeTypeID, And Bike Count (obtained from total bikes that has that groupset), for every bike that has a groupset which name starts with 'Shimano' and has number of gears between 7 and 12.
--group by
select BikeTypeName                    
,      bt.BikeTypeID                   
,      [Bike Count] = COUNT(GroupSetId)
from TblBikeType bt
join TblBike     b  on bt.BikeTypeID = b.BikeTypeId
group by BikeTypeName
,        bt.BikeTypeID
,        GroupSetId
having GroupSetId in (select TblGroupSet.GroupSetId
	from TblBike
	,    TblGroupSet
	where TblBike.GroupSetId = TblGroupSet.GroupSetId
		and GroupSetName like('Shimano')
		and GearNumber >= 7
		and GearNumber <= 12)

--3.	Display StaffID, StaffName, Number of Transactions (obtained from total number of different bike sold in one transaction) and Number of Bikes Sold (obtained from total number of bikes sold by staff, and end with ' Bikes') for every staff whose gender is Female and has a name between 5 and 10 characters long.

select s.StaffId                                                     
,      StaffName                                                     
,      [Number of Transactions] = COUNT(t.TransactionId)             
,      [Number of Bikes Sold] = CAST(SUM(Qty) AS VARCHAR ) + ' Bikes'
from TblStaff             s 
join TblTransaction       t  on s.StaffId = t.StaffId
join TblTransactionDetail td on td.TransactionId = t.TransactionId
where StaffGender like('Female')
	and len(StaffName) >= 5
	and len(StaffName) <= 10
group by s.StaffId
,        StaffName

--4.	Display GroupsetID, GroupsetName, Bike Count (obtained from total number of bikes with that groupset), and Average Price (obtained from average price of bikes with that groupset, using rupiah money format) for every bike that has a brand that starts with 'C', and has an average price of more than 150000000.

select g.GroupSetId                                                  
,      GroupSetName                                                  
,      [Bike Count] = COUNT(g.GroupSetId)                            
,      [Average Price] = 'Rp. ' + CONVERT(varchar, AVG(BikePrice), 1)
from TblGroupSet  g 
join TblBike      b  on g.GroupSetId = b.GroupSetId
join TblBikeBrand bb on b.BikeBrandId = bb.BikeBrandId
group by g.GroupSetId
,        GroupSetName
,        bb.BikeBrandId
having bb.BikeBrandId in(select BikeBrandId
	from TblBikeBrand
	where BrandName like('c%')
		and AVG(BikePrice) > 150000000)

--5.	Display all TransactionID, CustomerName, StaffName, and Transaction Day (obtained from the day name of the transaction date) for every transaction made by staff that has above average salary and was done in February.
--(alias subquery)

select TransactionId
,      CustomerName
,      StaffName
,      x.[Transaction Day]
from (select TransactionId                                         
,            CustomerName                                          
,            StaffName                                             
,            [Transaction Day] = DATENAME(WEEKDAY, TransactionDate)
from TblTransaction t
join TblCustomer    c on t.CustomerId = c.CustomerId
join TblStaff       s on t.StaffId = s.StaffId
where month(TransactionDate) = 2
group by TransactionId
,        CustomerName
,        StaffName
,        StaffSalary
,        TransactionDate
having StaffSalary > (
	select AVG(StaffSalary)
	from TblTransaction t
	join TblStaff       s on t.StaffId = s.StaffId)) x

--6.	Display StaffName, BikeName, TransactionID, Transaction Month (obtained from the month name of the transaction date) for every transaction that has a transaction quantity more than the maximum of all the transaction quantity from all transactions made at the 12th day of the month.
--(alias subquery)

select StaffName
,      BikeName
,      TransactionId
,      x.[Transaction Month]
from (select StaffName                                             
,            BikeName                                              
,            t.TransactionId                                       
,            [Transaction Month] = DATENAME(MONTH, TransactionDate)
from TblTransaction       t 
join TblTransactionDetail td on t.TransactionId = td.TransactionId
join TblStaff             s  on t.StaffId = s.StaffId
join TblBike              b  on td.BikeId = b.BikeId
group by StaffName
,        BikeName
,        t.TransactionId
,        TransactionDate
,        Qty
having Qty > (select MAX(Qty)
	from TblTransactionDetail td
	join TblTransaction       t  on td.TransactionId = t.TransactionId
	where DAY(TransactionDate) = 12 )) x

--7.	Display Average Bikes Sold (obtained from average of total number of bikes sold and ends with ' Bikes'), for every bike that is priced between 100000000 and 150000000 which is not sold over a year ago.
--(alias subquery)

select cast(avg(x.Qty) as varchar) + ' Bikes' as [Average Bikes Sold]
from (select Qty
from TblTransactionDetail td
join TblBike              b  on b.BikeId = td.BikeId
join TblTransaction       t  on td.TransactionId = t.TransactionId
where datediff(YEAR, TransactionDate, getdate()) < 1
	and BikePrice between 100000000 and 150000000) x

--8.	Display Max Bikes Purchased (obtained from max of total quantity of bikes and ends with ' Bikes') for every bike that has name starts with 'S' and are bought between July and December.
--(alias subquery)

select x.[Max Bikes Purchased]
from (select [Max Bikes Purchased] = cast(MAX(QTY) as varchar) + ' Bikes'
from TblTransaction       t 
join TblTransactionDetail td on t.TransactionId = td.TransactionId
where month(TransactionDate) between 7 and 12
	and BikeId in(select BikeId
	from TblBike
	where BikeName like('S%'))) x

--9.	Create a view named CustomerView that display CustomerName, Total Transactions (obtained from total number of different bike bought by customer), Total Bikes Bought (obtained from total quantity of bikes bought by customer from all transactions), and Customer Phone (obtained by replacing 0 in front of the phone number with '+62'), for every customer that has made between 2 and 5 transactions and has bought more than 5 bikes.
GO
create view CustomerView
as
	select CustomerName                                                               
	,      [Total Transactions] = count(distinct BikeId)                              
	,      [Total Bikes Bought] = SUM(Qty)                                            
	,      [Customer Phone] = '+62' + substring(CustomerPhone ,2 , len(CustomerPhone))
	from TblCustomer          c 
	join TblTransaction       t  on c.CustomerId = t.CustomerId
	join TblTransactionDetail td on td.TransactionId = t.TransactionId
	group by CustomerName
	,        CustomerPhone
	having sum(Qty) > 5
		and COUNT( t.TransactionId) between 2 and 5

--10.	Create a view named TransactionView that display TransactionID, Max Quantity (obtained from the maximum quantity of bikes bought in that transaction), Min Quantity (obtained from the minimum quantity of bikes bought in that transaction), and Days Elapsed (obtained from the number of days that has passed since the transaction was made), for every transaction where Max Quantity is not equals Min Quantity and is made by male staff.
GO
create view TransactionView
as
	select t.TransactionId                                           
	,      [Max Quantity] = MAX(Qty)                                 
	,      [Min Quantity] = MIN(Qty)                                 
	,      [Days Elapsed] = DATEDIFF(DAY, TransactionDate, GETDATE())
	from TblTransaction       t 
	join TblTransactionDetail td on td.TransactionId = t.TransactionId
	join TblStaff             s  on s.StaffId = t.StaffId
	where StaffGender like('Male')
	group by t.TransactionId
	,        TransactionDate
	having Max(Qty) != MIN(Qty)
GO


select *
from TblCustomer
select *
from TblStaff
select *
from TblTransaction
select *
from TblTransactionDetail
select *
from TblBike
select *
from TblBikeBrand
select *
from TblBikeType
select *
from TblGroupSet