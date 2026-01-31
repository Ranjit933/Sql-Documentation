--Intellipaat

SELECT * FROM Employee_bonus

SELECT * FROM Employee_clone

SELECT * FROM Employee_table

SELECT * FROM Employee_Title

WITH NTH_SAL
AS
(
SELECT * FROM(
			SELECT Salary,RANK() OVER(ORDER BY Salary DESC) AS RNK
			FROM Employee_clone
			)T
)

SELECT * FROM NTH_SAL
WHERE RNK = 4

--Scaler-valued Function

CREATE FUNCTION Employee_Increment(@Increment INT)
RETURNS INT
AS
  BEGIN
		RETURN @Increment * 0.25
END

SELECT Salary,dbo.Employee_Increment(Salary) AS Employee_increment
FROM Employee_clone

CREATE FUNCTION Bonus_Increased(@IncreasedBonus INT)
RETURNS INT
AS 
	BEGIN
		 RETURN @IncreasedBonus * 0.35
END

SELECT *,dbo.Bonus_Increased(Salary) AS Increased_bonus FROM Employee_table

SELECT YEAR(Affective_Date) AS joining_YEARS, MONTH(Affective_Date) Joining_Month,COUNT(*) AS Num_employee
FROM Employee_Title
GROUP BY YEAR(Affective_Date), MONTH(Affective_Date)

--Table-Valued Function

CREATE FUNCTION Salary_Distribution(@Salary INT,@Department VARCHAR(20))
RETURNS TABLE
AS RETURN
(
 SELECT @Salary AS Salary,
			 CASE 
			    WHEN @Salary BETWEEN 70000 AND 90000 THEN @Salary * 1.12
				WHEN @Salary BETWEEN 10000 AND 300000 THEN @Salary * 0.25
			ELSE @Salary * 0.45
		END AS EmployeeSalary 
	FROM Employee_clone
	)

SELECT TOP 1 * FROM dbo.Salary_Distribution(300000,'HR') AS Distributions
SELECT TOP 1 * FROM dbo.Salary_Distribution(500000,'Admin') AS Distributions
SELECT TOP 1 * FROM dbo.Salary_Distribution(75000,'Account') AS Distributions

--AdventureWorksLT2019
SELECT * FROM SalesLT.Product

SELECT * FROM SalesLT.ProductCategory


CREATE FUNCTION PriceIncreaseRule(@ListPrice DECIMAL(10,2))
RETURNS TABLE
AS RETURN
(
 SELECT @ListPrice AS OriginalPrice,
  CASE 
     WHEN @ListPrice < 100 THEN @ListPrice * 1.12
	 WHEN @ListPrice BETWEEN 100 AND 800 THEN @ListPrice * 0.25
	 WHEN @ListPrice BETWEEN 800 AND 1500 THEN @ListPrice * 0.35
	 WHEN @ListPrice BETWEEN 1500 AND 3500 THEN @ListPrice * 0.45
	ELSE @ListPrice * 0.50
END 
  AS UpdatedPrice
)

SELECT SL.Name,SL.ProductNumber,SL.Color,SL.StandardCost,SL.ListPrice,PC.Name AS CategoryName,PC.ModifiedDate, Updated_price.OriginalPrice,
Updated_price.UpdatedPrice
FROM SalesLT.Product SL
LEFT JOIN SalesLT.ProductCategory PC ON SL.ProductCategoryID = PC.ProductCategoryID
CROSS APPLY dbo.PriceIncreaseRule(SL.ListPrice) AS Updated_price

--Practice
SELECT * FROM Customers

SELECT * FROM Employees

SELECT * FROM HelloWorld

SELECT * FROM [ICC Mens T20 Worldcup]

SELECT * FROM IndianWeatherRepository

SELECT * FROM Orders

SELECT * FROM Products

--Electronic * price*15%,Accessories*20%,Wearables*8%,,Storage*16%,Home,else*25%

CREATE FUNCTION ProductsIncreased(@Category VARCHAR(20))
RETURNS TABLE
AS RETURN
(
SELECT Product_name,Category,Price,Stock_quantity,
CASE
   WHEN Category = 'Electronics' THEN Price * 0.15
   WHEN Category = 'Accessories' THEN Price * 0.20
   WHEN Category = 'Wearables' THEN Price * 0.08
   WHEN Category = 'Storage' THEN Price * 0.16
ELSE Price * 0.25
END
   AS Incresed_Price
FROM Products
WHERE Category = @Category 
)

SELECT * FROM dbo.ProductsIncreased('Electronics')

SELECT O.order_id,O.order_date,O.total_price,P.product_name,P.category,P.price
FROM Orders O
INNER JOIN Products P ON O.product_id = P.product_id

