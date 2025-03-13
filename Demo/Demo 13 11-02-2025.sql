-- Function (date &  time, conversion ) 
--###########################################################
--Self learning  
	https://learn.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver16
	https://learn.microsoft.com/en-us/training/modules/transform-data-by-implementing-pivot-unpivot-rollup-cube/
	https://learn.microsoft.com/en-us/sql/t-sql/functions/functions?view=sql-server-ver16
--###########################################################


--string Function

--replace ( string , old value, new value)

	select replace('Hello 123 World','123','SQL')

	select  FirstName, REPLACE(firstname,'kim','ajay')as newnames  	from Person.Person 

	select  FirstName, REPLACE(firstname,'e','12345')as newnames  	from Person.Person 


--STUFF ( string, start, length, new_string )
'Hello World'
 12345678901
'Hello SQL World'


select stuff('Hello World',7,0,'SQL ')

select stuff('Hello World',7,5,'SQL ')

--CHARINDEX ( substring, string, [start_position] ) 

Hello World
12345678901

	select charindex (' ','Hello World')

	select charindex ('w','Hello World')

	select charindex ('d','Hello World')

	select charindex ('o','Hello World')

	select charindex ('or','Hello World')
	
	select charindex ('o','Hello World',6)

	select charindex ('l','Hello World',6)
   
	select charindex ('@','alpha@gmail@com')

	select charindex ('@','alpha@gmail@com',9)

	select charindex ('l','alpha@gmail@com')

	select charindex ('l','alpha@gmail@com',3)

--SUBSTRING ( string, start, length )
demo tom john
1234567890123 

select SUBSTRING('demo tom john',1,4)
select SUBSTRING('demo tom john',10,4)
select SUBSTRING('demo tom john',6,3)


--####################################
	 create table empemail
	(email varchar(100))


	INSERT INTO empemail VALUES 
	('jane.doe@example.com'),
	('john.smith@workmail.net'),
	('alex.jones@university.edu'),
	('lisa.wong@techhub.org'),
	('mike.brown@services.co.uk'),
	('sara.lee@marketplace.com'),
	('dave.wilson@creativeagency.us'),
	('emily.harris@globalenterprise.com'),
	('carlos.garcia@networksolutions.es'),
	('anna.zhao@researchinst.cn');

		select email from empemail
--Scenarios 
	--input--> jane.doe@example.com
	--output--> example.com

select charindex ('@','jane.doe@example.com')+1--identify the position of @ 

select SUBSTRING('jane.doe@example.com',10,13)

select SUBSTRING('jane.doe@example.com',charindex ('@','jane.doe@example.com')+1
,len('jane.doe@example.com'))


	select email,charindex ('@',email)+1 as positionof@,
	SUBSTRING(email,charindex ('@',email)+1,len(email))
	from empemail

--###############################	

	select FirstName,MiddleName,LastName,
	coalesce(MiddleName,'Unknow'), ISNULL(MiddleName,'Unknow')
	from person.Person

--Date Time 'yyyy-mm-dd hh:mm:Ss'
	--Date(Year, month, day, quarter, week, weekday, day of year)
	--Time (Hours, minutes, second, miliseconds, microseconds, nanoseconds)

	select GETDATE()
	
	select sysdatetime()

	select sysdatetimeoffset()
		
	select GETDATE()

	select year(GETDATE())

	select month(GETDATE())

	select day(GETDATE())

	SELECT BusinessEntityID,BirthDate,HireDate,
	year(BirthDate) as year, month( BirthDate)as months,day(BirthDate) as days
	FROM HumanResources.Employee

--Datename ( date and time parts --> returns nvarchar )
	select Datename(YEAR,GETDATE())
	select Datename(MONTH,GETDATE())
	select Datename(DAY,GETDATE())
	select Datename(WEEK,GETDATE())
	select Datename(WEEKDAY,GETDATE())
	select Datename(DAYOFYEAR,GETDATE())
	select Datename(QUARTER,GETDATE())

	select Datename(HOUR,GETDATE())
	select Datename(MINUTE,GETDATE())
	select Datename(SECOND,GETDATE())
	select Datename(MILLISECOND,GETDATE())
	select Datename(MICROSECOND,GETDATE())
	select Datename(NANOSECOND,GETDATE())
--DATEPART()returns an integer corresponding to the datepart specified	
	select DATEPART(YEAR,GETDATE())
	select DATEPART(MONTH,GETDATE())
	select DATEPART(DAY,GETDATE())
	select DATEPART(WEEK,GETDATE())
	select DATEPART(WEEKDAY,GETDATE())
	select DATEPART(DAYOFYEAR,GETDATE())
	select DATEPART(QUARTER,GETDATE())

	select DATEPART(HOUR,GETDATE())
	select DATEPART(MINUTE,GETDATE())
	select DATEPART(SECOND,GETDATE())
	select DATEPART(MILLISECOND,GETDATE())
	select DATEPART(MICROSECOND,GETDATE())
	select DATEPART(NANOSECOND,GETDATE())


