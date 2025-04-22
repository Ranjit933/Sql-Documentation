CREATE DATABASE [Data Analytics]

USE [Data Analytics]

CREATE TABLE Products(
					ProductID INT PRIMARY KEY NOT NULL,
					ProductName VARCHAR(100) NOT NULL,
					Category VARCHAR(100) NOT NULL,
					Price INT
					)

EXEC SP_HELP

EXEC sp_who2

INSERT INTO Products VALUES(1,'Laptop','Electronics',800),
						   (2,'T-shirt','Apparel',20),
						   (3,'Headphones','Electronics',100),
						   (4,'Jeans','Apparel',50)

CREATE TABLE Orders(
				   OrderID INT PRIMARY KEY NOT NULL,
				   CustomerID INT UNIQUE NOT NULL,
				   OrderDate DATE
				   )

INSERT INTO Orders VALUES(1,101,'2021-05-12'),
						 (2,102,'2019-07-16'),
						 (3,103,'2022-11-30')

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50)
);
INSERT INTO Customers (CustomerID, FirstName, LastName, City) VALUES
(1, 'John', 'Doe', 'New York'),
(2, 'Alice', 'Smith', 'Los Angeles'),
(3, 'Michael', 'Brown', 'Chicago'),
(4, 'Emma', 'Wilson', 'Houston'),
(5, 'David', 'Lee', 'San Francisco');


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);


INSERT INTO Employee (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'John', 'Doe', 'IT', 60000.00),
(2, 'Alice', 'Smith', 'HR', 50000.00),
(3, 'John', 'Doe', 'IT', 60000.00),  
(4, 'Michael', 'Brown', 'Finance', 70000.00),
(5, 'Emma', 'Wilson', 'HR', 50000.00), 
(6, 'David', 'Lee', 'IT', 60000.00), 
(7, 'Alice', 'Smith', 'Marketing', 55000.00),
(8, 'John', 'Doe', 'IT', 60000.00);

CREATE TABLE CricketPlayers (
    PlayerID INT,
    PlayerName VARCHAR(100),
    Team VARCHAR(50),
    Role VARCHAR(50),
    Runs INT,
    Wickets INT
);

INSERT INTO CricketPlayers (PlayerID, PlayerName, Team, Role, Runs, Wickets) VALUES
(1, 'Virat Kohli', 'India', 'Batsman', 12000, NULL),
(2, 'MS Dhoni', 'India', 'Wicketkeeper', 10500, 1),
(3, 'Jasprit Bumrah', 'India', 'Bowler', 200, 250),
(4, 'David Warner', 'Australia', 'Batsman', 11000, NULL),
(5, 'Virat Kohli', 'India', 'Batsman', 12000, NULL),
(NULL, 'Ben Stokes', 'England', 'All-Rounder', 5000, 150),
(7, 'Kane Williamson', 'New Zealand', 'Batsman', 9000, NULL),
(8, 'Rashid Khan', 'Afghanistan', 'Bowler', 1000, 300), 
(9, 'Hardik Pandya', 'India', 'All-Rounder', NULL, 90);



SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Customers
SELECT * FROM Employee
SELECT * FROM CricketPlayers


-- Add a column
ALTER TABLE Orders
ADD TotalAmount INT

-- Add values in the column

UPDATE Orders
SET TotalAmount = 150
WHERE OrderID = 1

UPDATE Orders
SET TotalAmount = 200
WHERE OrderID = 2

UPDATE Orders
SET TotalAmount = 100
WHERE OrderID =3

--2. Write a SQL Query to retrieve the product names and their corresponding categories for products with a price greater than $50.

SELECT ProductName,Category,Price
FROM Products
WHERE Price > 50

--3. Write a SQL Query to retrieve the count of orders placed on each date.

SELECT OrderDate,COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY OrderDate

--4. Write a SQL Query to calculate the average total order amount

SELECT AVG(TotalAmount) AS AvgTotalAmount
FROM Orders

--5. Write a SQL Query to retrieve the customer names (concatenated first name and last name) along with their corresponding city.

