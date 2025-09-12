## **SQL INTERVIEW QUSTIONS**

```sql
CREATE DATABASE [Data Analytics]
```
```sql
USE [Data Analytics]
```
```sql
CREATE TABLE Products(
					ProductID INT PRIMARY KEY NOT NULL,
					ProductName VARCHAR(100) NOT NULL,
					Category VARCHAR(100) NOT NULL,
					Price INT
					)
```
```sql
EXEC SP_HELP

EXEC sp_who2
```
```sql
INSERT INTO Products VALUES(1,'Laptop','Electronics',800),
						   (2,'T-shirt','Apparel',20),
						   (3,'Headphones','Electronics',100),
						   (4,'Jeans','Apparel',50)
```
```sql
CREATE TABLE Orders(
				   OrderID INT PRIMARY KEY NOT NULL,
				   CustomerID INT UNIQUE NOT NULL,
				   OrderDate DATE
				   )
```
```sql
INSERT INTO Orders VALUES  (1,101,'2021-05-12'),
						   (2,102,'2019-07-16'),
						   (3,103,'2022-11-30')
```
```sql						 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50)
);
```
```sql
INSERT INTO Customers (CustomerID, FirstName, LastName, City) VALUES
(1, 'John', 'Doe', 'New York'),
(2, 'Alice', 'Smith', 'Los Angeles'),
(3, 'Michael', 'Brown', 'Chicago'),
(4, 'Emma', 'Wilson', 'Houston'),
(5, 'David', 'Lee', 'San Francisco')
```
```sql
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
)

```
```sql
INSERT INTO Employee (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'John', 'Doe', 'IT', 60000.00),
(2, 'Alice', 'Smith', 'HR', 50000.00),
(3, 'John', 'Doe', 'IT', 60000.00),  
(4, 'Michael', 'Brown', 'Finance', 70000.00),
(5, 'Emma', 'Wilson', 'HR', 50000.00), 
(6, 'David', 'Lee', 'IT', 60000.00), 
(7, 'Alice', 'Smith', 'Marketing', 55000.00),
(8, 'John', 'Doe', 'IT', 60000.00)
```
```sql
CREATE TABLE CricketPlayers (
    PlayerID INT,
    PlayerName VARCHAR(100),
    Team VARCHAR(50),
    Role VARCHAR(50),
    Runs INT,
    Wickets INT
)
```
```sql
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
```
```sql
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Customers
SELECT * FROM Employee
SELECT * FROM CricketPlayers
```

## Add a column
```sql
ALTER TABLE Orders
ADD TotalAmount INT
```
## Add values in the column
```sql
UPDATE Orders
SET TotalAmount = 150
WHERE OrderID = 1
```
```sql
UPDATE Orders
SET TotalAmount = 200
WHERE OrderID = 2
```
```sql
UPDATE Orders
SET TotalAmount = 100
WHERE OrderID =3
```
## To see how many tables are there(MetaData Query)
```sql
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%TABLE_NAME%'
```
## Table Defination
```sql
--Table Defination
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'TABLE_NAME';
```
## OFFSET
```sql
SELECT * FROM Employee
ORDER BY Salary DESC
OFFSET 5 ROWS
FETCH NEXT 1 ROWS ONLY
```
```sql
SELECT * FROM CricketPlayers
ORDER BY RUNS 
OFFSET 4 ROWS
FETCH NEXT 2 ROWS ONLY
```
```sql
SELECT STUFF('HELLO WORLD',7,0,'SQL')
```
```sql
SELECT STUFF('RANJIT  SINGH',8,0,'KUMAR') AS MY_NAME
```
```sql
SELECT CHARINDEX(' ','HELLO WORLD')
```
```sql
SELECT CHARINDEX('R','HELLO WORLD')
```
```sql
SELECT SUBSTRING('DEMP TOM JOHN',1,4)
```
```sql
SELECT SUBSTRING('DEMP TOM JOHN',1,8)
```
```sql
SELECT CHARINDEX('@','ABC123@GMAIL.COM')
```
```sql
SELECT GETDATE()
```
```sql
SELECT SYSDATETIME()
```
```sql
SELECT SYSDATETIMEOFFSET()
```
```sql
SELECT YEAR(GETDATE())
```
```sql
SELECT MONTH(GETDATE())
```
```sql
SELECT DAY(GETDATE())
```
```sql
SELECT DATENAME(YEAR,GETDATE())
```
```sql
SELECT DATENAME(MONTH,GETDATE())
```
```sql
SELECT DATENAME(DAY,GETDATE())
```
```sql
SELECT DATENAME(WEEK,GETDATE())
```
```sql
SELECT DATENAME(WEEKDAY,GETDATE())
```
```sql
SELECT DATENAME(DAYOFYEAR,GETDATE())
```
```sql
SELECT DATENAME(QUARTER,GETDATE())
```
```sql
SELECT DATENAME(HOUR,GETDATE())
```
```sql
SELECT DATENAME(MINUTE,GETDATE())
```
```sql
SELECT DATENAME(SECOND,GETDATE())
```
```sql
SELECT DATENAME(MILLISECOND,GETDATE())
```
```sql
SELECT DATENAME(NANOSECOND,GETDATE())
```
```sql
SELECT DATEPART(YEAR,GETDATE())
```
```sql
SELECT CAST(GETDATE() AS VARCHAR)
```
```sql
SELECT CONVERT(VARCHAR,GETDATE(),1)
```
```sql
SELECT CONVERT(VARCHAR,GETDATE(),4)
```
```sql
SELECT PlayerName,Runs,
RANK() OVER(ORDER BY Runs DESC) AS Rnk,
DENSE_RANK() OVER(ORDER BY Runs DESC) AS Dns_Rnk,
ROW_NUMBER() OVER(ORDER BY Runs DESC) AS Row_num
FROM CricketPlayers
```
```sql
SELECT FirstName,Department,Salary,
RANK() OVER(ORDER BY Salary DESC) AS Rnk,
DENSE_RANK() OVER(ORDER BY Salary DESC) AS Dns_Rnk,
ROW_NUMBER() OVER(ORDER BY Salary DESC) AS Row_Num
FROM Employee
```
```sql
SELECT PlayerName,Runs,
NTILE(4) OVER(ORDER BY Runs DESC) AS TILES
FROM CricketPlayers
```
```sql
SELECT FirstName,Department,Salary,
NTILE(3) OVER(ORDER BY Salary DESC) AS TILES
FROM Employee
```
```sql
SELECT FirstName,Department,Salary,
LAG(Salary) OVER(ORDER BY Salary DESC) AS DIFF
FROM Employee
```
```sql
SELECT FirstName,Department,Salary,
LEAD(Salary) OVER(ORDER BY Salary DESC) AS DIFF
FROM Employee
```
```sql
SELECT 'COL1.COL2.COL3.COL4',
PARSENAME('COL1.COL2.COL3.COL4',4),
PARSENAME('COL1.COL2.COL3.COL4',3),
PARSENAME('COL1.COL2.COL3.COL4',2)
```
```sql
SELECT 'COL1-COL2-COL3-COL4',
PARSENAME(REPLACE('COL1.COL2.COL3.COL4','-','.'),4),
PARSENAME(REPLACE('COL1.COL2.COL3.COL4','-','.'),3),
PARSENAME(REPLACE('COL1.COL2.COL3.COL4','-','.'),2)
```
```sql
SELECT PlayerName,Runs,
ROW_NUMBER() OVER(ORDER BY Runs DESC) AS Rownum
FROM CricketPlayers
```
```sql
WITH Cricket
AS
(
	SELECT PlayerName,Runs,
	RANK() OVER(ORDER BY Runs DESC) AS Rnk
	FROM CricketPlayers	
)

SELECT * FROM Cricket
WHERE Runs BETWEEN 10000 AND 12000
```
```sql
WITH Employee_sal
AS
(
	SELECT FirstName,Department,Salary,
	DENSE_RANK() OVER(ORDER BY Salary DESC) AS DnsRnk
	FROM Employee
	
)
SELECT * FROM Employee_sal
```
```sql
WITH ProductList
AS
(
	SELECT ProductName,Price,
	NTILE(3) OVER(ORDER BY Price DESC) AS TILE
	FROM Products
)
SELECT * FROM ProductList
```
## 1.Find the second highest salary from the employee
```sql
SELECT MAX(Salary) AS Max_Sal
FROM EMPLOYEE
WHERE Salary < (
			   SELECT MAX(Salary) 
			   FROM Employee
			   )
```
## Second way
```sql
SELECT TOP 1 Salary FROM (
                   SELECT Salary,
				   DENSE_RANK() OVER (ORDER BY Salary DESC) AS DNSRNK
				   FROM Employee
				   )T
WHERE DNSRNK = 2
```

