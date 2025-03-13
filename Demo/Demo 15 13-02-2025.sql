--Table valued function, SQl server view

--logscout, pssdiag
--################################################
	Create database  SQLDEMO

	use SQLDEMO

	CREATE TABLE Department
	  (
		  did INT,
		  ename VARCHAR(50) ,
		  gender VARCHAR(50) ,
		  salary INT ,
		  dept VARCHAR(50) 
	   )


		INSERT INTO Department  VALUES
	  (1, 'David', 'Male', 5000, 'Sales'),
	  (5, 'Shane', 'Female', 5500, 'Finance'),
	  (6, 'Shed', 'Male', 8000, 'Sales'),
	  (7, 'Vik', 'Male', 7200, 'HR'),
	  (2, 'Jim', 'Female', 6000, 'HR'),
	  (13, 'Julie', 'Female', 7100, 'IT'),
	  (14, 'Elice', 'Female', 6800,'Marketing'),
	  (3, 'Kate', 'Female', 7500, 'IT'),
	  (4, 'Will', 'Male', 6500, 'Marketing'),
	  (10, 'Laura', 'Female', 6300, 'Finance'),
	  (11, 'Mac', 'Male', 5700, 'Sales'),
	  (12, 'Pat', 'Male', 7000, 'HR'),
	  (8, 'Vince', 'Female', 6600, 'IT'),
	  (9, 'Jane', 'Female', 5400, 'Marketing'),
	  (15, 'Wayne', 'Male', 6800, 'Finance')


	  SELECT * FROM Department
--#############################
--Table valued function 
/*syntax
	CREATE FUNCTION function_name (@parameter1 datatype [, @parameter2 datatype, ...])
	RETURNS TABLE
	AS
	RETURN (
				-- A single SELECT statement
				SELECT column1, column2, ...
				FROM tables   WHERE conditions
			)

*/
--create function 
	create function highsal(@id int)
	returns table
	as 
	return 
		(
			WITH HIGHSAL
			AS 
			( SELECT *,	ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROWNUM FROM Department 	)
				SELECT * FROM HIGHSAL WHERE ROWNUM=@id 
		)

--Call function 	
	select * from highsal(1)
	select * from highsal(2)
	select * from highsal(3)
	select * from highsal(4)


--Alter function
	create FUNCTION CUBES(@NUM INT)
	RETURNS INt
	AS 
	BEGIN 
		return @NUM*@NUM*@NUM
	END 

--Call FUNCTION 
	select  dbo.cubes(5)
	select  dbo.cubes(15)
	select  dbo.cubes(25)
	select  dbo.cubes(35)
--create function 
	create function datainfo ()
	returns table
	as 
	return (

			Select PP.BusinessEntityID as Empid,FirstName,LastName
			,NationalIDNumber,JobTitle,BirthDate,Gender,HireDate,LoginID
			from AdventureWorks2022.Person.Person PP inner join 
			AdventureWorks2022.HumanResources.Employee HE
			on PP.BusinessEntityID=HE.BusinessEntityID
	)
--	Call function 
	select * from datainfo()
--###################################################################

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    PhoneNumber VARCHAR(15),
    PlanID INT
);

