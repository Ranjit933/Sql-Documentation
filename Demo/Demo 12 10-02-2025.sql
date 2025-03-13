--Crossjoins, self join,merge, set operators ,Function (string)
--###############################################################
--Self learning  
--	https://learn.microsoft.com/en-us/training/modules/transform-data-by-implementing-pivot-unpivot-rollup-cube/
--	https://learn.microsoft.com/en-us/sql/t-sql/functions/functions?view=sql-server-ver16
--#########################################################################
--Crossjoins
	
	Create database Ecommerce
	go
	Use Ecommerce
	go
	CREATE TABLE Meals(MealName VARCHAR(100))
	CREATE TABLE Drinks(DrinkName VARCHAR(100))

	INSERT INTO Drinks VALUES('Orange Juice'), ('Tea'), ('Cofee')
	INSERT INTO Meals VALUES('Omlet'), ('Fried Egg'), ('Sausage')


	
	SELECT * FROM Meals
	SELECT * FROM Drinks

	
	SELECT * FROM Meals CROSS JOIN Drinks

--####################################
		CREATE TABLE emp(
		employee_id INT PRIMARY KEY,
		employee_name VARCHAR(50)
	)

	INSERT INTO emp(employee_id, employee_name)
	VALUES
		(1, 'John Smith'),
		(2, 'Jane Doe'),
		(3, 'Bob Johnson');

	CREATE TABLE dep(
		department_id INT PRIMARY KEY,
		department_name VARCHAR(50)
	);
	INSERT INTO dep(department_id, department_name)
	VALUES
		(101, 'HR'),
		(102, 'Engineering'),
		(103, 'Sales');

		SELECT * FROM emp
		SELECT * FROM dep
	
		SELECT * FROM   dep CROSS JOIN emp

--##################################################
--Self join 

	CREATE TABLE info (
		EmployeeID int PRIMARY KEY,
		EmployeeName varchar(255),
		ManagerID int
	)

	INSERT INTO info (EmployeeID, EmployeeName, ManagerID) VALUES
	(1, 'Alice Johnson', NULL),
	(2, 'Bob Smith', 1),
	(3, 'Catherine Brown', 1),
	(4, 'Daniel Garcia', 1),
	(5, 'Emma Wilson', 1),
	(6, 'Franklin Moore', 2),
	(7, 'Georgia Taylor', 2),
	(8, 'Henry Anderson', 2),
	(9, 'Isabel Thomas', 3),
	(10, 'Jack Martinez', 3),
	(11, 'Kylie Robinson', 3),
	(12, 'Liam Clark', 4),
	(13, 'Mia Rodriguez', 4),
	(14, 'Noah Lewis', 4),
	(15, 'Olivia Lee', 5),
	(16, 'Parker Walker', 5),
	(17, 'Quinn Hall', 5),
	(18, 'Ryan Allen', 6),
	(19, 'Sophia Young', 6),
	(20, 'Tyler Hernandez', 6);
	
	select * from info
-- employee name and manager name 

	select Emp.EmployeeName, Mgr.EmployeeName as ManagerName  from
	info as emp left join info as mgr 
	on mgr.EmployeeID=emp.ManagerID


--Product with same price 
CREATE TABLE Prod (
		ProductID INT PRIMARY KEY,
		ProductName NVARCHAR(50),
		ListPrice DECIMAL(10, 2)
	)

	INSERT INTO Prod (ProductID, ProductName, ListPrice)
	VALUES 
	(1, 'Product A', 100.00),
	(2, 'Product B', 150.00),
	(3, 'Product C', 100.00),
	(4, 'Product D', 200.00),
	(5, 'Product E', 150.00);

	INSERT INTO Prod (ProductID, ProductName, ListPrice)
	values(6, 'Product f', 150.00)

	SELECT * FROm PROD
--Product with same price 
	SELECT * FROm 
	PROD  p1 inner join prod as p2 
	 on p1.ListPrice=p2.ListPrice
	 where  p1.ProductID > p2.productid 

