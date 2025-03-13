--Windows  function,CTE,USER DEFINED (Table valued & Scalar valued function  ) VIEW
--############################################################

	https://learn.microsoft.com/en-us/sql/t-sql/statements/create-function-transact-sql?view=sql-server-ver16
	https://learn.microsoft.com/en-us/sql/relational-databases/views/views?view=sql-server-ver16
--#######################################################

Create database  DEMO

use DEMO


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

--Windows  function(ranking function ) 
--ranking_function() over(partition by  columnname  order by columnname asc/desc)
--partition by = group by 

--RANK()over(partition by  columnname  order by columnname asc/desc)
--deSNE_RANK()over(partition by  columnname  order by columnname asc/desc)
--ROW_NUMBER()over(partition by  columnname  order by columnname asc/desc)

	SELECT DID,salary,
	RANK() OVER(ORDER BY SALARY DESC) AS RANKS,
	DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSERANKS,
	ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROWNUMBER
	FROM Department

	
	SELECT DID,salary, 
	ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROWNUM 
	FROM Department

--NTILE (N)
	SELECT DID,salary ,
	NTILE (4) OVER(ORDER BY SALARY DESC) AS TILES 
	FROM Department


--LAG(column_name, offset, default_value) OVER (PARTITION BY column_name ORDER BY column_name)
--LAG --Previous row 
	SELECT DID,salary 
	,LAG (SALARY) OVER(ORDER BY SALARY ASC) AS LAGS 
	FROM Department
	
	SELECT DID,salary 
	,SALARY-LAG (SALARY) OVER(ORDER BY SALARY ASC) AS DIFF 
	FROM Department

	
	SELECT DID,salary ,LAG (SALARY) OVER(ORDER BY SALARY ASC) AS LAGS 
	,SALARY-LAG (SALARY) OVER(ORDER BY SALARY ASC) AS DIFF 
	FROM Department

	 
	SELECT DID,salary 
	,salary-LAG (SALARY,1,500) OVER(ORDER BY SALARY ASC) AS LAGS 
	FROM Department
 --LEAD(column_name, offset, default_value) OVER (PARTITION BY column_name ORDER BY column_name)
 --Lead() -- next row
 	SELECT DID,salary 
	,LAG (SALARY,1,500) OVER(ORDER BY SALARY ASC) AS LAGS
	,salary 
	,LEAD (SALARY,1,500) OVER(ORDER BY SALARY ASC) AS LEADS 
	FROM Department


	   	  	
	SELECT DID,salary 
	, LAG (SALARY,3,500) OVER(ORDER BY SALARY ASC) AS LAGS 
	, ISNULL(CAST(LEAD (SALARY,3 ) OVER(ORDER BY SALARY ASC) AS VARCHAR),'ALPHA') AS LEADS 
	FROM Department



	SELECT ISNULL(NULL,0)
	SELECT ISNULL('ALPHA',0)

	
	SELECT 'COL1.COL2.COL3.COL4', 
	PARSENAME('COL1.COL2.COL3.COL4',4),
	PARSENAME('COL1.COL2.COL3.COL4',3),
	PARSENAME('COL1.COL2.COL3.COL4',2),
	PARSENAME('COL1.COL2.COL3.COL4',1)


	SELECT 'COL1-COL2-COL3-COL4',
	PARSENAME(REPLACE('COL1-COL2-COL3-COL4','-','.'),4),
	PARSENAME(REPLACE('COL1-COL2-COL3-COL4','-','.'),3),
	PARSENAME(REPLACE('COL1-COL2-COL3-COL4','-','.'),2),
	PARSENAME(REPLACE('COL1-COL2-COL3-COL4','-','.'),1)


---###########################################################
 --CTE(Common table experssion)
 /* --Temporary result set in SQL Server( SELECT, INSERT, UPDATE, or DELETE)*/

 
	SELECT DID,salary, 
	ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROWNUM 
	FROM Department


	WITH CTE_Name (Column1, Column2, ...)
	AS
	(
		-- CTE query
		SELECT Column1, Column2, ...
		FROM TableName
		WHERE Condition
	)
	-- Main query referencing the CTE
	SELECT *	FROM CTE_Name;


--fIND HIGH SAL BASED ON NTHRANK
	WITH HIGHSAL
	AS 
	( 	SELECT DID,salary, 	ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROWNUM 
	FROM Department
	)
	SELECT * FROM HIGHSAL WHERE ROWNUM=4


