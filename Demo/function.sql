--USER DEFINED (Table valued & Scalar valued function  ) VIEW
	https://learn.microsoft.com/en-us/sql/t-sql/statements/create-function-transact-sql?view=sql-server-ver16
	https://learn.microsoft.com/en-us/sql/relational-databases/views/views?view=sql-server-ver16
--#######################################################
Create database  SQLDEMO
go
use SQLDEMO
go

CREATE TABLE Department
(
did INT,
ename VARCHAR(50) ,
gender VARCHAR(50) ,
salary INT ,
dept VARCHAR(50) 
)

go
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

go
SELECT *  FROM Department
--##########################################

--User defined function
--Scalar valued function 
/*	
	C
*/

--CUBE OF A NUMBER 
	DECLARE @NUM INT 
	SET @NUM =2 
	SET @NUM =@NUM*@NUM*@nUM
	PRINT @NUM


--Create Function 
	Create Function Cubes()
	returns int
	as 
	begin 		
		DECLARE @NUM INT 
		SET @NUM =2 
		SET @NUM =@NUM*@NUM*@nUM
		return @NUM
	end  

--Call Function 

	select dbo.cubes()


SELECT * ,dbo.cubes() FROM Department


--Alter Function 
	Alter Function Cubes( @NUM INT )
	returns int
	as 
	begin 			 
		return @NUM*@NUM*@nUM 
	end  

--Call Function 

	select dbo.cubes(3)
	select dbo.cubes(4)
	select dbo.cubes(5)

--########################################
	 CREATE TABLE Products
	(
		ProductID INT PRIMARY KEY,
		ProductName VARCHAR(255),
		Price DECIMAL(10, 2),
		AgeInMonths INT
	);

	INSERT INTO Products (ProductID, ProductName, Price, AgeInMonths) VALUES
	(1, 'Laptop', 1000.00, 5),
	(2, 'Tablet', 450.00, 9),
	(3, 'Smartphone', 800.00, 15),
	(4, 'Monitor', 300.00, 30);

	select * from products


-- Dicount price =price -(price*discount/100)

	create Function DP( @price float, @dis float)
	returns float
	as 
	begin 			 
		return @price -(@price*@dis/100)
	end

	select dbo.dp(100,15.75)

	select *, dbo.dp(price,15.75) as DP from products

--###################################################

	CREATE TABLE GoodReceiveNotes
	(
		GRNID INT PRIMARY KEY,
		VendorID INT,
		GRNDate DATE,
		ItemID INT UNIQUE,
		QuantityReceived INT,
		UnitPrice DECIMAL(10, 2),
		TotalAmount AS (QuantityReceived * UnitPrice),
		ReceivedBy NVARCHAR(50)
	);

	INSERT INTO GoodReceiveNotes (GRNID, VendorID, GRNDate, ItemID, QuantityReceived, UnitPrice, ReceivedBy)
	VALUES
	(1, 101, '2024-08-01', 501, 100, 15.00, 'Alice Johnson'),
	(2, 102, '2024-08-02', 502, 50, 20.00, 'Bob Smith'),
	(3, 101, '2024-08-03', 503, 150, 10.00, 'Charlie Brown'),
	(4, 103, '2024-08-04', 504, 75, 30.00, 'David Lee'),
	(5, 104, '2024-08-05', 505, 200, 5.00, 'Eve Davis'),
	(6, 102, '2024-08-06', 506, 120, 12.50, 'Frank White'),
	(7, 105, '2024-08-07', 507, 80, 25.00, 'Grace Hall'),
	(8, 101, '2024-08-08', 508, 60, 18.00, 'Helen King'),
	(9, 104, '2024-08-09', 509, 90, 22.00, 'Ivy Green'),
	(10, 103, '2024-08-10', 510, 110, 14.50, 'Jack Black');
	   
	SELECT GRNID,VendorID,GRNDate,ItemID,QuantityReceived,UnitPrice,ReceivedBy
	FROM GoodReceiveNotes

--GoodReceive values = QuantityReceived*UnitPrice

	DECLARE @totalval float 
	select @totalval = QuantityReceived * UnitPrice	FROM GoodReceiveNotes 
	select @totalval

	alter function GoodReceive(@id int)
	returns float
	as
	begin 
		DECLARE @totalval float 
		select @totalval = QuantityReceived * UnitPrice	FROM GoodReceiveNotes 
		return @totalval
	end 

--call function GoodReceive values
	select QuantityReceived , UnitPrice,dbo.GoodReceive(grnid)FROM GoodReceiveNotes  