## 2.Get the nth highest salary(say 3rd highest)
```sql
SELECT DISTINCT Salary
FROM Employee
ORDER BY Salary DESC
OFFSET 2 ROWS
FETCH NEXT 1 ROWS ONLY
```
## Second Way
```sql
SELECT TOP 1 Salary FROM(
			          SELECT Salary,
				      DENSE_RANK() OVER(ORDER BY Salary DESC) AS DNSRNK
				     FROM Employee
					 ) R
WHERE DNSRNK = 3
```
## 3.List employees who earn more than their manager
```sql
SELECT E.FirstName, E.LastName, E.Salary, M.FirstName AS ManagerFirstName, M.LastName  AS ManagerLastName, M.Salary AS ManagerSalary
FROM Employee E
JOIN Manager M
ON E.ManagerID = M.ManagerID
WHERE E.Salary > M.Salary
```
## 4.Get all the duplicate record in the table
```sql
SELECT FirstName,LastName,Salary
FROM Employee
GROUP BY FirstName,LastName,Salary
HAVING COUNT(*)>1
```
## 5.Delete duplicate rows from a table but keep one copy
```sql
SELECT * FROM Orders

SELECT * FROM Customers
```
```sql
DELETE FROM Orders
WHERE OrderID NOT IN (
					SELECT MIN(OrderID)
					FROM Orders
					GROUP BY CustomerID, OrderDate
				)
```

## 2nd Solution
```sql
WITH CTE AS(
		   SELECT OrderID,CustomerID,OrderDate,
		   ROW_NUMBER() OVER(PARTITION BY OrderID,CustomerID,OrderDate ORDER BY OrderID) AS RWN
		   FROM Orders
		   )
DELETE FROM CTE
WHERE RWN > 1
```
## 6.Write a quary to pivot data without using PIVOT keyword
```sql
SELECT * FROM CricketPlayers
```
```sql
SELECT PlayerID,
MAX(CASE WHEN ROLE= 'All-Rounder' THEN Role END) AS ROLE_PLAYER,
MAX(CASE WHEN ROLE = 'Batsman' THEN Role END) AS BATSMAN
FROM CricketPlayers
GROUP BY PlayerID
```
## 7.Count total employee in each department
```sql
SELECT * FROM Employee

SELECT Department, COUNT(*) AS Emp_count
FROM Employee
GROUP BY Department
```
## 8.Difference WHERE AND HAVING

**WHERE:-Filter rows before grouping**