CREATE VIEW VW_Orders_products
AS
SELECT O.order_id,O.order_date,O.total_price,P.product_name,P.category,P.price
FROM Orders O
INNER JOIN Products P ON O.product_id = P.product_id

SELECT * FROM VW_Orders_products

--Ecommerce
--cluster_index and non-clister index
SELECT * FROM Customers
SELECT * FROM OrderDetails
SELECT * FROM Orders
SELECT * FROM Products

CREATE NONCLUSTERED INDEX Products_Details ON Products (ProductName,Price)

SELECT * FROM Products

---STORE PROCEDURES

----Data Analytics

SELECT * FROM Employee

CREATE PROCEDURE SP_Grades
AS 
 BEGIN
		WITH Count_Grades 
		AS(
		SELECT Department,Gender,
							   CASE
								WHEN Salary BETWEEN 65000 AND 100000 THEN 'Grade 1'
								WHEN Salary BETWEEN 50000 AND 60000 THEN 'Grade 2'
								WHEN Salary < 40000 THEN 'Grade 3'
							END AS Grades
						FROM Employee
						)
SELECT Grades,COUNT(*) AS Grades_counts
FROM Count_Grades
GROUP BY Grades

END

EXEC SP_Grades 


sp_helptext 'SP_Grades';

SELECT * FROM Orders

SELECT * FROM Employee

SELECT * FROM Products

SELECT * FROM Customers

SELECT * FROM Sales

CREATE PROCEDURE EMP_JOINS
AS
BEGIN

WITH JOINS_TABLE
AS
(
SELECT E.Department,E.Gender,E.Salary,C.FirstName,C.City,S.Amount
FROM Employee E
LEFT JOIN Orders O ON E.EmployeeID = O.CustomerID
LEFT JOIN Products P ON O.OrderID = P.ProductID
LEFT JOIN Customers C ON E.EmployeeID = C.CustomerID
LEFT JOIN Sales S ON  E.EmployeeID = S.SaleID
)

SELECT * FROM JOINS_TABLE

END

EXEC EMP_JOINS

SP_HELPTEXT 'EMP_JOINS'


ALTER PROCEDURE EMP_JOINS 
AS
BEGIN

WITH JOINS_TABLE
AS
(
SELECT E.Department,E.Gender,E.Salary,C.FirstName,C.City,S.Amount
FROM Employee E
LEFT JOIN Orders O ON E.EmployeeID = O.CustomerID
LEFT JOIN Products P ON O.OrderID = P.ProductID
LEFT JOIN Customers C ON E.EmployeeID = C.CustomerID
LEFT JOIN Sales S ON  E.EmployeeID = S.SaleID
)

SELECT * FROM JOINS_TABLE

END

EXEC EMP_JOINS 

---Create Store procedure and insert the values for two parameters 
--Practice

SELECT * FROM Employees

CREATE TABLE Employees_table(
                            Emp_ID INT PRIMARY KEY,
							Employee_Name VARCHAR(30),
							Salary INT
							)


CREATE PROCEDURE InsertEmployee 
 @Emp_ID INT,
 @Employee_Name VARCHAR(30),
 @Salary INT
AS
  BEGIN
      INSERT INTO Employees_table(Emp_ID,Employee_Name,Salary)
	  VALUES(@Emp_ID,@Employee_Name,@Salary)
END

EXEC InsertEmployee 101,'Anuj',50000

SELECT * FROM Employees_table

--Create Procedure for Select,Insert,Update and Delete

CREATE TABLE UserData(
					 ID INT,
					 ENAME VARCHAR(20),
					 Age INT
					 )

CREATE PROCEDURE Autopct
    @Action VARCHAR(20),@ID INT = NULL,@ENAME VARCHAR(20) = NULL, @AGE INT = NULL
AS
  BEGIN
       IF @Action = 'INSERT'
	     BEGIN
             INSERT INTO UserData VALUES(@ID,@ENAME,@AGE)
END
   ELSE 
		IF @Action = 'UPDATE'
	BEGIN
	    UPDATE UserData 
		SET ENAME = @ENAME, AGE = @AGE
		WHERE ID = @ID
END
	ELSE
	   IF @Action = 'DELETE'
	 BEGIN 
	       DELETE FROM UserData
		   WHERE ID = @ID
END
  ELSE 
	  IF @Action = 'SELECT'
  BEGIN 
       SELECT * FROM UserData
END 
  BEGIN
      PRINT 'INVALID ACTION'
   END
END
  
--CALL PROCEDURE
SELECT * FROM USERDATA

--INSERT
EXEC Autopct @Action  = 'INSERT',@ID = 101,@ENAME= 'MOHAN',@AGE = 23