---####################################################
--Practice question 1
--formula
	--EMI= principle + (Principle* rate *time )/100)) / time 

	CREATE TABLE LoanDetails
	(
		LoanID INT PRIMARY KEY,
		Principal DECIMAL(18,2),
		Rate DECIMAL(5,2),
		Time INT
	);
	INSERT INTO LoanDetails (LoanID, Principal, Rate, Time) VALUES
	(1, 10000, 10, 12), 
	(2, 5000, 5, 24),   
	(3, 15000, 7.5, 36), 
	(4, 20000, 9, 48), 
	(5, 25000, 6, 60)


	select * from LoanDetails
 ---####################################################
--Practice question 2 
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE Purchases (
    PurchaseID INT PRIMARY KEY,
    CustomerID INT,
    PurchaseDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Inserting customers
INSERT INTO Customer VALUES
(1, 'John', 'Doe', 'johndoe@email.com'),
(2, 'Jane', 'Smith', 'janesmith@email.com'),
(3, 'Alice', 'Johnson', 'alicejohnson@email.com'),
(4, 'Bob', 'Brown', 'bobbrown@email.com'),
(5, 'Carol', 'Davis', 'caroldavis@email.com'),
(6, 'David', 'Wilson', 'davidwilson@email.com'),
(7, 'Eve', 'Taylor', 'evetaylor@email.com'),
(8, 'Frank', 'Moore', 'frankmoore@email.com'),
(9, 'Grace', 'Anderson', 'graceanderson@email.com'),
(10, 'Hank', 'Thomas', 'hankthomas@email.com'),
(11, 'Irene', 'Edwards', 'ireneedwards@email.com'),
(12, 'Jerry', 'Mitchell', 'jerrymitchell@email.com'),
(13, 'Katie', 'Robinson', 'katierobinson@email.com'),
(14, 'Louis', 'Walker', 'louiswalker@email.com'),
(15, 'Megan', 'Lee', 'meganlee@email.com'),
(16, 'Nancy', 'Hall', 'nancyhall@email.com'),
(17, 'Oscar', 'Young', 'oscaryoung@email.com'),
(18, 'Patty', 'King', 'pattyking@email.com'),
(19, 'Quincy', 'Scott', 'quincyscott@email.com'),
(20, 'Rachel', 'Wright', 'rachelwright@email.com');

-- Inserting purchases
INSERT INTO Purchases VALUES
(1, 10, '2023-07-01', 2000.00),
(2, 1, '2023-07-02', 300.00),
(3, 2, '2023-07-01', 450.00),
(4, 3, '2023-07-01', 120.00),
(5, 3, '2023-07-02', 130.00),
(6, 3, '2023-07-03', 150.00),
(7, 4, '2023-07-01', 250.00),
(8, 5, '2023-07-01', 650.00),
(9, 5, '2023-07-02', 150.00),
(10, 6, '2023-07-01', 550.00),
(11, 6, '2023-07-02', 500.00),
(12, 7, '2023-07-01', 350.00),
(13, 8, '2023-07-01', 280.00),
(14, 9, '2023-07-01', 700.00),
(15, 9, '2023-07-02', 100.00),
(16, 10, '2023-07-01', 400.00),
(17, 11, '2023-07-01', 300.00),
(18, 12, '2023-07-01', 110.00),
(19, 13, '2023-07-01', 105.00),
(20, 14, '2023-07-01', 205.00);


select * from customer
select * from Purchases
update Purchases
 set Amount =5000
 where CustomerID=1

--Scenario Description:
--A retail company wants to implement a dynamic discount system where customers get 
--discounts based on the total amount they have spent historically. The discount is calculated using a tiered system:
	--Customers who have spent over $5000 get a 15% discount on future purchases.
	--Customers who have spent between $1000 and $5000 get a 10% discount.
	--Customers who have spent less than $1000 get a 5% discount.

	create function getdiscount(@custid int)
	returns float
	as 
	begin 
		declare @totalspent float, @discountrate float
		select @totalspent=SUM(amount) from Purchases where CustomerID=@custid
		if @totalspent>=5000
			set @discountrate=15.0
		else if @totalspent between  1000 and  5000
			set @discountrate=10.0
		else if @totalspent<1000
			set @discountrate=5
			 return @discountrate
	end 



select * from customer
select * , dbo.getdiscount(customerid) from Purchases

select  dbo.getdiscount(6)

--#####################################################
--Practice question 3
--healthcare system

CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DOB DATE
);