SELECT CONCAT(FirstName,' ',LastName) AS Full_Name, City
FROM Customers


--6. How do you use the DISTINCT keyword in a SQL Query? Provide an example

SELECT DISTINCT Department 
FROM Employee

--7.How can you update data in a table using SQL? Provide an example

UPDATE Products
SET Price = 1000
WHERE ProductID = 1

--8.What is the purpose of the BETWEEN operator in SQL? Give an example of how it is used.

SELECT FirstName,LastName,Department,Salary
FROM Employee
WHERE Salary BETWEEN 50000 AND 60000

--9.Explain the LIKE operator in SQL, and how is it different from the = operator?

SELECT * FROM Employee
WHERE FirstName LIKE 'David%'

--10.What is a self-join in SQL? Provide an example of how it can be used.

SELECT P.ProductID,P.Category,P.Price,O.CustomerID,O.OrderDate,O.TotalAmount 
FROM Products P 
JOIN Orders O
ON P.ProductID=O.OrderID

--11.Explain the concept of SQL Common Table Expressions (CTEs) and provide an example.

WITH AveragePrice 
AS
(
SELECT AVG(Price) AS AvgPrice
FROM Products
)
SELECT ProductName,Price
FROM Products
WHERE Price > (
			  SELECT AvgPrice
			  FROM AveragePrice
			  )


-- To see how many tables are there

SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;

--OFFSET
SELECT * FROM Employee
ORDER BY Salary DESC
OFFSET 5 ROWS
FETCH NEXT 1 ROWS ONLY

SELECT * FROM CricketPlayers
ORDER BY RUNS 
OFFSET 4 ROWS
FETCH NEXT 2 ROWS ONLY

SELECT STUFF('HELLO WORLD',7,0,'SQL')

SELECT STUFF('RANJIT  SINGH',8,0,'KUMAR') AS MY_NAME

SELECT CHARINDEX(' ','HELLO WORLD')

SELECT CHARINDEX('R','HELLO WORLD')

SELECT SUBSTRING('DEMP TOM JOHN',1,4)

SELECT SUBSTRING('DEMP TOM JOHN',1,8)

SELECT CHARINDEX('@','ABC123@GMAIL.COM')

SELECT GETDATE()

SELECT SYSDATETIME()

SELECT SYSDATETIMEOFFSET()

SELECT YEAR(GETDATE())

SELECT MONTH(GETDATE())

SELECT DAY(GETDATE())

SELECT DATENAME(YEAR,GETDATE())

SELECT DATENAME(MONTH,GETDATE())

SELECT DATENAME(DAY,GETDATE())

SELECT DATENAME(WEEK,GETDATE())

SELECT DATENAME(WEEKDAY,GETDATE())

SELECT DATENAME(DAYOFYEAR,GETDATE())

SELECT DATENAME(QUARTER,GETDATE())

SELECT DATENAME(HOUR,GETDATE())

SELECT DATENAME(MINUTE,GETDATE())

SELECT DATENAME(SECOND,GETDATE())

SELECT DATENAME(MILLISECOND,GETDATE())

SELECT DATENAME(NANOSECOND,GETDATE())

SELECT DATEPART(YEAR,GETDATE())

SELECT CAST(GETDATE() AS VARCHAR)

SELECT CONVERT(VARCHAR,GETDATE(),1)

SELECT CONVERT(VARCHAR,GETDATE(),4)


SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Customers
SELECT * FROM Employee
SELECT * FROM CricketPlayers

SELECT PlayerName,Runs,
RANK() OVER(ORDER BY Runs DESC) AS Rnk,
DENSE_RANK() OVER(ORDER BY Runs DESC) AS Dns_Rnk,
ROW_NUMBER() OVER(ORDER BY Runs DESC) AS Row_num
FROM CricketPlayers

SELECT FirstName,Department,Salary,
RANK() OVER(ORDER BY Salary DESC) AS Rnk,
DENSE_RANK() OVER(ORDER BY Salary DESC) AS Dns_Rnk,
ROW_NUMBER() OVER(ORDER BY Salary DESC) AS Row_Num
FROM Employee