--############################################################

	Create table employee
	( empid int, ename varchar(20), eage int , dob date)


	Create table department 
	(depid int ,empname varchar(20),salary int ,age int  ,
	Company varchar(20) Default 'IBM')

	INSERT INTO EMPLOYEE values 
	(101,'ALPHA',21,'2010-08-11') ,
	(103,'BETA',22,'2009-08-11'),
	(102,'CHARLIE',21,'2010-08-11'),
	(105,'DELTA',25,'2008-08-11'),
	(106,'ECHO',23,'2006-08-11'),
	(104,'FOX',21,'2004-08-11'),
	(109,'CHARLIE',24,'2010-08-11'),
	(107,NULL,25,'2008-08-11')


	insert into department values 
	(101,'Alpha',6000,21,'Vendor'), 
	(102,'fox',7000,21,'Vendor'), 
	(105,'Echo',5100,29,'Vendor'),
	(103,'beta',5100,29,'Vendor'),
	(104,'fox',5100,21,'Vendor'), 
	(105,'tim',5100,25,'Vendor')

	select * from employee
	select * from department

-- jOIN 


	select * from employee INNER JOIN department ON EMPID = depid
--SET OPERATORS 
	--All queries combined using a UNION, INTERSECT or EXCEPT operator
	--must have an equal number of expressions/COLUMN in their target lists.
	--Operand type clash: int is incompatible with date

--union all (Combine + duplicate values)
	select empid,ename,eage  from employee
	union all
	select depid,empname,age  from department ORDER BY empid ASC
	
--union   (Combine + UNIQUE values)
	select empid,ename,eage  from employee
	union  
	select depid,empname,age  from department ORDER BY empid ASC
	
--intersect  (matching  + Unique values)
	
	select empid,ename,eage  from employee
	intersect  
	select depid,empname,age  from department ORDER BY empid ASC

--Except   (minus Unique values)
	select empid,ename,eage  from employee
	 Except
	select depid,empname,age  from department ORDER BY empid ASC


--######################################### 
---CREATE TABLE WITH DATA 
--SELECT INTO 	
	Select PP.BusinessEntityID as Empid,FirstName,LastName
	,NationalIDNumber,JobTitle,BirthDate,Gender,HireDate,LoginID
	INTO ADVENTUREWORKSDATA		--THIS LINE WILL CREATE NEW TABLE = ADVENTUREWORKSDATA
	from AdventureWorks2022.Person.Person PP inner join 
	AdventureWorks2022.HumanResources.Employee HE
	on PP.BusinessEntityID=HE.BusinessEntityID


--APPEND DATA INTO EXISTINGF TABLE
--INSERT INTO 	
	INSERT INTO ADVENTUREWORKSDATA

	Select PP.BusinessEntityID as Empid,FirstName,LastName
	,NationalIDNumber,JobTitle,BirthDate,Gender,HireDate,LoginID 
	from AdventureWorks2022.Person.Person PP inner join 
	AdventureWorks2022.HumanResources.Employee HE
	on PP.BusinessEntityID=HE.BusinessEntityID

	SELECT * FROM  ADVENTUREWORKSDATA

--#################################################################
-- Function 
--AGGREGATE FUNCTION(SUM , MAX MIN AVG COUNT)
--String function 

'ZXCV BNM,./dfg hjkl:"@#$%^& ()_23456 7890-'


USE AdventureWorks2022
--len(expression/column name)
	 select  FirstName , LEN(FIRSTNAME) AS LENGTHS  from Person.Person 
	  
	 select   LEN('ALPHA BETA')
	 select   LEN(' ALPHA BETA')
	 select   LEN('ALPHA BETA ')
 --trim(expression) remove the lead and trial spaces 
 	 select   TRIM('    ALPHA BETA   ')	 
	 select   LEN(TRIM('    ALPHA BETA   '))
	 select   TRIM('    ALPHA BETA   ')

--Left(expression, n) & Right(expression, n)
	 select  FirstName , LEFT (FIRSTNAME,10 ) AS LENGTHS from Person.Person 
	  
	 select  FirstName , LEFT (FIRSTNAME,2) AS LENGTHS from Person.Person 
	  
	 select  FirstName , LEFT (FIRSTNAME,3) AS LENGTHS from Person.Person 
	  
	 select  FirstName , Right (FIRSTNAME,1) AS LENGTHS from Person.Person 
	  
	 select  FirstName , Right (FIRSTNAME,2) AS LENGTHS from Person.Person 
	  
	 select  FirstName , Right (FIRSTNAME,3) AS LENGTHS from Person.Person 
	  