**HAVING:-Filter groups after aggregation**
```sql
SELECT Department,COUNT(*)
FROM Employee
WHERE Salary > 5000
GROUP BY Department
HAVING COUNT(*) > 2
```
## 9.Fetch orders for the last 6 month
```sql
SELECT * FROM Orders

SELECT * FROM Orders
WHERE OrderDate >= DATEADD(MONTH, -6,GETDATE())
```
## 10.Get cummulative salary by department
```sql
SELECT FirstName,LastName,Department,Salary,
SUM(Salary) OVER(PARTITION BY Department ORDER BY FirstName) AS Cummulative_Salary
FROM Employee
```
## 11.Find department with more than average number of employee
```sql
SELECT Department,COUNT(*) AS EMP_COUNT
FROM Employee 
GROUP BY Department
HAVING COUNT(*) > (
				  SELECT AVG(EMP_COUNT)
				  FROM (
						SELECT COUNT(*) AS EMP_COUNT
						FROM Employee
						GROUP BY Department
						) AS COUNT_DEPT
)
```
## 12.Identify employees with the top 3 salaries per department
```sql
SELECT TOP 3 * FROM(
			 SELECT *,DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS DNS_RNK
			 FROM Employee
			 ) AS Ranked
```

## 13.Join four tables: Employee,CricketPlayer,Customer,Orders,Product
```sql
SELECT E.FirstName,E.Department,E.Salary,C.PlayerName,C.Team,O.OrderDate,O.TotalAmount,CU.City,CU.LastName
FROM Employee E
JOIN CricketPlayers C ON E.EmployeeID = C.PlayerID
JOIN Orders O ON O.OrderID = E.EmployeeID
JOIN Customers CU ON CU.CustomerID = O.OrderID
```
## 14.Write the difference between RANK() and DENSE_RANK()

**RANK() Leaves gaps after ties**

**DENSE_RANK() Does nit leave gaps**
```sql
SELECT FirstName,Department,Salary,
RANK() OVER(ORDER BY Salary DESC) AS Rnk,
DENSE_RANK() OVER(ORDER BY Salary DESC) AS Dns_Rnk
FROM Employee
```
## 15.Find the median salary from the employee tables
```sql
SELECT AVG(Salary) AS MedianSalary
FROM (
    SELECT Salary,
           ROW_NUMBER() OVER (ORDER BY Salary) AS rn,
           COUNT(*) OVER () AS total
    FROM Employee
) t
WHERE rn IN ( (total + 1) / 2, (total + 2) / 2 )
```
## 2ns Solution	
```sql
SELECT TOP 1 MedianSalary
FROM (
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Salary) 
        OVER () AS MedianSalary
    FROM Employee
) t
```
## 16.Reterive employee who never made a sale
```sql
SELECT E.EmployeeID
FROM Employee E
LEFT JOIN Orders O
ON E.EmployeeID = O.OrderID
WHERE E.EmployeeID IS NULL
```
## 17.Find the department with the highest salary
```sql
SELECT TOP 1 Department, CAST(ROUND(AVG(Salary),0) AS INT) AS Avg_sal
FROM Employee
GROUP BY Department
ORDER BY Avg_sal DESC
```
## 18.Show salary distribution as bound(e.g., 0-5k,5k-10k,etc)
```sql
SELECT CASE
          WHEN Salary < 5000 THEN '0-5K'
		  WHEN Salary BETWEEN 5000 AND 9999 THEN '5K-10K'
		  ELSE '10K+'
END AS Salary_rnk,
COUNT(*) AS Emp_count
FROM Employee
GROUP BY
		CASE 
				WHEN Salary < 5000 THEN '0-5K'
				WHEN Salary BETWEEN 5000 AND 9999 THEN '5K-10K'
				ELSE '10K+'
			END
```
## 2nd solution
```sql
WITH SalaryBuckets AS (
                     SELECT 
					      CASE
					           WHEN Salary BETWEEN 0 AND 5000 THEN '0-5K'
							   WHEN Salary BETWEEN 5001 AND 9999 THEN '5K-10K'
							   ELSE '10K+'
					END AS Salary_Range
FROM Employee
)					
 SELECT Salary_Range,COUNT(*) AS Employee_Count
 FROM SalaryBuckets
 GROUP BY Salary_Range
 ORDER BY 
        CASE Salary_Range
		WHEN '0-5k' THEN 1
        WHEN '5k-10k' THEN 2
        WHEN '10k-15k' THEN 3
        WHEN '15k-20k' THEN 4
        ELSE 5
    END
```
## 19.Write a quary to transpose row data into columns
```sql
SELECT * FROM Orders

SELECT OrderID,TotalAmount,
MAX(CASE WHEN TotalAmount = 100 THEN OrderDate END) AS Total_order,
MAX(CASE WHEN TotalAmount = 200 THEN OrderDate END) AS Total_order
FROM Orders
GROUP BY TotalAmount,OrderID
```                     
## 20.Identify gaps in a sequence of number
```sql
SELECT C1.PlayerID + 1  AS MissingID 
FROM CricketPlayers C1
LEFT JOIN CricketPlayers C2 ON C1.PlayerID + 1  = C2.PlayerID
WHERE C2.PlayerID IS NULL
```
## 21.Find the employee working on multipe project
```sql
SELECT EmployeeID FROM Employee
GROUP BY EmployeeID
HAVING COUNT(DISTINCT EmployeeID) > 1
```
## 22.Get count of employees by joining date(month wise)
```sql
SELECT * 
FROM Employee

ALTER TABLE Employee
ADD Hire_date DATE

UPDATE Employee
SET Hire_date = '2025-03-17'
WHERE EmployeeID = 8

SELECT FORMAT(Hire_date, 'YYYY-MM') AS Join_Month,COUNT(*) AS Emp_Count
FROM Employee
GROUP BY FORMAT(Hire_date, 'YYYY-MM')
ORDER BY Join_Month
```
## With year and month together
```sql
SELECT YEAR(Hire_date) AS Join_Year,MONTH(Hire_date) As Join_Month,COUNT(*) AS Emp_count
FROM Employee
GROUP BY YEAR(Hire_date) ,MONTH(Hire_date)
ORDER BY YEAR(Hire_date) ,MONTH(Hire_date)
```
## 23.Select employees with palindrome names
```sql
SELECT FirstName, REVERSE(FirstName) AS Reversed
FROM Employee
```
## 24.Fetch top 3 salaries in each department using Rank()
```sql
SELECT TOP 3 * FROM (
			  SELECT *, RANK() OVER(PARTITION BY Department Order BY Salary DESC) AS RNK
			  FROM Employee
			  ) RANKED
```