CREATE TABLE CallLogs (
    LogID INT PRIMARY KEY,
    CustomerID INT,
    CallDate DATE,
    CallTime TIME,
    DurationMinutes INT,
    DestinationType VARCHAR(50), -- 'Local', 'International', 'Premium'
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE CustomerPlans (
    PlanID INT PRIMARY KEY,
    TotalMinutes INT, -- Total minutes available in the plan
    RemainingMinutes INT -- Minutes remaining after calls
);


INSERT INTO Customer VALUES
(1, 'John', 'Doe', '123-456-7890', 1),
(2, 'Jane', 'Smith', '234-567-8901', 2),
(3, 'Alice', 'Johnson', '345-678-9012', 3),
(4, 'Bob', 'Martin', '456-789-0123', 4),
(5, 'Charlie', 'Garcia', '567-890-1234', 5),
(6, 'Diana', 'Clark', '678-901-2345', 6),
(7, 'Evan', 'Rodriguez', '789-012-3456', 7),
(8, 'Fiona', 'Lopez', '890-123-4567', 8),
(9, 'George', 'Harris', '901-234-5678', 9),
(10, 'Hannah', 'Lee', '012-345-6789', 10);


INSERT INTO CallLogs VALUES
(1, 1, '2023-07-01', '10:00:00', 30, 'Local'),
(2, 1, '2023-07-01', '15:00:00', 45, 'International'),
(3, 2, '2023-07-01', '09:00:00', 5, 'Premium'),
(4, 2, '2023-07-02', '21:00:00', 60, 'Local'),
(5, 3, '2023-07-03', '14:00:00', 25, 'International'),
(6, 3, '2023-07-04', '16:00:00', 30, 'Local'),
(7, 4, '2023-07-04', '17:00:00', 15, 'Premium'),
(8, 4, '2023-07-05', '18:00:00', 20, 'Local'),
(9, 5, '2023-07-05', '19:00:00', 35, 'International'),
(10, 5, '2023-07-06', '20:00:00', 40, 'Local'),
(11, 6, '2023-07-06', '08:00:00', 10, 'Premium'),
(12, 6, '2023-07-07', '22:00:00', 50, 'International'),
(13, 7, '2023-07-07', '23:00:00', 55, 'Local'),
(14, 7, '2023-07-08', '12:00:00', 60, 'Premium'),
(15, 8, '2023-07-08', '13:00:00', 45, 'International'),
(16, 8, '2023-07-09', '14:00:00', 25, 'Local'),
(17, 9, '2023-07-09', '15:00:00', 5, 'Premium'),
(18, 9, '2023-07-10', '10:00:00', 30, 'International'),
(19, 10, '2023-07-10', '11:00:00', 15, 'Local'),
(20, 10, '2023-07-11', '12:00:00', 20, 'Premium');

INSERT INTO CustomerPlans VALUES
(1, 1000, 925),   
(2, 500, 375),
(3, 1500, 1395),
(4, 800, 725),
(5, 1200, 1085),
(6, 300, 240),
(7, 400, 280),
(8, 750, 630),
(9, 600, 550),
(10, 1000, 965);



select * from Customer
select * from CallLogs
select * from CustomerPlans


--Scenario Description:
--The mobile carrier wants to help customers monitor their usage against their plan limits.
--The system will update the remaining balance of minutes after each call and generate detailed reports 
--showing their usage and the remaining minutes.

--Tables:
--	Customer: Stores customer information.
--	CallLogs: Tracks each call made by customers, including duration, type, and time of day.
--	CustomerPlans: Details about each customer's plan, including total minutes available.
	CREATE FUNCTION USG_LIM(@ID INT,@TYPE VARCHAR(20) )
	RETURNS TABLE 
	AS 
	RETURN
	(
		SELECT cl.CallDate,CL.CallTime, CL.DurationMinutes,CL.DestinationType,
		CASE 
			WHEN CL.DestinationType='Local' THEN CL.DurationMinutes*0.5
			WHEN CL.DestinationType='International' THEN CL.DurationMinutes*0.20
			WHEN CL.DestinationType='pREMIUM' THEN CL.DurationMinutes*.50
		END AS CALLCOST 
		FROM  Customer CC INNER JOIN CallLogs cl ON CC.CustomerID=CL.CustomerID
		INNER JOIN CustomerPlans CP ON CC.PlanID=CP.PlanID
		WHERE CC.CustomerID=@ID AND CL.DestinationType =@TYPE
	)


	SELECT * FROM USG_LIM(2)











	CREATE FUNCTION USG_LIMITS(@ID INT)
	RETURNS @RESULT TABLE
	(
		CallDate DATE,		CallTime TIME,	DurationMinutes INT,	DestinationType VARCHAR(20),	CALLCOST FLOAT,	ErrorMessage VARCHAR(255) NULL 
	)
	AS 
	BEGIN
		IF EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @ID)
		BEGIN
			INSERT INTO @RESULT (CallDate, CallTime, DurationMinutes, DestinationType, CALLCOST)
			SELECT cl.CallDate, cl.CallTime, cl.DurationMinutes, cl.DestinationType
				CASE 
					WHEN cl.DestinationType = 'Local' THEN cl.DurationMinutes * 0.5
					WHEN cl.DestinationType = 'International' THEN cl.DurationMinutes * 0.20
					WHEN cl.DestinationType = 'pREMIUM' THEN cl.DurationMinutes * 0.50
				END
			FROM CallLogs cl
			JOIN Customer cc ON cl.CustomerID = cc.CustomerID
			JOIN CustomerPlans cp ON cc.PlanID = cp.PlanID
			WHERE cc.CustomerID = @ID;
		END
		ELSE
		BEGIN
			INSERT INTO @RESULT (ErrorMessage)
			VALUES ('ID NOT EXIST');
		END

		RETURN;
	END

	SELECT * FROM USG_LIMITS(221)


--############################################################################ 
--SQl server views(Virtual Tables)
	/*Syntax:
			Create view viewname 
			as 
			select statement
	*/


	   	 
  SELECT did,ename,gender,salary,dept FROM Department

--Create view
	Create view vw_dep 
	as 
	SELECT did,ename ,dept FROM Department

--call view 
	select * from vw_dep

	SELECT * FROM Department