--datediff( DATEPART, lowerdate, higherdate )
--returns an integer corresponding

	SELECT BusinessEntityID,BirthDate,HireDate ,
	datediff(YEAR,BirthDate,HireDate) as years,
	datediff(MONTH,BirthDate,HireDate) as months,
	datediff(DAY,BirthDate,HireDate) as days ,
	datediff( WEEK, BirthDate,HireDate )AS WEEKS,
	datediff( QUARTER, BirthDate,HireDate )AS QUARTERS,
	datediff( HOUR, BirthDate,HireDate )AS HOURS,
	datediff( MINUTE, BirthDate,HireDate )AS MINUTES
	FROM HumanResources.Employee

	
	SELECT BusinessEntityID,BirthDate,HireDate ,
	datediff(YEAR,BirthDate,HireDate) as age,
	datediff(YEAR,HireDate,getdate()) as exps 
	FROM HumanResources.Employee


	
	SELECT BusinessEntityID,BirthDate,HireDate ,getdate(),
	cast(datediff(MONTH,HireDate,getdate())as float)/12  as exps 
	FROM HumanResources.Employee
 
--dateadd(datepart, number, date)



	SELECT BusinessEntityID,HireDate 	,
	dateadd(YEAR,10,HireDate) as years,
	dateadd(MONTH,170,HireDate) as months,
	dateadd(DAY,1500,HireDate) as days ,
	dateadd( WEEK, 88,HireDate )AS WEEKS,
	dateadd( QUARTER, 250,HireDate )AS QUARTERS
	FROM HumanResources.Employee
	
	SELECT BusinessEntityID,HireDate 	,
	dateadd(YEAR,-10,HireDate) as years,
	dateadd(MONTH,-170,HireDate) as months,
	dateadd(DAY,-150,HireDate) as days ,
	dateadd( WEEK, -88,HireDate )AS WEEKS,
	dateadd( QUARTER, -250,HireDate )AS QUARTERS
	FROM HumanResources.Employee


--##################################
--Conversion
	--data type -->
		--Numeric-->string -->numeric -->datetime 
		--string-->string -->datetime 
		--datetime-->string -->datetime 
--##################################
	SELECT 1+1
	SELECT 'A'+'B'	

	SELECT 'A'+1
	
	SELECT BusinessEntityID,LoginID,
	BusinessEntityID+LoginID AS NEWIDS
	FROM HumanResources.Employee

--Conversion
	--CAST ( expression AS target_data_type )

	SELECT 'A'+CAST(1 AS VARCHAR)

	--CONVERT ( target_data_type, expression , [style] )

	SELECT 'A'+CONVERT(VARCHAR, 1)


	SELECT BusinessEntityID,LoginID,
	CAST(BusinessEntityID AS VARCHAR)+LoginID AS NEWIDS,
	CONVERT(VARCHAR, BusinessEntityID)+LoginID AS NEWIDS
	FROM HumanResources.Employee

https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/

	SELECT  CAST(GETDATE() AS VARCHAR)

	SELECT  CONVERT(VARCHAR, GETDATE(),1)
	select convert(varchar,GETDATE(),1)
	select convert(varchar,GETDATE(),4)
	select convert(varchar,GETDATE(),5)
	select convert(varchar,GETDATE(),6)
	select convert(varchar,GETDATE(),11)
	select convert(varchar,GETDATE(),21)
	select convert(varchar,GETDATE(),33)
	select convert(varchar,GETDATE(),35)
	select convert(varchar,GETDATE(),104)

	select convert(varchar,GETDATE(),8)
	select convert(varchar,GETDATE(),9)
	select convert(varchar,GETDATE(),24)
	select convert(varchar,GETDATE(),108)

	 select CONVERT(varchar, GETDATE(),0)
	 select CONVERT(varchar, GETDATE(),13)
	 select CONVERT(varchar, GETDATE(),20)
	 select CONVERT(varchar, GETDATE(),21)
	 select CONVERT(varchar, GETDATE(),27)
	 select CONVERT(varchar, GETDATE(),127)


--###################################################
--FORMAT(expression, format, culture)
	SELECT BusinessEntityID,Rate
	FROM HumanResources.EmployeePayHistory

	SELECT BusinessEntityID,Rate,
	FORMAT(RATE ,'C','EN-IN') AS INR,
	FORMAT(RATE ,'C','EN-US') AS USD,
	FORMAT(RATE ,'C','EN-GB') AS UK,
	FORMAT(RATE ,'C','EN-AU') AS AU
	FROM HumanResources.EmployeePayHistory

'yyyy-dd-MM hh-mm-ss tt'

	select getdate(), FORMAT(getdate(),'yyyy-dddd-MMMM hh-mm-ss')
	select getdate(), FORMAT(getdate(),'yyy-ddd-MMM hh-mm-ss')
	select getdate(), FORMAT(getdate(),'yy-dd-MM hh-mm-ss')

	
	select   FORMAT(getdate(),'dddd, MMMM-yyyy')

	select   FORMAT(getdate(),'dddd,dd-MMMM-yyyy')

	
	select FORMAT(GETDATE(), 'dddd, MMM-yy-dd hh:mm:ss tt')
















































