SELECT PlayerName,Runs,
NTILE(4) OVER(ORDER BY Runs DESC) AS TILES
FROM CricketPlayers

SELECT FirstName,Department,Salary,
NTILE(3) OVER(ORDER BY Salary DESC) AS TILES
FROM Employee

SELECT FirstName,Department,Salary,
LAG(Salary) OVER(ORDER BY Salary DESC) AS DIFF
FROM Employee

SELECT FirstName,Department,Salary,
LEAD(Salary) OVER(ORDER BY Salary DESC) AS DIFF
FROM Employee

SELECT 'COL1.COL2.COL3.COL4',
PARSENAME('COL1.COL2.COL3.COL4',4),
PARSENAME('COL1.COL2.COL3.COL4',3),
PARSENAME('COL1.COL2.COL3.COL4',2)

SELECT 'COL1-COL2-COL3-COL4',
PARSENAME(REPLACE('COL1.COL2.COL3.COL4','-','.'),4),
PARSENAME(REPLACE('COL1.COL2.COL3.COL4','-','.'),3),
PARSENAME(REPLACE('COL1.COL2.COL3.COL4','-','.'),2)

SELECT PlayerName,Runs,
ROW_NUMBER() OVER(ORDER BY Runs DESC) AS Rownum
FROM CricketPlayers

WITH Cricket
AS
(
	SELECT PlayerName,Runs,
	RANK() OVER(ORDER BY Runs DESC) AS Rnk
	FROM CricketPlayers	
)

SELECT * FROM Cricket
WHERE Runs BETWEEN 10000 AND 12000

WITH Employee_sal
AS
(
	SELECT FirstName,Department,Salary,
	DENSE_RANK() OVER(ORDER BY Salary DESC) AS DnsRnk
	FROM Employee
	
)
SELECT * FROM Employee_sal

WITH ProductList
AS
(
	SELECT ProductName,Price,
	NTILE(3) OVER(ORDER BY Price DESC) AS TILE
	FROM Products
)
SELECT * FROM ProductList


-- CREATE FUNCTION ON CricketPlayers

CREATE FUNCTION GetPlayerByName
(
    @PlayerName VARCHAR(100)
)
RETURNS TABLE
AS
RETURN 
(
    WITH RankedPlayers AS
    (
        SELECT *,
               ROW_NUMBER() OVER (ORDER BY Runs DESC) AS ROWNUM
        FROM CricketPlayers
    )
    SELECT *
    FROM RankedPlayers
    WHERE PlayerName = @PlayerName
)

-- CALL THE FUNCTION

SELECT * FROM GetPlayerByName('Virat Kohli')

-- FUNCTION 2

CREATE FUNCTION Employee_Salary(@Salary INT)
RETURNS TABLE
AS
RETURN
	 (
	    WITH EmpSal
	    AS
	    ( 
	      SELECT *, RANK() OVER(ORDER BY Salary DESC )AS Rnk
	      FROM Employee
		  )
	         SELECT * FROM EmpSal 
	         WHERE Salary = @Salary
	    )

-- CALL THE FUNCTION

SELECT * FROM Employee_Salary(50000)



-- 3rd FUNCTION

CREATE FUNCTION CustomerMP
(
 @City VARCHAR(100)
 )
 RETURNS TABLE
 AS
 RETURN
		(
		  WITH CUST
		  AS
		  ( SELECT *, DENSE_RANK() OVER(ORDER BY FirstName DESC) AS Dns_Rnk,
		  RANK() OVER(ORDER BY City DESC) AS Rnk,
		  ROW_NUMBER() OVER(ORDER BY CustomerID DESC) AS Rownum
		  FROM Customers
		  )
		  SELECT * FROM CUST
		  WHERE city = @City
		  )

-- CALL THE FUNCTION

SELECT * FROM CustomerMP ('New York')

SELECT * FROM CustomerMP('Los Angeles')
WHERE CustomerID = 2

-- CREATE VIEW ON CRICKET

CREATE VIEW VW_Cricket
AS
SELECT PlayerName,Role,Runs,Wickets
FROM CricketPlayers