CREATE TABLE HealthMetrics (
    MetricID INT PRIMARY KEY,
    PatientID INT,
    MetricDate DATE,
    BloodPressure INT,
    Cholesterol INT,
    Smoker BIT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
-- Inserting patients
INSERT INTO Patient VALUES
(1, 'John', 'Doe', '1970-05-15'),
(2, 'Jane', 'Smith', '1982-07-20'),
(3, 'Alice', 'Johnson', '1990-11-01'),
(4, 'Bob', 'Brown', '1955-01-22'),
(5, 'Carol', 'Davis', '1965-03-15'),
(6, 'David', 'Wilson', '1945-12-09'),
(7, 'Eve', 'Taylor', '1975-04-05'),
(8, 'Frank', 'Moore', '1985-05-19'),
(9, 'Grace', 'Anderson', '1978-08-25'),
(10, 'Hank', 'Thomas', '1968-09-30');

-- Inserting health metrics
INSERT INTO HealthMetrics VALUES
(1, 1, '2023-07-10', 120, 190, 0),
(2, 2, '2023-07-11', 130, 200, 1),
(3, 3, '2023-07-12', 125, 180, 0),
(4, 4, '2023-07-13', 140, 220, 1),
(5, 5, '2023-07-14', 135, 210, 0),
(6, 6, '2023-07-15', 145, 230, 1),
(7, 7, '2023-07-16', 130, 195, 0),
(8, 8, '2023-07-17', 138, 205, 1),
(9, 9, '2023-07-18', 128, 198, 0),
(10, 10, '2023-07-19', 132, 207, 1);

Metric					Good Range			Bad Range				Notes
Age	-					-					> 50 years			Higher age increases risk, but no "good" range for age.
Blood Pressure (mmHg)	<= 120/80			> 130/80			Values above 130/80 are considered high.
Cholesterol (mg/dL)		< 200				> 200				High cholesterol increases cardiovascular risk.
Smoker					No (0)				Yes (1)				Smoking is a major risk factor for many diseases.

select * from Patient
select * from HealthMetrics

--Scenario Description:
--A healthcare system wants to assess patient risk for cardiovascular diseases based on 
--various parameters such as age, blood pressure, cholesterol levels, and smoking status.
--The risk score will help healthcare providers prioritize interventions.
--Tables:
	--Patient: Stores patient demographics and identifiers.
	--HealthMetrics: Tracks health metrics for each patient over time.

	DEclare @age int, @bloodpressure int, @cholesterol int, @smoking bit, @score int =0

	select 
	@age = DATEDIFF(Year,DOB,GETDATE()),
	@bloodpressure=BloodPressure,
	@cholesterol=Cholesterol,
	@smoking=Smoker
	from Patient P join  HealthMetrics h
	 on P.PatientID=h.PatientID where P.PatientID=@patientid
	  order by MetricDate desc

		if @age >50
			set @score =@score +20 
		if @bloodpressure >130 
			set @score =@score+25 
		if @cholesterol >200 
			set @score =@score+30 
		if @smoking=1 
			set @score =@score+25 
	print @score 

--##############################################################

--1. Healthcare Cost Calculation
--Formula:TotalCost = BaseFee + MedicationFee + (BaseFee + MedicationFee) * TaxRate / 100


	CREATE TABLE PatientBills
	(
		BillID INT PRIMARY KEY,
		BaseFee DECIMAL(10,2),
		MedicationFee DECIMAL(10,2),
		TaxRate DECIMAL(5,2)
	);

	INSERT INTO PatientBills (BillID, BaseFee, MedicationFee, TaxRate) VALUES
	(1, 200, 50, 10),
	(2, 300, 75, 12),
	(3, 150, 25, 8),
	(4, 400, 100, 15),
	(5, 250, 60, 9);

--Government Subsidy Calculation
--Formula:SubsidyAmount = ServiceCost * SubsidyRate / 100

	CREATE TABLE HealthcareServices
	(
		ServiceID INT PRIMARY KEY,
		ServiceCost DECIMAL(10,2),
		SubsidyRate DECIMAL(5,2)
	);

	INSERT INTO HealthcareServices (ServiceID, ServiceCost, SubsidyRate) VALUES
	(1, 500, 20),
	(2, 800, 25),
	(3, 300, 15),
	(4, 1000, 30),
	(5, 750, 10);
	
--Taxation on Medical Devices
--Formula:TaxAmount = DeviceCost * TaxPercentage / 100

	CREATE TABLE MedicalDevices
	(
		DeviceID INT PRIMARY KEY,
		DeviceName NVARCHAR(50),
		DeviceCost DECIMAL(10,2),
		TaxPercentage DECIMAL(5,2)
	);

	INSERT INTO MedicalDevices (DeviceID, DeviceName, DeviceCost, TaxPercentage) VALUES
	(1, 'X-Ray Machine', 50000, 18),
	(2, 'MRI Machine', 100000, 12),
	(3, 'Ultrasound Machine', 30000, 15),
	(4, 'Ventilator', 75000, 10),
	(5, 'ECG Machine', 20000, 5);

--Insurance Coverage Calculation
--Formula:CoverageAmount = TotalBill * CoveragePercentage / 100

	CREATE TABLE InsuranceClaims
	(
		ClaimID INT PRIMARY KEY,
		TotalBill DECIMAL(10,2),
		CoveragePercentage DECIMAL(5,2)
	);

	INSERT INTO InsuranceClaims (ClaimID, TotalBill, CoveragePercentage) VALUES
	(1, 5000, 80),
	(2, 3000, 70),
	(3, 10000, 90),
	(4, 7500, 85),
	(5, 2500, 75);
--Monthly Premium Calculation
--Formula:MonthlyPremium = AnnualPremium / Months
	CREATE TABLE HealthPlans
	(
		PlanID INT PRIMARY KEY,
		AnnualPremium DECIMAL(10,2),
		Months INT
	);

	INSERT INTO HealthPlans (PlanID, AnnualPremium, Months) VALUES
	(1, 1200, 12),
	(2, 2400, 24),
	(3, 3600, 36),
	(4, 4800, 48),
	(5, 6000, 60);
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

	Create function Highsal(@val int)
	returns table 
	as 
	return 		(
				with highsal 
				as 
				( 	SELECT *  , row_number() over( order by salary desc) as rownum FROM Department )
				select * from highsal where rownum =@val

			)


--call function 
	select  * from Highsal(1)
	select  * from Highsal(2)
	select  * from Highsal(3)
	select  * from Highsal(4)

--###################################################################

--Scenario Description:
--The mobile carrier wants to help customers monitor their usage against their plan limits.
--The system will update the remaining balance of minutes after each call and generate detailed reports 
--showing their usage and the remaining minutes.

--Tables:
--	Customer: Stores customer information.
--	CallLogs: Tracks each call made by customers, including duration, type, and time of day.
--	CustomerPlans: Details about each customer's plan, including total minutes available.
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



	select Cl.CallDate ,CL.CallTime,CL.DurationMinutes,CL.DestinationType,
	case 
		when CL.DestinationType='Local' then CL.DurationMinutes*.05
		when CL.DestinationType='international' then CL.DurationMinutes*.20
		when CL.DestinationType='Premium' then CL.DurationMinutes*.50
		else '0'
	end as callcost ,
	CP.RemainingMinutes-CL.DurationMinutes as Balance
	from Customer  CC join  CallLogs  CL on CC.CustomerID=CL.CustomerID
	join  CustomerPlans CP on CP.PlanID=CC.PlanID
	where CC.CustomerID=??

--####################################### 
--SQl server views
--Virtual Tables
	/*Syntax:
			Create view viewname 
			as 
			select statement
	*/

  SELECT did,ename,gender,salary,dept FROM Department

--Create view
	Create view vw_read 
	as 
	SELECT did,ename,dept FROM Department


--Read view 	
  SELECT * FROM vw_read
  SELECT * FROM Department


--Perform operation on table 
	delete FROM Department
	
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

	  UPDATE Department SET ename ='UNKNOWN'

--Perform operation on VIEW 
	delete FROM vw_read

	INSERT INTO vw_read  VALUES
	(1, 'David',  'Sales'),
	(5, 'Shane', 'Finance'),
	(6, 'Shed', 'Sales'),
	(7, 'Vik',  'HR'),
	(2, 'Jim', 'HR')

		UPDATE VW_READ SET DEPT ='sql'






--Read view 	
  SELECT * FROM vw_read
  SELECT * FROM Department
--###################################################
--View 1 read from adventureworks VW_UserInfo
	create view  VW_UserInfo
	as
	Select PP.BusinessEntityID as Empid,FirstName,LastName
	,NationalIDNumber,JobTitle,BirthDate,Gender,HireDate,LoginID
	from AdventureWorks2022.Person.Person PP inner join 
	AdventureWorks2022.HumanResources.Employee HE
	on PP.BusinessEntityID=HE.BusinessEntityID

--View 2 read from adventureworks VW_UserInfo

	create view  VW_ADDINFO
	as
	Select BusinessEntityID,AddressLine1,City,PostalCode 	from 
	AdventureWorks2022.Person.Address PA inner join 
	AdventureWorks2022.Person.BusinessEntityAddress PB
	on PA.AddressID=PB.AddressID
	
--View 3  join view 1 & view 2
	create view vw_info
	as
	SELECT  * FROM 
	VW_UserInfo inner join  VW_ADDINFO
	on empid=BusinessEntityID

	select * from vw_info


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

	
	
	
	create view vw_index
	as 
	SELECT SaleDate, count_big(*)  as Counts , Sum (isnull(amount,0)) as Total
	FROM dbo.Sales 	group by SaleDate

---drop table which is related to view 
	drop table Sales

--Could not use view or function 'vw_index' because of binding errors.
	select * from vw_index


		
	create view vw_material with schemabinding
	as 
	SELECT SaleDate, count_big(*)  as Counts , Sum (isnull(amount,0)) as Total
	FROM dbo.Sales 	group by SaleDate

	drop view 	vw_material













































































































































































































































































































































































































































































































































































































































































