EXEC Autopct 'INSERT',102,'RAMESH',22

--UPDATE
EXEC Autopct 'UPDATE',102,SOHAN,25

--DELETE
EXEC Autopct 'DELETE', 102
      
--SELECT

EXEC Autopct 'SELECT'

--STRUCTURE OF STORE PROCEDURE
SP_HELPTEXT Autopct

SELECT * FROM [ICC Mens T20 Worldcup]

SELECT COUNT(Match_No)
FROM [ICC Mens T20 Worldcup]

BEGIN TRAN

SELECT Match_No,Venue,First_Innings_Score,Highest_Score,Won_by,Top_Scorer,
      CASE 
		   WHEN First_Innings_Score > 194 AND Highest_Score > 94 THEN 'Won by Runs'
		   WHEN	  First_Innings_Score > 190 AND Highest_Score > 80 THEN 'Won by Wickets'
		   WHEN  First_Innings_Score >155 AND Highest_Score > 65 THEN 'Won by Wickets'
		   WHEN  First_Innings_Score > 135  AND Highest_Score > 47 THEN 'Won by Runs'
		  ELSE  'LOSS MATCH'
		END AS Match_Result,
		COUNT(*) OVER(PARTITION BY 
							  CASE
								WHEN First_Innings_Score > 194 AND Highest_Score > 94 THEN 'Won by Runs'
								WHEN First_Innings_Score > 190 AND Highest_Score > 80 THEN 'Won by Wickets'
								WHEN First_Innings_Score >155 AND Highest_Score > 65 THEN 'Won by Wickets'
								WHEN First_Innings_Score > 135  AND Highest_Score > 47 THEN 'Won by Runs'
							ELSE  'LOSS MATCH'
						 END
						) Match_Result_Count
					FROM [ICC Mens T20 Worldcup]
COMMIT
ROLLBACK

--Triggers DDL, DML

SELECT * FROM Employee_Bonus

SELECT * FROM Employee_clone

SELECT * FROM Employee_Title

SELECT * FROM Employee_table

/*
CREATE TABLE Employee_Audit(
						   Audit_ID INT IDENTITY(1,1) PRIMARY KEY,
						   Employee_ID INT,
						   ActionType VARCHAR(20),
						   Old_Salary INT,
						   New_Salary INT,
						   ACTION DATETIME DEFAULT GETDATE())

SP_HELP 'Employee_Audit'

--Intellipaat
--Create a trigger that logs whenever a new employee is inserted.

CREATE TRIGGER Trg_AfterInsertEmployee
ON Employee_clone
AFTER INSERT
AS
BEGIN
	INSERT INTO Employee_Audit(Employee_ID, ActionType)
	SELECT Employee_ID, 'INSERT'
  FROM INSERTED
END

INSERT INTO Employee_clone VALUES (9, 'Rahul','Tiwari',50000,'2020-10-15','IT')

SELECT * FROM Employee_clone

SELECT * FROM Employee_Audit

SELECT *
FROM Employee_Audit
WHERE ObjectName = 'Trg_AfterInsertEmployee';


SELECT *
FROM sys.fn_trace_gettable(
    (SELECT path FROM sys.traces WHERE is_default = 1),
    DEFAULT
)
WHERE ObjectName = 'Trg_AfterInsertEmployee';

*/


WITH DELETE_RECORD 
AS(
SELECT Salary,Department,RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS RWN
FROM Employee_clone
)

DELETE FROM DELETE_RECORD
WHERE DEPARTMENT = 'IT'


--- Flipkart & Zomato Interview Question

SELECT * FROM Customer_Orders

SELECT * FROM Customer_Orders1

SELECT * FROM Orders

SELECT * FROM Orders_table


CREATE FUNCTION  Interset_charged(@Amount_Increased DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS BEGIN 
	RETURN @Amount_Increased * 0.12

END


SELECT Order_ID,Category,Amount, dbo.Interset_charged(Amount) AS New_Amount
FROM Orders_table

CREATE  FUNCTION Interset_chargedOn_Amt(@Amount INT, @Category VARCHAR(20))
RETURNS TABLE
AS RETURN
(
	SELECT @Amount AS Amount,
					CASE 
						WHEN @Category = 'Electronics' THEN @Amount * 0.08
					    WHEN @Category = 'Fashion' THEN  @Amount * 0.12
				ELSE @Amount * 0.15
			END AS Amount_Increaseed		
)


SELECT * FROM Orders_table 

SELECT * FROM dbo.Interset_chargedOn_Amt(1200,'Electronics') 

SELECT * FROM dbo.Interset_chargedOn_Amt(1200,'Fashion') 