--Perform operation on table 

	delete  FROM Department where gender ='male'
	
	UPDATE Department SET ename ='UNKNOWN'
	
	INSERT INTO Department  VALUES
	  (1, 'David', 'Male', 5000, 'Sales'),
	  (5, 'Shane', 'Female', 5500, 'Finance'),
	  (6, 'Shed', 'Male', 8000, 'Sales'),
	  (7, 'Vik', 'Male', 7200, 'HR'),
	  (2, 'Jim', 'Female', 6000, 'HR'),
	  (13, 'Julie', 'Female', 7100, 'IT'),
	  (14, 'Elice', 'Female', 6800,'Marketing'),
	  (3, 'Kate', 'Female', 7500, 'IT'),
	  (4, 'Will', 'Male', 6500, 'Marketing'),
	  (10, 'Laura', 'Female', 6300, 'Finance'),
	  (11, 'Mac', 'Male', 5700, 'Sales'),
	  (12, 'Pat', 'Male', 7000, 'HR'),
	  (8, 'Vince', 'Female', 6600, 'IT'),
	  (9, 'Jane', 'Female', 5400, 'Marketing'),
	  (15, 'Wayne', 'Male', 6800, 'Finance')

--Perform operation on VIEW 

	delete  FROM vw_dep 
	
	INSERT INTO vw_dep  VALUES
	(1, 'David',  'Sales'),
	(5, 'Shane', 'Finance'),
	(6, 'Shed', 'Sales'),
	(7, 'Vik',  'HR'),
	(2, 'Jim', 'HR')

	UPDATE Department SET ename ='UNKNOWN'
	

--call view 
	select * from vw_dep

	SELECT * FROM Department


--Drop table 
	Drop table Department

	
--call view 
	select * from vw_dep


--Binding errors.
--Could not use view or function 'vw_dep' because of binding errors.

--#######################################################

--Create view 1

	Create view vw_userinfo
	as 
	Select PP.BusinessEntityID as Empid,FirstName,LastName
	,NationalIDNumber,JobTitle,BirthDate,Gender,HireDate,LoginID
	from AdventureWorks2022.Person.Person PP inner join 
	AdventureWorks2022.HumanResources.Employee HE
	on PP.BusinessEntityID=HE.BusinessEntityID

	select * from vw_userinfo

--Create view 2

	Create view vw_addinfo
	as 
	Select BusinessEntityID,AddressLine1,City,PostalCode 	from 
	AdventureWorks2022.Person.Address PA inner join 
	AdventureWorks2022.Person.BusinessEntityAddress PB
	on PA.AddressID=PB.AddressID
	
	select * from vw_addinfo

--Create view 3

	Create view vw_empdata
	as 
	select * from vw_userinfo inner join vw_addinfo on empid =BusinessEntityID


	select * from vw_empdata



--Create view
	create view vw_dep  with schemabinding
	as 
	SELECT did,ename ,dept FROM dbo.Department

--call view 
	select * from vw_dep

	SELECT * FROM Department
	drop table Department

--#########################################################
-- materialised / indexed view 


	CREATE TABLE Sales (
		SaleID INT PRIMARY KEY,
		SaleDate DATE,
		Amount DECIMAL(10, 2)
	);
	   	 
	INSERT INTO Sales (SaleID, SaleDate, Amount) VALUES
	(21, '2024-01-01', null),
	(2, '2024-01-01', 150.50),
	(3, '2024-01-02', 120.00),
	(4, '2024-01-02', 80.00),
	(5, '2024-01-03', 200.00),
	(6, '2024-01-03', 50.00),
	(7, '2024-01-04', 75.00),
	(8, '2024-01-04', 125.50),
	(9, '2024-01-05', 180.00),
	(10, '2024-01-05', 90.00),
	(11, '2024-01-06', 60.00),
	(12, '2024-01-06', 110.00),
	(13, '2024-01-07', 100.00),
	(14, '2024-01-07', 130.00),
	(15, '2024-01-08', 85.00),
	(16, '2024-01-08', 145.00),
	(17, '2024-01-09', 95.00),
	(18, '2024-01-09', 105.00),
	(19, '2024-01-10', 250.00),
	(20, '2024-01-10', 100.00);

	
	select * from dbo.Sales

	select SaleDate,count(*) as Counts , sum(isnull(amount, 0)) as Total
	from dbo.Sales
	group by SaleDate


	alter view vw_index with schemabinding 
	as 
	select SaleDate,count_big(*) as Counts , sum(isnull(amount, 0)) as Total
	from dbo.Sales
	group by SaleDate


	drop table sales 

	
--create index
create  nonclustered index iandsaledate  on vw_index(saledate)


	select * from vw_index