## 25.Find customers who bought both Laptop and Headphones
```sql
SELECT ProductID
FROM Products
WHERE ProductName IN ('Laptop','Headphones')
GROUP BY ProductID
HAVING COUNT(DISTINCT ProductName) = 2
```
## 26.Write a quary to find running total of sales
```sql
SELECT OrderDate,TotalAmount,SUM(TotalAmount) OVER (ORDER BY OrderDate) AS Running_Total
FROM Orders
```
## 27.What is the difference between UNION and UNION ALL

**UNION:-Remove duplicates**
**UNION ALL:-Keep all rows including duplicates**
```sql
SELECT FirstName FROM Employee
UNION 
SELECT PlayerName FROM CricketPlayers
```
## 28.Identify employees who report to same manager
```sql
SELECT ManagerID, COUNT(*) AS Emp_Count
FROM Employee
WHERE ManagerID IS NOT NULL
GROUP BY ManagerID
HAVING COUNT(*) > 1
```
## 29.Retrieve the first and last salary entry per employee

**UNBOUNDED PRECEDING → Start from the very first row in the partition.**

**UNBOUNDED FOLLOWING → Go all the way to the last row in the partition.**
```sql
SELECT EmployeeID,
FIRST_VALUE(CAST(ROUND(Salary, 0) AS INT)) OVER (PARTITION BY EmployeeID ORDER BY Hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)AS First_Salary,
LAST_VALUE(CAST(ROUND(Salary, 0) AS INT)) OVER (PARTITION BY EmployeeID ORDER BY Hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)AS Last_Salary
FROM Employee
```
## 30.Write a quary to get the maximum difference in salaries in each department
```sql
SELECT Department,MAX(Salary) - MIN(Salary) AS Salary_difference
FROM Employee
GROUP BY Department
```
## 31.Select top N rows per group using Row_Number()
```sql
SELECT TOP 2 *,
ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RNK
FROM Employee
```
## 32.Retrieve employees who hacve same salary as someone else
```sql
SELECT * FROM Employee
WHERE Salary IN (
				SELECT Salary FROM Employee
				GROUP BY Salary
				HAVING COUNT(*) > 1
				)
```
## 33.Find continuous login streaks by users
```sql
WITH login_streaks AS(
					 SELECT EmployeeID,Hire_date,
					 DATEDIFF(DAY,-ROW_NUMBER() OVER(PARTITION BY EmployeeID ORDER BY Hire_date), Hire_date) AS StreakGroup
					 FROM Employee
)
SELECT EmployeeID,MIN(Hire_date) AS Streak_start, MAX(Hire_date) Steak_end,COUNT(*) AS Streak_length
FROM login_streaks
GROUP BY EmployeeID,StreakGroup
ORDER BY EmployeeID,Streak_start
```
## 34.Find maximum salary for each department and join with employee details
```sql
SELECT D.Department, D.EmployeeID, D.FirstName, D.Salary
FROM Employee D
JOIN(
    SELECT Department, MAX(Salary) AS Max_Sal
    FROM Employee
    GROUP BY Department
) AS M
ON D.Department = M.Department AND D.Salary = M.Max_Sal
ORDER BY D.Department
```
## 2nd solution
```sql
WITH MaxSal AS (
				SELECT Department,MAX(Salary) AS Max_Salary
				FROM Employee
				GROUP BY Department
				)
SELECT E.*
FROM Employee E
JOIN MaxSal M
ON E.Department = M.Department AND E.Salary = M.Max_Salary 
```
## 35.Show number of employees who joined each year
```sql
SELECT YEAR(Hire_date) AS Join_year,COUNT(*) AS Num_employee
FROM Employee
GROUP BY Hire_date
ORDER BY Hire_date
```
## 36.Retrieve product that were never sold
```sql
SELECT P.* FROM Products P
LEFT JOIN Orders O
ON P.ProductID = O.OrderID
WHERE P.ProductID IS NULL
```
## 37.Write a quary remove duplicates from the table
```sql
DELETE FROM Employee
WHERE EmployeeID NOT IN (
					    SELECT MIN(EmployeeID) FROM Employee
						GROUP BY FirstName,Department,Salary
						)
SELECT * FROM Employee
```
## 38.Select the 5th highest salary without using LIMIT/TOP or OFFSET
```sql
SELECT Salary FROM (
				   SELECT Salary,DENSE_RANK() OVER(Order BY Salary DESC) AS RNK
				   FROM Employee
				   )T
WHERE RNK = 5
```
##39.Find the department with no employee
```sql
SELECT E.* FROM Employee E
LEFT JOIN Employee D ON E.EmployeeID = D.EmployeeID
WHERE D.EmployeeID IS NULL
```
## 40.Calculate average, min,max salary per department
```sql
SELECT Department,CAST(ROUND(AVG(Salary),0) AS INT) AS Avg_sal,CAST(ROUND(MIN(Salary),0) AS INT) AS Min_sal,CAST(ROUND(MAX(salary),0)AS INT) AS Max_sal
FROM Employee
GROUP BY Department
```
## 41.Find the duplicate records using window function
```sql
SELECT * FROM (
			   SELECT *,RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS RNK
			   FROM Employee
			   )T
WHERE RNK = 1
```
## 42.Show count of distinct salaries in each department
```sql
SELECT Department,COUNT(DISTINCT Salary) AS Distinct_Salaries
FROM Employee
GROUP BY Department
```
## 43.Find highest paid employee per job title
```sql
SELECT * FROM (
			 SELECT *,RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS RNK
			 FROM Employee
			 ) S
WHERE RNK = 1
```
## 44.Write a quary to show employee count by department and gender
```sql
SELECT Department,Gender,COUNT(*) AS Emp_count
FROM Employee
GROUP BY Department,Gender
```
## 45.Find the total sales in the current month
```sql
SELECT SUM(TotalAmount) AS Monthly_sales
FROM Orders
WHERE MONTH(OrderDate) = MONTH(GETDATE()) AND YEAR(OrderDate) = YEAR(GETDATE())
```
## 46.Find employee who worked on all the project
```sql
ALTER TABLE Employee
ADD ProjectID INT,Gender VARCHAR(5)

UPDATE Employee
SET ProjectID = 4, Gender = 'M'
WHERE EmployeeID = 7
```
```sql
SELECT EmployeeID FROM Employee
GROUP BY EmployeeID
HAVING COUNT(DISTINCT ProjectID) = (
							       SELECT COUNT(*) FROM Employee
								   )
```
## 47.Calculate percentage contribution of each employee's salary in their department
```sql
SELECT EmployeeID,FirstName,Department,Salary,
CAST(ROUND(Salary * 100/SUM(Salary) OVER(PARTITION BY Department),2) AS DECIMAL(10,2)) AS Dept_Percentage
FROM Employee
```
## 48.Identify rows with changed salary over time for the same employee
```sql
SELECT EmployeeID,Salary,Hire_date
FROM(
    SELECT*,LAG(Salary) OVER(PARTITION BY EmployeeID ORDER BY Hire_date) AS PrevSalary
	FROM Employee
	)E
WHERE Salary!= PrevSalary
```
## 49.Show the latest sale per customer
```sql
SELECT * FROM(
             SELECT *,ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY OrderDate DESC) AS RN
			 FROM Orders 
			 )T
WHERE RN = 1
```
## 50.Get the day-wise revenue trend in the past week
```sql
SELECT CAST(OrderDate AS DATE) AS Sale_Day,SUM(TotalAmount) AS DailyRevenue
FROM Orders
WHERE OrderDate >= DATEADD(DAY, -7, GETDATE())
GROUP BY CAST(OrderDate AS DATE)
ORDER BY Sale_Day
```
## 51.Display employee name along with manager name
```sql
ALTER TABLE Employee
ADD ManagerID INT

SELECT * FROM Employee

UPDATE Employee
SET ManagerID = 6
WHERE FirstName LIKE 'David'
```
```sql
SELECT DISTINCT E.EmployeeID,CONCAT(E.FirstName,' ',E.LastName) AS Full_Name, M.ManagerID
FROM Employee E
LEFT JOIN Employee M ON E.EmployeeID = M.ManagerID
WHERE M.ManagerID IS NOT NULL
```
## 52.Find customers who placed orders more than once in a day 
```sql
INSERT INTO Orders VALUES  (4,104,'2025-06-30',250),
						   (5,105,'2025-06-30',350),
						   (6,106,'2025-01-03',800),
						   (7,107,'2025-02-19',550),
						   (8,108,'2025-02-19',650),
						   (9,109,'2025-08-09',450),
						   (10,110,'2022-11-30',680)

ALTER TABLE Orders
ADD Hourss TIME 

UPDATE Orders
SET Hourss = '17:50:00'
WHERE OrderID = 10


SELECT * FROM Orders
```
```sql
SELECT CustomerID,DAY(OrderDate) AS DayOfMonth,DATENAME(WEEKDAY, OrderDate) AS DayName,DATEPART(HOUR, Hourss) AS HourOfDay,COUNT(*) AS OrdersCount
FROM Orders
GROUP BY CustomerID,DAY(OrderDate),DATENAME(WEEKDAY, OrderDate),DATEPART(HOUR, Hourss)
ORDER BY DayOfMonth, HourOfDay
```
## 2nd way to get some more information
```sql
SELECT CustomerID,OrderDate AS OrderDateOnly,Hourss AS TimeOnly,DATEPART(HOUR, Hourss) AS HourOfDay,DATEPART(SECOND, Hourss) AS Seconds,
DATENAME(WEEKDAY, OrderDate) AS DayName,DATEPART(WEEKDAY, OrderDate) AS WeekdayNumber,CAST(OrderDate AS DATETIME) + CAST(Hourss AS DATETIME) AS FullTimestamp
FROM Orders
ORDER BY OrderDateOnly, TimeOnly
```
## 53.Count of order placed per hour of the day
```sql
SELECT DATEPART(HOUR, Hourss) AS HourOfDay,COUNT(*) AS OrderCount
FROM Orders
GROUP BY DATEPART(HOUR, Hourss) 
ORDER BY HourOfDay
```
## 54.Retrieve employees with the same department and salary as somone else
```sql
SELECT * FROM Employee

SELECT  * FROM Employee E
WHERE EXISTS(
			SELECT 1 FROM Employee S
			WHERE S.EmployeeID != E.EmployeeID AND S.Department = E.Department AND S.Salary = E.Salary
			)
```
## 55.Show rank of employees globally and with in department
```sql
SELECT CONCAT(FirstName,' ',LastName) AS Full_Name,Department,Salary,Hire_date,Gender,
RANK() OVER(ORDER BY Salary DESC) AS GloballyRank,
RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
FROM Employee
```
## 56.Select record where row number is a primary number
```sql
WITH Numbered AS (
     SELECT *, ROW_NUMBER() OVER(ORDER BY EmployeeID) AS RN
	 FROM Employee
	 )
SELECT * FROM Numbered
WHERE RN IN (2,3,7)
```
## 57.Find highest and lowest salary in the employee without using aggrigation