-- CALL THE VIEW

SELECT * FROM VW_Cricket

-- CREATE VIEW ON PRODUCT

CREATE VIEW KR_Product
AS
SELECT ProductName,Price
FROM Products

-- CALL THE PRODUCT VIEW

SELECT * FROM KR_Product

-- CREATE VIEW ON EMPLOYEE

CREATE VIEW Em_Employee
AS
SELECT FirstName,Department,Salary
FROM Employee

-- CALL THE EMPLOYEE VIEW

SELECT * FROM Em_Employee


-- CLUSTERED INDEX AND NON - CLUSTERED INDEX

-- CLUSTERED INDEX

CREATE CLUSTERED INDEX CI_CRICKET ON CricketPlayers (PlayerName,Role)

-- CALL THE CLUSTERED INDEX

SELECT * FROM CricketPlayers
WHERE PlayerName = 'Virat Kohli' AND Role = 'Batsman'

SELECT * FROM CricketPlayers
WHERE PlayerName LIKE 'R%'

--  NON - CLUSTERED INDEX

CREATE NONCLUSTERED INDEX NCI_EMPLOYEE ON Employee(FirstName,Department,Salary)

-- CALL  NON - CLUSTERED INDEX

SELECT FirstName,Department,Salary
FROM Employee
WHERE FirstName = 'Michael' AND Department = 'Finance' AND Salary = 70000.00


SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Customers
SELECT * FROM Employee
SELECT * FROM CricketPlayers

-- STORE PROCDURE

CREATE PROCEDURE World_Cricket
AS
BEGIN
      WITH CountRuns
	  AS
	  (
		SELECT PlayerName,Role,Runs,
		CASE 
			WHEN Runs > 13000 THEN 'Performance Player'
			WHEN Runs BETWEEN 8000 AND 11000 THEN 'Excellent Player'
			WHEN Runs BETWEEN 6000 AND 10500 THEN 'Good Player'
			WHEN Runs < 5000 THEN 'Weak Player'
		END AS CountRuns
		FROM CricketPlayers
		)
	SELECT Runs,COUNT(*) AS Runs_counts FROM CountRuns GROUP BY Runs
END

-- CALL PROCEDURE

EXEC CountRuns


-- SEE BY NAMES


CREATE PROCEDURE Performance_Player
AS
BEGIN
      WITH CountRuns
	  AS
	  (
		SELECT PlayerName,Role,Runs,Team,
		CASE 
			WHEN Runs > 13000 THEN 'Performance Player'
			WHEN Runs BETWEEN 8000 AND 11000 THEN 'Excellent Player'
			WHEN Runs BETWEEN 6000 AND 10500 THEN 'Good Player'
			WHEN Runs < 5000 THEN 'Weak Player'
		END AS CountRuns
		FROM CricketPlayers
		)
	SELECT PlayerName,Team,Runs,COUNT(*) AS Runs_counts FROM CountRuns GROUP BY PlayerName,Team,Runs
END

-- CALL PROCEDURE

EXEC Performance_Player


--Definition of Procedure
sp_helptext 'Performance_Player';


-- Alter Store Procedure

ALTER PROCEDURE World_Cricket
AS
BEGIN
    WITH CountRuns AS
    (
        SELECT 
            PlayerName,
            Role,
            Runs,
            CASE 
                WHEN Runs > 13000 THEN 'Performance Player'
                WHEN Runs BETWEEN 8000 AND 11000 THEN 'Excellent Player'
                WHEN Runs BETWEEN 6000 AND 10500 THEN 'Good Player'
                WHEN Runs < 5000 THEN 'Weak Player'
                ELSE 'Average Player'  -- Optional fallback in case runs don’t match
            END AS CountRuns
        FROM CricketPlayers
        WHERE Runs IS NOT NULL
    )
    SELECT 
        CountRuns AS PerformanceCategory,
        COUNT(*) AS PlayerCount
    FROM CountRuns
    GROUP BY CountRuns
    ORDER BY PlayerCount DESC;
END;


EXEC World_Cricket