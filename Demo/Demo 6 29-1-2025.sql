--update, delete, truncate)filter(where  and, or , top) 
---########################################################
https://learn.microsoft.com/en-us/sql/t-sql/queries/select-order-by-clause-transact-sql?view=sql-server-ver16
https://learn.microsoft.com/en-us/sql/t-sql/queries/where-transact-sql?view=sql-server-ver16
--#################################################################
--UPDATE( modify the table-data)
/*Syntax:
	update tablename 
	set column=value,column=value,.....
	where column=value
*/

	update department
	set ename ='raju',age =33,gender='male'
	where name =108
	
	update department
	set ename ='Raj',age =28,gender='male', salary =56789
	where name =109
		
	update department
	set name =110,ename ='priya',age =26,gender='female', salary =99789
	where name is null
		
	update department
	set  age =26,gender='female'

	select *  from  department 
--######################################
--delete (remove a records/ multiple records from table )
--syntax : delete from tablename where COLUMN=value 
	delete from department where ename='raj'
	
	delete from department where salary=4553443.00	

	delete from department where name in(104,106,105)

	delete from department 
	set  age =26,gender='female'

--######################################
--Truncate (remove all records from table )
	--Syntax: Truncate table tablename
	Truncate table department 


	select *  from  department 

--######################################
	Create table test
	(id int, ename varchar(20), phnum int)

	insert into test values 
	(101, 'alphabetacharlie',3456789)
--Batch (go n)

	insert into test values 
	(101, 'alphabetacharlie',3456789)
	go 5000

	select  * from test

--capture the time to Delete
	DECLARE @StartTime_Delete DATETIME2 = SYSDATETIME(); --capture start time 21:14:10
	delete from  test
	DECLARE @EndTime_Delete DATETIME2 = SYSDATETIME(); --capture end time 21:14:15
	SELECT 'Time taken to delete : ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND, @StartTime_Delete, @EndTime_Delete)) + ' milliseconds';

--Time taken to delete : 38 milliseconds
--Time taken to Truncate : 25 milliseconds


---capture the time to Truncate 
	DECLARE @StartTime_Delete DATETIME2 = SYSDATETIME() 
	Truncate table test
	DECLARE @EndTime_Delete DATETIME2 = SYSDATETIME() 
	SELECT 'Time taken to Truncate : ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND, @StartTime_Delete, @EndTime_Delete)) + ' milliseconds';

---##############################
---IMPORTexport

	Create database ImportExport


	SELECT * FROM [dbo].[import_export- data]


	DELETE FROM  [dbo].[import_export- data]
SELECT 
Demographics.value('(/IndividualSurvey)[1]','VARCHAR(200)'),
Demographics.value('(/IndividualSurvey/TotalPurchaseYTD)[1]','VARCHAR(200)')
 
 
 select* from Query


 alter table query 
 alter column Demographics xml


CREATE TABLE CustomerOrders
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    OrderData XML
)

insert into CustomerOrders values 
('
<Orders>  
	<CustomerID> C001</CustomerID>
	<OrderDate>2024-26-10</OrderDate>
	<Items>
					<Item>
						<ItemID>1001</ItemID>
						<Description>Widget A</Description>
						<Quantity>4</Quantity>
						<Price>25.00</Price>
					</Item>

	</Items>
</Orders>'
)


select orderdata.value('(/Orders/CustomerID )[1]','VARCHAR(200)') from CustomerOrders

--#################################

use AdventureWorks2022

select BusinessEntityID, FirstName,LastName,ModifiedDate from [Person].[Person]

--1 row
--Top n 
select top 1
BusinessEntityID, FirstName,LastName,ModifiedDate from [Person].[Person]

select top 10
 FirstName,LastName,ModifiedDate from [Person].[Person]

select top 100
BusinessEntityID, FirstName,LastName,ModifiedDate from [Person].[Person]

select top 1000
BusinessEntityID, FirstName,LastName,ModifiedDate from [Person].[Person]

--Filter 
--Where
	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where BusinessEntityID=101

	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where FirstName='ken'

	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where LastName='flores'

-- Comparison Operators
	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where BusinessEntityID=101

	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where BusinessEntityID<>1

	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where BusinessEntityID<=10

	select  FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where BusinessEntityID>=20000
--#############################
--Where columnName =value AND columnName =value and columnName =value AND columnName =value ......
	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where BusinessEntityID=101 and	 FirstName='Houman'

	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where BusinessEntityID=19555 and ModifiedDate='2014-05-22' and FirstName='Emma'

--Where columnName =value or columnName =value or columnName =value or columnName =value ......


	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where FirstName='Emma' or BusinessEntityID=19556 

	
	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where  (BusinessEntityID=19555 or ModifiedDate='2012-05-22')  and FirstName='Emma'

	
	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where  BusinessEntityID=19555 or (ModifiedDate='2012-05-22'  and FirstName='Emma')


--bodmas

	
	select BusinessEntityID, FirstName,LastName,ModifiedDate 
	from [Person].[Person]
	where  
	BusinessEntityID=1 or 
	BusinessEntityID=11 or 
	BusinessEntityID=111 or 
	BusinessEntityID=1111 or 
	BusinessEntityID=11111

	 
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where
	firstname ='Thomas' or
	firstname ='Eugene' or
	firstname ='Andrew' or
	firstname ='Ruth' or
	firstname ='Barry' or
	firstname ='Sidney'






















































































































































