### Highest Salary
```
SELECT * FROM (
			SELECT *, ROW_NUMBER() OVER(ORDER BY Salary DESC) AS rn
			FROM Employee
) AS Ranked
WHERE rn = 1
```
### Lowest Salary
```sql
SELECT * FROM (
			SELECT *, ROW_NUMBER() OVER(ORDER BY Salary ASC) AS rn
			FROM Employee
) AS Ranked
WHERE rn = 1
```
## 58.Write a quary to show gender-wise department headcount
```sql
SELECT Department,Gender,COUNT(*) AS Emp_Count
FROM Employee
GROUP BY Department,Gender
```
## 59.Get the earliest and latest joining data in each department
```sql
SELECT Department,MAX(Hire_date) AS Latest_Join,MIN(Hire_date) AS Earliest_Join
FROM Employee
GROUP BY Department
```
## 60.Find all employees whoname starts and ends with a vowel.
```sql
SELECT *FROM Employee
WHERE LOWER(LEFT(LTRIM(RTRIM(FirstName)), 1)) IN ('a', 'e', 'i', 'o', 'u')
```
## 61.Find users who made a purchase in 3 consecutive months
```sql
SELECT DISTINCT O1.CustomerID
FROM Orders O1
JOIN Orders O2 ON O1.CustomerID = O2.CustomerID
JOIN Orders O3 ON O1.CustomerID = O3.CustomerID
WHERE MONTH(O2.OrderDate) = MONTH(O1.OrderDate) + 1 
AND MONTH(O3.OrderDate) = MONTH(O2.OrderDate) + 2
AND YEAR(O1.OrderDate) = YEAR(O2.OrderDate)
AND YEAR(O1.OrderDate) = YEAR(O3.OrderDate)
```
## 62.Retrieve employees with exactly 2 subordinates
```sql
SELECT ManagerID FROM Employee
WHERE ManagerID IS NOT NULL
GROUP BY ManagerID
HAVING COUNT(*) = 2
```
## 63.Rank customers based on total revenue
```sql
SELECT CustomerID,SUM(TotalAmount) Total_Revenue,
RANK() OVER(ORDER BY SUM(TotalAmount) DESC) AS Revenue_Rank
FROM Orders
GROUP BY CustomerID
```
## 64.Detect if a table contains only unique rows
```sql
SELECT CASE
          WHEN EXISTS (
                   SELECT 1
                   FROM CricketPlayers
                   GROUP BY PlayerID, PlayerName, Team, Role, Runs, Wickets
                  HAVING COUNT(*) > 1
)
  THEN 'Duplicates Exist'
  ELSE 'All rows unique'
END AS unique_rows
```
## 65.calculate employee tenure in months
```sql
SELECT FirstName,Salary,Hire_date,DATEDIFF(MONTH, Hire_date, GETDATE()) AS Tenure_month
FROM Employee
```
## 66.Convert comma-seprated values into rows
```sql
SELECT CP.PlayerID,CP.PlayerName,s.value AS Skill
FROM CricketPlayers CP
CROSS APPLY STRING_SPLIT(CP.Role, ',') AS s
```
## 67.Write a quary to count weekend logins
```sql
SELECT DATENAME(WEEKDAY, Hire_date) AS DayName,COUNT(*) AS LoginCount
FROM Employee
WHERE DATENAME(WEEKDAY, Hire_date) IN ('Saturday', 'Sunday')
GROUP BY DATENAME(WEEKDAY, Hire_date)
```
## 68.Fetch most recent login per user
```sql
SELECT * FROM (
             SELECT *, ROW_NUMBER() OVER(PARTITION BY EmployeeID ORDER BY Hire_date DESC) AS RN
			 FROM Employee
			 ) T
WHERE RN = 1
```
## Alternate Way
```sql
WITH Ranked AS (
    SELECT *,ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY Hire_date DESC) AS RN
    FROM Employee
)
SELECT *
FROM Ranked
WHERE RN = 1
```
## 69.Write a quary to flag duplicate rows with a yes/no
```sql
SELECT *,
   CASE 
     WHEN COUNT(*) OVER(PARTITION BY FirstName,Department,Salary) > 1 THEN 'Yes'
	   ELSE 'No'
 END AS Duplicate
FROM Employee
```
## 70.Compare salaries between the month and find changes
```sql
SELECT E.EmployeeID AS FebEmployeeID,E.FirstName AS FebFirstName,E.Gender AS FebGender,E.Department AS FebDepartment,E.Salary AS FebSalary,
S.EmployeeID AS JulEmployeeID,S.FirstName AS JulFirstName,S.Gender AS JulGender,S.Department AS JulDepartment,S.Salary AS JulSalary,
(S.Salary - E.Salary) AS SalaryDifference
FROM Employee E
CROSS JOIN Employee S
WHERE YEAR(E.Hire_date) = 2025 AND MONTH(E.Hire_date) = 2 AND YEAR(S.Hire_date) = 2025 AND MONTH(S.Hire_date) = 7
```
## Use INFORMATION_SCHEMA.COLUMNS
```sql
SELECT COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employee'
```
## 71.Find employees who have worked in more than 1 department
```sql
SELECT * FROM Employee
WHERE ProjectID IN (
					SELECT ProjectID FROM Employee
					GROUP BY ProjectID
					HAVING COUNT(DISTINCT Department) > 1
				)
```
## 72.List all months where no sales accured
```sql
CREATE TABLE Sales (
    SaleID INT ,
    SaleDate DATE,
    Amount DECIMAL(10,2)
)

INSERT INTO Sales (SaleID, SaleDate, Amount) VALUES (1, '2025-01-15', 1000.00),
													(2, '2025-03-10', 1500.00),
													(3, '2025-05-20', 2000.00),
													(4, '2025-06-05', 1800.00),
													(5, '2025-09-12', 2200.00),
													(6, '2025-12-01', 2500.00)

```
## Generate all months of 2025
```sql
WITH AllMonths AS (
				SELECT DATEFROMPARTS(2025, 1, 1) AS MonthStart
				UNION ALL
				SELECT DATEADD(MONTH, 1, MonthStart)
				FROM AllMonths
				WHERE MONTH(MonthStart) < 12
			)
```
## Find months with no sales
```sql
SELECT FORMAT(M.MonthStart, 'MMMM') AS MonthName
FROM AllMonths M
LEFT JOIN Sales S ON YEAR(S.SaleDate) = YEAR(M.MonthStart) AND MONTH(S.SaleDate) = MONTH(M.MonthStart)
WHERE S.SaleID IS NULL
OPTION (MAXRECURSION 12)
```
## 73.Write a quary to find median salary by department
```sql
SELECT Department,
			PERCENTILE_CONT(0.5) 
							WITHIN GROUP 
									(ORDER BY Salary) OVER(PARTITION BY Department) AS Median_Salary
FROM Employee
```