--FIND HIGH  SAL  DEPT 
	WITH DEPTSAL 
	AS
	(
		SELECT *, 	ROW_NUMBER() OVER(PARTITION BY DEPT ORDER BY SALARY DESC) AS ROWNUM 
		FROM Department
	)

	SELECT 	did,ename,gender,salary,dept FROM DEPTSAL WHERE ROWNUM=1
--#########################################################
--Find duplicate values 
	SELECT did,count(*)
	FROM Department group by did 
	having count(*)>1
	order by count(*)
--UNIQUE RECORDS
	WITH DUPREC
	AS
	(	SELECT *, 	ROW_NUMBER() OVER(PARTITION BY DID ORDER BY DID ASC) AS ROWNUM 
	FROM Department
	)
	SELECT * FROM DUPREC WHERE ROWNUM=1
--DUPLICATE RECORDS
	WITH DUPREC
	AS
	(	SELECT *, 	ROW_NUMBER() OVER(PARTITION BY DID ORDER BY DID ASC) AS ROWNUM 
	FROM Department
	)
	SELECT * FROM DUPREC WHERE ROWNUM>1

--DELETE RECORDS
	WITH DUPREC
	AS
	(	SELECT *, 	ROW_NUMBER() OVER(PARTITION BY DID ORDER BY DID ASC) AS ROWNUM 
	FROM Department
	)
	DELETE FROM DUPREC WHERE ROWNUM>1


	SELECT *	FROM Department  ORDER BY DID ASC 

--FIND HIGH AND LOWSAL
	WITH LOWSAL 
	AS 
	(	SELECT  TOP 1 *	FROM Department  ORDER BY salary ASC )
	SELECT * FROM LOWSAL 
	

	WITH HIGHSAL 
	AS 
	(	SELECT  TOP 1 *   FROM Department  ORDER BY salary DESC )
	SELECT * FROM HIGHSAL 

--FIND HIGH AND LOWSAL
WITH 
LOWSAL 
	AS 
	(	SELECT  TOP 1 *	FROM Department  ORDER BY salary ASC )
,HIGHSAL 
	AS 
	(	SELECT  TOP 1 *   FROM Department  ORDER BY salary DESC )
	
	SELECT * FROM LOWSAL 
	UNION ALL
	SELECT * FROM HIGHSAL 
--##################################################
--CUBE OF A NUMBER 
--NUM 2 
--CUBE =2*2*2=8

--User defined function
--Scalar valued function 
	/*syntax
		CREATE FUNCTION function_name (@parameter1 datatype [, @parameter2 datatype, ...])
		RETURNS DATATYPE
		AS
		BEGIN 
					RETURN(OUTPUT)
		END
	*/

DECLARE @NUM INT 
SET @NUM=2
SET @NUM =@NUM*@NUM*@NUM
SELECT  @NUM
--cREATE FUNCTION 
	CREATE FUNCTION CUBES()
	RETURNS INt
	AS 
	BEGIN
		DECLARE @NUM INT 
		SET @NUM=2
		SET @NUM =@NUM*@NUM*@NUM
		return   @NUM
	END 


--Call FUNCTION 
	select  dbo.cubes()

--Alter function
	Alter FUNCTION CUBES(@NUM INT)
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

	select did as num, dbo.cubes(did)  as Cubes from Department order by did

--##################################################
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

--Discount price 
--DP=price-(price*dis/100)
	select 100-(100*15/100)

	
	select * from products
--create function
	create function DP(@price float,@dis float)
	returns float
	as
	begin 
		return @price-(@price*@dis/100)
	end 


	select *, dbo.dp(price, 15.10) as newprice from products



--########################################################
 

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


--good recieve value 

grv=QuantityReceived*UnitPrice 
--create function
	create function  grv(@id int)
	returns float
	as 
	begin
	declare @grv float
	SELECT @grv=QuantityReceived* UnitPrice FROM GoodReceiveNotes where grnid=@id 
	return @grv

	end 
--call function
	SELECT GRNID, QuantityReceived,UnitPrice,dbo.grv(GRNID) FROM GoodReceiveNotes

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
--discounts based on the total amount they have spent historically. 
--The discount is calculated using a tiered system:
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





















































































































































