--Upper(expression) and lower(expression)

	 select  FirstName , Upper (FIRSTNAME ) AS VAL
	  , lower (FIRSTNAME) AS VAL from Person.Person 

--Concat(expression,expression,expression,...)

	select  FirstName,MiddleName,LastName,
	CONCAT( FirstName,MiddleName,LastName) AS VAL from Person.Person 
	
	select  FirstName,MiddleName,LastName,
	CONCAT( FirstName,' ' ,MiddleName,' ' ,LastName) AS VAL from Person.Person 

	select  FirstName,MiddleName,LastName,
	CONCAT( FirstName,';' ,MiddleName,';' ,LastName) AS VAL from Person.Person 

--Concat_ws('',expression,expression,expression,...)

	select  FirstName,MiddleName,LastName,
	Concat_ws( ';' ,FirstName,MiddleName,LastName) AS VAL from Person.Person 
	
	select  FirstName,MiddleName,LastName,
	Concat_ws( ' ' ,FirstName,MiddleName,LastName) AS VAL from Person.Person 

--############################## 
	--Input = syed  or aLPha or alexen
	--Output =Syed
	 DECLARE @NAME  VARCHAR(20)
	 SET @NAME ='aLPha'
	SELECT CONCAT(UPPER(LEFT(@NAME,1)), LOWER(RIGHT(@NAME,LEN(@NAME)-1)))



--Scenarios
	--Input SSN: '123-45-6789'
	--Expected Output Masked SSN: '***-**-6789'
--Scenarios
	--Input Product Code: 'ABC-123-XYZ'
	--Expected Output New Product Code: 'ABC-789-XYZ'
--Scenarios
	--Input Full Name: 'John A. Doe'
	--Expected Output Initials: 'JAD'
--Scenarios
	--Input Phone Number: '1234567890'
	--Expected Output Formatted Phone Number: '(123) 456-7890'

  -- Set Operators Questions

--1. UNION:
--   - Question: Write a query to list all `BusinessEntityID` values that appear in either the `Person.Person` table or the `Sales.Customer` table, or both.

--2. UNION ALL:
--   - Question: Write a query to list all `BusinessEntityID` values, including duplicates, from both the `Person.Person` table and the `Sales.Customer` table.

--3. INTERSECT:
--   - Question: Write a query to find all `BusinessEntityID` values that are present in both the `Person.Person` table and the `Sales.Customer` table.

--4. EXCEPT:
--   - Question: Write a query to find all `BusinessEntityID` values that are present in the `Person.Person` table but not in the `Sales.Customer` table.

--5. UNION with additional columns:
--   - Question: Write a query to list all `FirstName` and `LastName` combinations from both the `Person.Person` table and the `HumanResources.Employee` table. Ensure there are no duplicates.

--6. UNION ALL with filtering:
--   - Question: Write a query to list all `EmailAddress` values from the `Person.EmailAddress` table and `Sales.SalesPersonEmailAddress` table, including duplicates.

--7. INTERSECT with condition:
--   - Question: Write a query to find all `ProductID` values that are in both the `Sales.SalesOrderDetail` table and the `Production.Product` table and have a `ProductID` less than 1000.

--8. EXCEPT with condition:
--   - Question: Write a query to find all `SalesOrderID` values in the `Sales.SalesOrderHeader` table that are not in the `Sales.SalesOrderDetail` table and where the `OrderDate` is in the year 2022.

--9. Complex UNION:
--   - Question: Write a query to combine the `Name` from `Production.Product` and `Production.ProductSubcatery` tables. Ensure that the combined list is unique.

--10. Complex EXCEPT:
--    - Question: Write a query to list all `EmployeeID` values from the `HumanResources.Employee` table that do not appear in the `Sales.SalesOrderHeader` table, ensuring that the list only includes active employees.






















































































































































































