# 74.Calculate moving average of sales(last 3 days)
#### Gives all info.
```sql
SELECT SaleDate,Amount,CAST(ROUND(AVG(Amount) OVER(ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),0) AS INT) AS MovingAvg
FROM Sales
``
```sql
INSERT INTO Sales (SaleDate, Amount)
VALUES 
(CAST(GETDATE() AS DATE), 1000),
(DATEADD(DAY, -1, CAST(GETDATE() AS DATE)), 1500),
(DATEADD(DAY, -2, CAST(GETDATE() AS DATE)), 2000)
```
### Last 3 days
```sql
SELECT S1.SaleDate,S1.Amount,(
							 SELECT CAST(ROUND(AVG(S2.Amount), 0) AS INT)
							 FROM Sales S2
							 WHERE S2.SaleDate BETWEEN DATEADD(DAY, -2, S1.SaleDate) AND S1.SaleDate
						 ) AS MovingAvg
FROM Sales S1
WHERE S1.SaleDate BETWEEN DATEADD(DAY, -2, CAST(GETDATE() AS DATE)) AND CAST(GETDATE() AS DATE)
```											
## 75.Identify top 5 customers by number of orders per city Mumbai Delhi Kolkata Bihar
```sql
UPDATE Orders
SET City = 'Bihar'
WHERE OrderID = 7


ALTER TABLE Orders
ADD City VARCHAR(15)

SELECT TOP 5 * FROM (
			 SELECT CustomerID,City,COUNT(*) AS Order_Count,
			 RANK() OVER(PARTITION BY City ORDER BY COUNT(*) DESC) AS RNK
			 FROM Orders
			 GROUP BY CustomerID,City
			 ) O
```
## 76. Write a SQL Query to retrieve the product names and their corresponding categories for products with a price greater than $50.
```sql
SELECT ProductName,Category,Price
FROM Products
WHERE Price > 50
```
## 77.Find managers who also report to someone else
```sql
SELECT DISTINCT Department,ManagerID FROM Employee 
WHERE ManagerID IN (
					SELECT EmployeeID FROM Employee
					WHERE ManagerID IS NOT NULL
					)
```
## 78.List department where no one earn more than 50,000
```sql
SELECT Department,Salary FROM Employee
GROUP BY Department,Salary
HAVING MAX(Salary) <= 50000
```
## 79.Get count of employees hired in last 7 days,grouped by day
```sql
SELECT CAST(Hire_date AS DATE) AS Join_date,COUNT(*) AS Emp_count
FROM Employee
WHERE Hire_date >= DATEADD(DAY, -7, CAST(GETDATE() AS DATE))
GROUP BY CAST(Hire_date AS DATE)
ORDER BY Join_date
```
## 80.Get hourly orders distribution for the last 24 hours
```sql
SELECT DATEPART(HOUR,Hourss) AS Order_Time,COUNT(*) AS Order_count
FROM Orders
GROUP BY DATEPART(HOUR,Hourss)
ORDER BY Order_Time
```
## 81.Find the employee who has the highest salary in the company
```sql
SELECT * FROM Employee
WHERE Salary = (
			   SELECT MAX(Salary)
			   FROM Employee
			   )
```
## 82.Calculate % changes in monthly revenue
```sql
SELECT MONTH(OrderDate) AS Month,SUM(TotalAmount) AS TotalAmount,LAG(SUM(TotalAmount)) OVER(ORDER BY MONTH(OrderDate)) AS Prev_month_Revenue,
    CAST(ROUND((SUM(TotalAmount) - LAG(SUM(TotalAmount)) OVER(ORDER BY MONTH(OrderDate))) * 100.0 / 
        NULLIF(LAG(SUM(TotalAmount)) OVER(ORDER BY MONTH(OrderDate)), 0), 2
    ) AS DECIMAL(5,2)) AS Percent_change
FROM Orders
GROUP BY MONTH(OrderDate)
ORDER BY MONTH(OrderDate)
```
## 83.Identify customers who only bought one product ever
```sql
SELECT ProductName FROM Products
GROUP BY ProductName
HAVING COUNT(DISTINCT ProductID) = 1
```
## 84.Write a quary to get numbers of months between two dates
```sql
SELECT DATEDIFF(MONTH, '2025-08-23', '2025-07-23') AS MonthsGap
```
## 85.Get users who purchased in both Q1 and Q2 of the same year
```sql
WITH QuarterOrders AS (
					SELECT CustomerID,YEAR(OrderDate) AS OrderYear,
						CASE 
							WHEN MONTH(OrderDate) BETWEEN 1 AND 3 THEN 'Q1'
							WHEN MONTH(OrderDate) BETWEEN 4 AND 6 THEN 'Q2'
						END AS Quarter
					FROM Orders
					WHERE MONTH(OrderDate) BETWEEN 1 AND 6  -- Only Q1 and Q2
)
SELECT CustomerID,OrderYear
FROM QuarterOrders
GROUP BY CustomerID, OrderYear
HAVING COUNT(DISTINCT Quarter) = 1
```
## 86. Write a SQL Query to retrieve the count of orders placed on each date.
```sql
SELECT OrderDate,COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY OrderDate
```
## 87. Write a SQL Query to calculate the average total order amount
```sql
SELECT AVG(TotalAmount) AS AvgTotalAmount
FROM Orders
```
## 88. Write a SQL Query to retrieve the customer names (concatenated first name and last name) along with their corresponding city.
```sql
SELECT CONCAT(FirstName,' ',LastName) AS Full_Name, City
FROM Customers
```
## 89. How do you use the DISTINCT keyword in a SQL Query? Provide an example
```sql
SELECT DISTINCT Department 
FROM Employee
```
## 90.How can you update data in a table using SQL? Provide an example
```sql
UPDATE Products
SET Price = 1000
WHERE ProductID = 1
```
## 91.What is the purpose of the BETWEEN operator in SQL? Give an example of how it is used.
```sql
SELECT FirstName,LastName,Department,Salary
FROM Employee
WHERE Salary BETWEEN 50000 AND 60000
```
## 92.Explain the LIKE operator in SQL, and how is it different from the = operator?
```sql
SELECT * FROM Employee
WHERE FirstName LIKE 'David%'
```
## 93.What is a self-join in SQL? Provide an example of how it can be used.
```sql
SELECT P.ProductID,P.Category,P.Price,O.CustomerID,O.OrderDate,O.TotalAmount 
FROM Products P 
JOIN Orders O
ON P.ProductID=O.OrderID
```
## 94.Explain the concept of SQL Common Table Expressions (CTEs) and provide an example.
```sql
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

```
## 95. CREATE FUNCTION ON CricketPlayers
```sql
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
```
## CALL THE FUNCTION
```sql
SELECT * FROM GetPlayerByName('Virat Kohli')
```
## 96.FUNCTION 2
```sql
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
```
## CALL THE FUNCTION
```sql
SELECT * FROM Employee_Salary(50000)
```


## 3rd FUNCTION
```sql
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
```
## CALL THE FUNCTION
```sql
SELECT * FROM CustomerMP ('New York')

SELECT * FROM CustomerMP('Los Angeles')
WHERE CustomerID = 2
```
## 97. CREATE VIEW ON CRICKET
```sql
CREATE VIEW VW_Cricket
AS
SELECT PlayerName,Role,Runs,Wickets
FROM CricketPlayers
```
## CALL THE VIEW
```sql
SELECT * FROM VW_Cricket
```
## CREATE VIEW ON PRODUCT
```sql
CREATE VIEW KR_Product
AS
SELECT ProductName,Price
FROM Products
```
## CALL THE PRODUCT VIEW
```sql
SELECT * FROM KR_Product
```
## CREATE VIEW ON EMPLOYEE
```sql
CREATE VIEW Em_Employee
AS
SELECT FirstName,Department,Salary
FROM Employee
```
## CALL THE EMPLOYEE VIEW
```sql
SELECT * FROM Em_Employee
```

## 98. CLUSTERED INDEX AND NON - CLUSTERED INDEX

#### CLUSTERED INDEX
```sql
CREATE CLUSTERED INDEX CI_CRICKET ON CricketPlayers (PlayerName,Role)
```
#### CALL THE CLUSTERED INDEX
```sql
SELECT * FROM CricketPlayers
WHERE PlayerName = 'Virat Kohli' AND Role = 'Batsman'

SELECT * FROM CricketPlayers
WHERE PlayerName LIKE 'R%'
```
## 99. NON - CLUSTERED INDEX
```sql
CREATE NONCLUSTERED INDEX NCI_EMPLOYEE ON Employee(FirstName,Department,Salary)
```
### CALL  NON - CLUSTERED INDEX
```sql
SELECT FirstName,Department,Salary
FROM Employee
WHERE FirstName = 'Michael' AND Department = 'Finance' AND Salary = 70000.00
```
## 100. STORE PROCDURE
```sql
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
```
### CALL PROCEDURE
```sql
EXEC CountRuns
```

#### SEE BY NAMES
```sql
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
```
### CALL PROCEDURE
```sql
EXEC Performance_Player
```

### Definition of Procedure
```sql
sp_helptext 'Performance_Player';
```

### Alter Store Procedure
```sql
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
```

