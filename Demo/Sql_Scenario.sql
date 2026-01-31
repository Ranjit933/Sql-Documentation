CREATE DATABASE SQL_SCENARIO

USE SQL_SCENARIO

/*
You need to retrieve the names and salaries of employees from the employees table, but only for those working in the Finance department.
1.Question:
How would you use the SELECT statement with a WHERE clause to retrieve specific data based on a condition? The SELECT statement is 
used to query specific columns from a table and retrieve data based on certain conditions.The WHERE clause filters the rows returned 
by the query, ensuring only records meeting the specified criteria are included in the result set. In this case, we want only the
employees working in the Finance department
*/

CREATE TABLE Employees(
					  Employee_id INT PRIMARY KEY,
					  First_Name VARCHAR(50) NOT NULL,
					  Last_Name VARCHAR(50) NOT NULL,
					  Department VARCHAR(50) NOT NULL,
					  Salary DECIMAL(10,2)
					  )

INSERT INTO Employees (Employee_id,First_Name,Last_Name,Department,Salary) 
VALUES(1,'John','Doe','HR',50000),(2,'Alica','George','IT',50000),(3,'Bob','Frank','IT',60000),(4,'Lora','Georgia','Finance',60000)

SELECT * FROM Employees

SELECT First_Name,Last_Name,Salary
FROM Employees
WHERE Department = 'Finance'

/* 
You need to add a new employee named John Doe to the employees table with a salary of 50,000 and a department of HR.
2.Question:
How can you use the INSERT statement to add a new record to the employees table? The INSERT statement allows you to add a new record to a 
table by specifying the column names and corresponding values. You must ensure that the values match the data types and constraints 
(e.g., NOT NULL) defined in the table
*/

INSERT INTO Employees (Employee_id,First_Name,Last_Name,Department,Salary) 
VALUES(1,'John','Doe','HR',50000)

/*
You need to increase the salary of all employees in the IT department by 10%.
3.Question:
How would you use the UPDATE statement to modify existing records? The UPDATE statement modifies existing rows in a table.You use the 
SET clause to specify the column(s) to be updated and the WHERE clause to target specific rows. In this case, we increase the salary of 
all employees in the IT department by 10%
*/

UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'IT'

/*
The HR department has been closed, and all employees in HR must be removed from the database.
3.Question:
How can you use the DELETE statement to remove specific records? The DELETE statement removes rows from a table. In this 
case, you must use the WHERE clause to delete only employees belonging to the HR department. Without the WHERE clause, all rows 
would be deleted
*/

DELETE FROM Employees
WHERE Department = 'HR'

/*
You need to create a table that stores product prices, including whole numbers and decimal values.
4.Question:
Which data type should you use to store product prices in a table? The DECIMAL data type is the most appropriate for storing
prices since it provides high precision and control over decimal places. Using DECIMAL avoids rounding issues that might arise with 
floating-point data types like FLOAT
*/
CREATE TABLE Products(
				     Product_ID INT PRIMARY KEY,
					 Product_Name VARCHAR(20),
					 Price DECIMAL(10,2)
					 )

/*
You need to filter employees with salaries between 30,000 and 60,000
5.Question:
How can you use comparison operators to filter records based on a salary range? Comparison operators such as >= and <= can filter rows
based on specific ranges. The AND operator combines these conditions, ensuring both are satisfied
*/

SELECT * FROM Employees
WHERE Salary >= 30000 AND Salary <= 60000

/*
You want to retrieve employees whose salaries are not 40,000.
6.Question:
How can you use the != operator to exclude certain values in SQL? The != operator filters out rows where the column matches a
specific value. This scenario requires excluding employees with a salary of exactly 40,000
*/

INSERT INTO Employees VALUES(1,'John','Rickey','Sales',40000),(5,'Michael','Franks','Marketing',50000)

SELECT * FROM Employees
WHERE Salary != 40000

/*
You need to find employees whose names contain the letter 'a'.
7.Question:
How can you use the LIKE operator to search for patterns in SQL? The LIKE operator allows searching for patterns in text. In
this scenario, % acts as a wildcard that matches any sequence of characters
*/

SELECT * FROM Employees
WHERE First_Name LIKE '%A%'

/*
You want to check if there are any employees in the Sales department
8.Question:
How can you use the EXISTS operator to verify if a department has employees?The EXISTS operator checks if a subquery returns any rows.
If it does, the result is TRUE.
*/

SELECT CASE
		  WHEN EXISTS( 
					 SELECT 1 FROM Employees WHERE Department = 'Sales') THEN 1 ELSE 0
					 END AS SalesExists

/*
You want to create a table that stores whether employees are active or inactive
9.Question:
Which data type should you use to store true/false values in SQL? The BOOLEAN data type stores TRUE or FALSE values,ideal for representing
binary states
*/

CREATE TABLE Employee_Status(
					       Employee_ID INT PRIMARY KEY,
						   First_Name VARCHAR(50),
						   IS_ACTIVE BIT  --True if Active False if Inactive
						   )
/*
You need to retrieve the top 5 highest-paid employees from the employees table.
10.Question:
How would you use the ORDER BY and LIMIT clauses to get the top records? The ORDER BY clause sorts the data, and the LIMIT clause
restricts the number of rows returned. To retrieve the top 5 highest-paid employees, you need to sort the salary in
descending order and use LIMIT 5.
*/

SELECT TOP 5 * FROM Employees
ORDER BY Salary DESC

/*
You want to calculate the total salary for each department.
11.Question:
How can you use the GROUP BY clause to aggregate data? The GROUP BY clause groups rows with the same values, allowing aggregate 
functions like SUM() to be applied to each group. In this scenario, we group employees by department and calculate the total salary 
for each department.
*/
SELECT Department,SUM(Salary) AS Total_Salary
FROM Employees
GROUP BY Department
ORDER BY Total_Salary DESC

/*
You need to display departments with a total salary greater than 100,000
12.Question:
How can you filter grouped data using the HAVING clause? The HAVING clause filters grouped data after aggregation.In this scenario, 
it ensures only departments with a total salary greater than 100,000 are displayed
*/
SELECT Department,SUM(Salary) AS Total_Salary
FROM Employees
GROUP BY Department
HAVING SUM(Salary) > 100000
ORDER BY Total_Salary DESC

/*
You need to combine employees from two tables: employees_2023 and employees_2024.
13.Question:
How would you use the UNION operator to combine the data? The UNION operator combines the result sets of two SELECT queries and 
removes duplicates. Both queries must return the same number of columns with compatible data types
*/
CREATE TABLE employees_2023 (
    Employee_ID INT,
    First_Name VARCHAR(50),
    Department VARCHAR(50)
)
INSERT INTO employees_2023 (Employee_ID, First_Name, Department)
VALUES (1, 'Alice', 'Sales'),(2, 'Bob', 'HR'),(3, 'Charlie', 'IT'),(4, 'Diana', 'Finance')

CREATE TABLE employees_2024 (
    Employee_ID INT,
    First_Name VARCHAR(50),
    Department VARCHAR(50)
)

INSERT INTO employees_2024 (Employee_ID, First_Name, Department)
VALUES (1, 'Alice', 'Sales'), (3, 'Charlie', 'IT'), (5, 'Ethan', 'Marketing'),(6, 'Fiona', 'Finance')

SELECT First_Name,Department
FROM employees_2023
UNION
SELECT First_Name,Department
FROM employees_2024

/*
You want to keep duplicates while combining two datasets
14.Question:
How can you use UNION ALL to retain all rows, including duplicates? The UNION ALL operator combines result sets and keeps all rows, 
including duplicates. It is more efficient since it doesn’t check for duplicates
*/
SELECT First_Name,Department
FROM employees_2023
UNION ALL
SELECT First_Name,Department
FROM employees_2024

/*
You need to create a list of employees who belong to either the Finance or IT department
15.Question:
How can you use the IN operator to filter multiple values? The IN operator allows filtering a column against multiple values. 
In this scenario, it ensures only employees from the Finance or IT departments are retrieved
*/

SELECT Employee_id,Department,Salary
FROM Employees
WHERE Department IN ('Finance', 'IT')
ORDER BY Salary DESC

/*
You need to calculate the average salary across all employees.
16.Question:
How can you use the AVG() function to find the average value? The AVG() function calculates the average value of a numeric
column. In this scenario, it finds the average salary across all employees.
*/

SELECT AVG(Salary) AS Avg_Salary
FROM Employees

/*
You need to find employees who don’t belong to the HR department.
17.Question:
How can you use the NOT IN operator to exclude certain values? The NOT IN operator excludes rows where the column value matches
any value in a specified list. In this case, it filters out employees from the HR department.
*/

SELECT Employee_id,Department,Salary
FROM Employees
WHERE Department NOT IN ('HR')

/*
You need to retrieve only the first three employees in alphabetical order by their first names
18.Question:
How can you use ORDER BY and LIMIT together? The ORDER BY clause sorts the results, and LIMIT restricts the number of rows returned. 
This scenario retrieves the first three employees alphabetically by their first name.
*/

SELECT TOP 3 First_Name,Last_Name FROM Employees
ORDER BY First_Name ASC

/*
You want to join the employees table with the departments table to display employee names along with their department names
19.Question:
How can you use the JOIN clause to combine data from multiple tables? The JOIN clause combines rows from two or more tables
based on a related column. In this scenario, the department_id column links the employees and departments tables
*/

CREATE TABLE Department(
						Department_ID INT PRIMARY KEY,
						Department_Name VARCHAR(20)
						)
INSERT INTO Department VALUES(1,'Sales'),(2,'IT')

SELECT E.First_Name,E.Department,D.Department_Name
FROM Employees E
INNER JOIN Department D
ON E.Employee_id = D.Department_ID

/*
You need to retrieve employees who joined within the last six months.
20.Question:
How can you use date functions and the WHERE clause to filter records by date range? In SQL, date filtering is achieved using functions 
like CURRENT_DATE or NOW(). You can subtract six months using the INTERVAL keyword to find employees who joined recently
*/
SELECT * FROM Employees

ALTER TABLE Employees
ADD Join_Date DATE

UPDATE Employees
SET Join_Date = CASE
					 WHEN Employee_id = 1 THEN  '2025-08-12'
					 WHEN Employee_id = 2 THEN  '2025-06-10'
					 WHEN Employee_id = 3 THEN  '2025-01-05'
					 WHEN Employee_id = 4 THEN  '2025-05-12'
					 WHEN Employee_id = 5 THEN  '2025-07-26'
					 WHEN Employee_id = 6 THEN  '2025-03-07'
				END

SELECT First_Name,Department,Salary,Join_Date
FROM Employees
WHERE Join_Date >= DATEADD(MONTH,-6,GETDATE())

/*
You want to generate a list of employees with their total annual bonuses. Bonuses are 10% of their salary.
21.Question:
How can you use arithmetic operators to calculate derived values? The * operator allows you to calculate the annual bonus as
10% of the employee's salary
*/

SELECT First_Name,Department,Salary,CAST(ROUND(Salary * 0.10,0) AS INT) AS Bonus
FROM Employees

/*
You need to assign unique IDs to each result row, grouped by department and ordered by salary.
22.Question:
How can you use ROW_NUMBER() with PARTITION BY? ROW_NUMBER() assigns a unique number to each row, and PARTITION BY ensures the 
numbering resets for each department
*/

SELECT First_Name,Department,
							ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Salary DESC) AS RWN
FROM Employees

/*
You need to delete duplicate rows from a table, keeping only one instance of each duplicate.
23.Question:
How can you identify and remove duplicate rows using ROW_NUMBER()? Using ROW_NUMBER() with PARTITION BY, you can mark duplicate rows 
and delete them by keeping only the first occurrence
*/

SELECT * FROM Employees

WITH CTE AS
(
SELECT *,
		ROW_NUMBER() OVER(PARTITION BY First_Name,Department ORDER BY Employee_id) AS RWN
FROM Employees
)
DELETE FROM Employees
WHERE Employee_id IN (
					 SELECT Employee_id FROM CTE
					 WHERE RWN > 1
					 )

/*
You want to list employees with their managers. Managers are also stored in the employees table
24.Question:
How can you use SELF JOIN to connect employees with their managers? A SELF JOIN allows you to join a table with itself. Here, each
employee has a manager_id that references another employee's employee_id.
*/

ALTER TABLE Employees
ADD Manager_Id INT FOREIGN KEY (Manager_Id) REFERENCES Employees(Employee_ID)

UPDATE Employees
SET Manager_Id = CASE 
					WHEN Employee_id = 1 THEN  2
					WHEN Employee_id = 2 THEN  1
					WHEN Employee_id = 3 THEN  2
					WHEN Employee_id = 4 THEN  3
					WHEN Employee_id = 5 THEN  3
					WHEN Employee_id = 6 THEN  4
				ELSE Manager_Id
			END

SELECT E.First_Name AS Employee_Name, M.First_Name AS Manager_Name
FROM Employees E
LEFT JOIN Employees M
ON E.Employee_id = M.Manager_Id

/*
You need to merge new employee records with existing ones. If an employee exists, update the salary; otherwise, insert the
new employee.
25.Question:
How can you use the MERGE statement to perform an upsert operation? The MERGE statement allows you to insert or update records
based on whether the employee already exists	
*/

SELECT * FROM employees_2023
SELECT * FROM Employees


ALTER TABLE employees_2023
ADD Salary DECIMAL(10,2)

UPDATE employees_2023
SET Salary = CASE
				WHEN Employee_ID = 1 THEN 35000
				WHEN Employee_ID = 2 THEN 45000
				WHEN Employee_ID = 3 THEN 58000
				WHEN Employee_ID = 4 THEN 60000
			END 

MERGE INTO Employees E
USING employees_2023 N ON E.Employee_ID = N.Employee_ID
WHEN MATCHED THEN 
				UPDATE SET E.Salary = N.Salary
WHEN NOT MATCHED THEN 
	INSERT (Employee_ID,First_Name,Salary)
	VALUES(N.Employee_ID,N.First_Name,N.Salary);

/*
You need to find all employees who have not submitted their projects
26.Question:
How can you use LEFT JOIN and IS NULL to find unmatched rows? A LEFT JOIN helps find rows in one table that have no matching rows in another.
*/

CREATE TABLE Project_Submissions(
								Submission_ID INT PRIMARY KEY,
								Employee_ID INT,
								FOREIGN KEY (Employee_ID) REFERENCES Employees (Employee_ID)
								)

INSERT INTO Project_Submissions VALUES(1111,1),(4568,2),(4589,5),(7824,3)

SELECT * FROM Project_Submissions

SELECT E.Employee_id FROM Employees E
LEFT JOIN Project_Submissions P
ON P.Employee_ID = E.Employee_id
WHERE P.Employee_ID IS NULL

/*
You want to display the total number of employees in each department, including departments with no employees.
27.Question:
How can you use LEFT OUTER JOIN to retrieve all departments? Using a LEFT OUTER JOIN, all departments are retrieved,
even if no employees exist
*/

SELECT * FROM Employees
SELECT * FROM Department

SELECT D.Department_Name,COUNT(E.Employee_ID) AS Employee_Count
FROM Department D
LEFT JOIN Employees E
ON E.Employee_id = D.Department_ID
GROUP BY D.Department_Name

/*
You need to create a table that records the current timestamp when a row is inserted
28.Question:
How can you use DEFAULT with the TIMESTAMP column? Using DEFAULT CURRENT_TIMESTAMP, SQL automatically records the insertion time
*/

CREATE TABLE Logs(
				 Logs_ID INT PRIMARY KEY,
				 Description VARCHAR(25),
				 Created_AT DATETIME DEFAULT SYSDATETIME()
				 )

INSERT INTO Logs (Logs_ID, Description)
VALUES (1, 'First log entry');

SELECT * FROM Logs

/*
You want to ensure that each employee email is unique
29.Question:
How can you use the UNIQUE constraint? The UNIQUE constraint ensures that no two employees have the same email
*/

CREATE TABLE Employees1(
                     Emp_ID INT PRIMARY KEY,
					 First_Name VARCHAR(50),
					 Email VARCHAR(50) UNIQUE
					 )

/*
You need to find the second highest salary from the employees table
30.Question:
How can you retrieve the second highest salary using SQL? You can use ORDER BY and LIMIT with OFFSET to retrieve the second highest salary.
ORDER BY sorts the rows by salary in descending order. OFFSET 1 skips the first row (the highest salary), and LIMIT 1 ensures 
only the second highest salary is returned.
*/

SELECT  Salary 
FROM Employees
ORDER BY Salary DESC
OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY

SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees
WHERE Salary < (
			    SELECT MAX(Salary)
				FROM Employees
				)

/*
You need to compare two columns in the same table to find discrepancies
31.Question:
How can you compare two columns within the same table using SQL? SQL allows you to compare two columns using the WHERE clause. 
This is helpful for checking if values in two columns differ, such as salary and expected_salary.
*/


SELECT * FROM employees_2023

ALTER TABLE employees_2023
ADD Expected_salary INT

UPDATE employees_2023
SET Expected_salary = CASE
						  WHEN Employee_ID = 1 THEN 30000
						  WHEN Employee_ID = 2 THEN 45000
						  WHEN Employee_ID = 3 THEN 60000
						  WHEN Employee_ID = 4 THEN 60000
						END 

SELECT First_Name,Department,Salary,Expected_salary
FROM employees_2023
WHERE Salary ! = Expected_salary

/*
You need to identify duplicate employee names in the employees table.
32.Question:
How can you use GROUP BY and HAVING to find duplicate entries? The GROUP BY clause groups rows with identical values,
and the HAVING clause filters groups with more than one row
*/

SELECT * FROM employees_2023

SELECT First_Name,COUNT(*) AS Duplicate_count
FROM employees_2023
GROUP BY First_Name
HAVING COUNT(First_Name) > 1

/*
You want to update multiple columns for an employee in one query.
33.Question:
How can you use the UPDATE statement to modify multiple columns? The UPDATE statement can modify multiple columns by listing them in
the SET clause.
*/

SELECT * FROM Employees

UPDATE Employees
SET Department = 'IT', Salary = 55000
WHERE Employee_id = 1

/*
You need to insert data into one table by selecting it from another.
34.Question:
How can you use INSERT INTO ... SELECT to copy data between tables?The INSERT INTO ... SELECT statement inserts data from one
table into another. Both tables must have matching column types.
*/

SELECT * FROM employees_2023
SELECT * FROM employees_2024

INSERT INTO employees_2024 (Employee_ID,First_Name,Department)
SELECT Employee_ID,First_Name,Department
FROM employees_2023

/*
You want to calculate the cumulative salary for employees ordered by department.
35.Question:
How can you use SUM() with OVER() to compute cumulative totals? The SUM() function with OVER() computes a running total for each row 
within a partition.
*/

SELECT * FROM Employees

SELECT Employee_id,First_Name,Department,Salary,
SUM(Salary) OVER(PARTITION BY Department ORDER BY Salary DESC) AS Cummulative_Salary
FROM Employees

/*
You want to delete employees who don’t belong to a specified list of departments.
36.Question:
How can you use the NOT IN operator to filter and delete specific rows? The NOT IN operator excludes rows matching any value in the
specified list
*/

SELECT * FROM employees_2024

DELETE FROM employees_2024
WHERE Department NOT IN ('Sales','HR')

/*
You need to count employees in each department but only display departments with more than five employees
37.Question:
How can you use GROUP BY with HAVING to filter grouped data? The GROUP BY clause groups rows by department, and the HAVING clause 
filters those with more than five employees.
*/

SELECT Department,COUNT(Employee_id) AS Emp_Count 
FROM Employees
GROUP BY Department
HAVING COUNT(Employee_id) > 5

/*
You want to check if there are employees earning more than 60,000.
38.Question:
How can you use the EXISTS clause to verify the presence of specific records? The EXISTS clause checks if a subquery returns any rows.
*/

SELECT CASE 
         WHEN EXISTS (SELECT 1 FROM Employees WHERE Salary > 58000) 
         THEN 1 
         ELSE 0 
       END AS SalaryExists

/*
You want to rank employees within each department based on their salary.
39.Question:
How can you use the RANK() function with PARTITION BY? The RANK() function assigns ranks to rows within each department, resetting for 
each partition.
*/

SELECT * FROM Employees

SELECT First_Name,Department,Salary,
RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS RNK
FROM Employees

/*
Inserting new employee data into a table
40.Question:
How would you insert a new employee record into the employees table with details such as id, name,department_id, and salary?
The INSERT statement adds new data to a table
*/

CREATE TABLE New_Employee(
						 Emp_ID INT PRIMARY KEY,
						 Ename VARCHAR(20),
						 Department_ID INT,
						 Salary DECIMAL(10,2)
						 )

INSERT INTO New_Employee VALUES(1,'Alexa',101,50000)

/*
Updating employee salaries based on performance
41.Question:
How can you increase the salary of employees in the employees table by 10% for those in department 101? The UPDATE statement modifies 
rows with a condition.
*/

UPDATE New_Employee
SET Salary = Salary * 1.10
WHERE Department_ID = 101

/*
Deleting records of employees who left the company
42.Question:
How would you delete all employees with IDs between 2 and 5?
*/

DELETE FROM Employees
WHERE Employee_id BETWEEN 2 AND 5

/*
Inserting multiple rows at once
42.Question:
How would you add multiple employees to the employees table?
*/

INSERT INTO employees_2023 (Employee_ID, First_Name, Department)
VALUES (1, 'Alice', 'Sales'),(2, 'Bob', 'HR'),(3, 'Charlie', 'IT'),(4, 'Diana', 'Finance')

/*
43.Question:
Ensuring all employees have unique email addresses
*/

CREATE TABLE New_Employees(
						 Emp_ID INT PRIMARY KEY,
						 Ename VARCHAR(20),
						 Department_ID INT,
						 Email VARCHAR(100) UNIQUE
						 )

INSERT INTO New_Employees VALUES(1,'Eve','Eve@gmail.com',102)

/*
44.Question:
Scenario: Managing failed transactions with ROLLBACK
*/

SELECT * FROM Employees

BEGIN TRANSACTION

UPDATE Employees SET Salary = 65000 WHERE Employee_id = 1

ROLLBACK

/*
45.Question:
Scenario: Grouping employee records by department
*/

SELECT Department,AVG(Salary) AS Avg_sal
FROM Employees
GROUP BY Department

/*
46.Question:
Scenario: Automatically updating a log table when employees are added
*/

CREATE TABLE Employee_Status(
					       Employee_ID INT PRIMARY KEY,
						   First_Name VARCHAR(50),
						   IS_ACTIVE BIT  --True if Active False if Inactive
						   )

/*
47.Question:
Scenario: Ensuring data consistency with a foreign key constraint
*/

CREATE TABLE New_Department(
							Emp_ID INT PRIMARY KEY,
							Department_Name VARCHAR(20)
							)

CREATE TABLE Emp(
				Emp_ID INT PRIMARY KEY,
				First_Name VARCHAR(20), 
				Department_Name VARCHAR(20)
				FOREIGN KEY (Emp_ID) REFERENCES New_Department(Emp_ID)
				)

/*
48.Question:
Scenario: Creating a view to show high-earning employees
*/

SELECT * FROM Employees

CREATE VIEW High_Earning_Employees AS
SELECT First_Name,Salary
FROM Employees
WHERE Salary > 50000


SELECT * FROM High_Earning_Employees

/*
Scenario: Adding a new column to an existing table
49.Question: 
How would you add a new column, email, to the employees table? To store additional information, you can use the ALTER TABLE
statement to add a new column. This ensures the table structure can evolve with changing data requirements. Newly added
columns will have NULL values for existing records unless a DEFAULT value is specified.
*/

SELECT * FROM employees_2023

ALTER TABLE Employees_2023
ADD Email VARCHAR(100)

/*
Scenario: Removing a column from a table
50.Question:
How can you remove the email column from the employees table? Use the ALTER TABLE statement with DROP COLUMN to remove
an unnecessary column from the table. Be careful, as this action is irreversible and will delete all data in that column
*/

ALTER TABLE Employees_2023
DROP COLUMN Email

/*
Scenario: Renaming a column in a table
51.Question: 
How would you rename the name column to employee_name in the employees table? You can use ALTER TABLE with RENAME COLUMN to modify the
name of a column for better clarity or consistency.
*/

SELECT * FROM employees_2023

EXEC sp_rename 'employees_2023.First_Name','Emp_Name','COLUMN'

/* 
Scenario: Changing the data type of a column
52.Question:
How can you change the data type of the salary column from DECIMAL to INTEGER? If you need to change a column's data type, 
use ALTER TABLE with MODIFY or ALTER COLUMN. Be cautious as incompatible changes may require data adjustments.
*/

ALTER TABLE employees_2023
ALTER COLUMN Expected_salary DECIMAL(10,2)

SELECT COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'employees_2023'

/*
Scenario: Setting a default value for a column
53.Question:
How would you set a default value of 0 for the salary column? Setting a default value ensures that if no value is provided during
an insert, the column will automatically be assigned the default.
*/

ALTER TABLE employees_2023
ADD CONSTRAINT DF_Employees_ExpectedSalary
DEFAULT 0 FOR Expected_salary

/*
Scenario: Dropping a default value from a column
54.Question:
How can you remove the default value from the salary column? Use ALTER TABLE to drop a default value. After this, if no value is
provided, the column will store NULL.
*/

ALTER TABLE employees_2023
DROP CONSTRAINT DF_Employees_ExpectedSalary

/*
Scenario: Adding a primary key to a table
55.Question: 
How would you add a primary key to the employees table using the id column? A primary key uniquely identifies each row and ensures no
duplicates.
*/

SELECT * FROM employees_2023

ALTER TABLE employees_2023
ADD CONSTRAINT PK_Employee_ID PRIMARY KEY(Employee_ID)

EXEC sp_helpconstraint 'employees_2023'

/*
Scenario: Adding a foreign key constraint to a table
56.Question:
How would you add a foreign key on department_id referencing the departments table? Foreign keys ensure referential integrity between tables
*/

SELECT * FROM Department
SELECT * FROM Employee_Status

ALTER TABLE Employee_Status
ADD CONSTRAINT FK_Department FOREIGN KEY REFERENCES Department(Department_ID)

/*
Scenario: Creating an index on the salary column
57.Question: 
How would you create an index on the salary column to improve query performance? An index speeds up searches on a specific column.
*/

CREATE INDEX Index_Salary ON employees_2023(Salary)

SELECT Salary FROM employees_2023
WHERE Salary = 45000

/*
Scenario: Dropping an index from a table
58.Question:
How would you drop the idx_salary index? Use the DROP INDEX statement to remove an index.
*/

DROP INDEX Index_Salary ON employees_2023

/*
Scenario: Handling duplicate rows in a table
59.Question: 
How can you remove duplicate rows from a table, keeping only the first occurrence? Duplicate rows can lead to incorrect results in 
reports or analytics. To remove them, we use ROW_NUMBER() with a PARTITION BY clause to assign a unique number to each duplicate
row. We keep the first occurrence and delete the others.
*/

WITH Duplicates
AS(
SELECT Employee_ID,Emp_Name,Department,Salary,
ROW_NUMBER() OVER(PARTITION BY Emp_Name,Department ORDER BY Employee_ID DESC) AS RWN
FROM employees_2023
)
DELETE FROM Duplicates
WHERE RWN > 1

/*
Scenario: Combining multiple result sets with UNION
60.Question: 
How would you combine employees and contractors into a single result set without duplicates? The UNION operator combines rows from 
multiple queries and removes duplicates. It ensures unique entries in the final result set.
*/

SELECT First_Name,Department,Salary FROM Employees
UNION
SELECT Emp_Name,Department,Salary FROM employees_2023

/*
Scenario: Fetching the top N salaries
61.Question: 
How would you retrieve the top 2 highest salaries from the employees table? Using ORDER BY with LIMIT retrieves the top N rows sorted by a
specific column.
*/

SELECT TOP 2 First_Name,Department,Salary
FROM Employees
ORDER BY Salary DESC

/*
Scenario: Using a self-join to find employees reporting to the same manager
62.Question:
How would you find pairs of employees reporting to the same manager? A self-join joins a table with itself, enabling comparisons within
the same table.
*/

SELECT * FROM Employees

SELECT E.First_Name,E.Department,E.Salary,M.Department,M.Salary
FROM Employees E
INNER JOIN Employees M
ON E.Employee_id = M.Manager_Id
WHERE E.Salary < M.Salary

/*
Scenario: Recursive query to find the hierarchy of employees
63.Question: 
How can you retrieve the hierarchy of employees in an organization? A recursive CTE helps you query hierarchical data, such as
employees and their managers.
*/

SELECT * FROM Employees

WITH EmployeeHierarchy
AS(
SELECT Employee_id,First_Name,Department,Manager_Id
FROM Employees 
WHERE Manager_Id IS NOT NULL
UNION ALL
SELECT E.Employee_id,E.First_Name,E.Department,E.Manager_Id
FROM Employees E
INNER JOIN Employees M
ON E.Employee_id = M.Manager_Id
)
SELECT * FROM EmployeeHierarchy

/*
Scenario: Calculating running totals using a window function
64.Question:
How would you calculate a running total of salaries? The SUM() window function with OVER() calculates cumulative sums for each row in 
sequence
*/

SELECT * FROM employees_2023

SELECT Emp_Name,Department,Salary,Expected_salary,
SUM(Salary) OVER(ORDER BY Salary) AS Cumm_Sal  
FROM employees_2023

/*
Scenario: Identifying employees with the same salary
65.Question:
How would you find employees earning the same salary? Use GROUP BY with HAVING to filter groups with more than one
employee sharing the same salary.
*/

SELECT Salary,COUNT(*) AS EMP_COUNT
FROM Employees
GROUP BY Salary
HAVING COUNT(*) > 1

/*
Scenario: Handling NULL values in SQL
66.Question: 
How can you replace NULL salaries with a default value of 0 when retrieving data? The COALESCE() function returns the first non-null value 
from a list, making it useful for replacing NULL values.
*/

SELECT * FROM employees_2023

SELECT Emp_Name,COALESCE(Salary,0) AS Salary
FROM employees_2023

/*
Scenario: Creating a materialized view for performance optimization
67.Question:
How would you create a materialized view to store high salary employees? A materialized view stores query results physically, improving
performance for repeated queries.
*/

CREATE VIEW Materialized  
AS
SELECT Emp_Name,Salary FROM employees_2023
WHERE Salary > 35000

SELECT * FROM Materialized

/*
Scenario: Locking a table to prevent other transactions from accessing it
68.Question:
How would you lock a table to ensure that only your transaction can make changes to it? When performing sensitive operations, locking a 
table ensures that other transactions cannot modify or read from it until your operation is complete. SQL uses LOCK TABLE to prevent 
conflicts between concurrent transactions.
*/

SELECT * FROM Employees_2023

UPDATE Employees_2023 WITH (TABLOCKX)
SET Salary = Salary * 1.10


/*
Scenario: Using isolation levels to manage concurrent transactions
69.Question:
How do isolation levels control data consistency in concurrent transactions?
Isolation levels control how transactions interact with each other. SQL provides the
following levels:
● READ UNCOMMITTED: Allows dirty reads.
● READ COMMITTED: Only committed changes are visible.
● REPEATABLE READ: Ensures the same data is read within a transaction.
● SERIALIZABLE: Prevents concurrent access, ensuring complete isolation.
*/

SELECT * FROM Employees

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

BEGIN TRANSACTION
			UPDATE Employees 
			SET Salary = 70000 
			WHERE Employee_id = 2

       COMMIT
		     ROLLBACK
/*
Scenario: Enforcing a CHECK constraint
70.Question: 
How can you ensure that employee salaries cannot be less than 30,000? A CHECK constraint ensures that values in a column meet a
specific condition.
*/

SELECT * FROM Employees

ALTER TABLE Employees
ADD CONSTRAINT Check_Salary
CHECK (Salary >= 30000)

SP_HELP 'Employees'

INSERT INTO Employees VALUES(7,'Roni','Leon','Sales',25000,'2025-03-08',5)

/*
Scenario: Automatically updating timestamps using a trigger
71.Question: 
How can you automatically update a timestamp when an employee’s details change? Use a trigger to set the last_updated column whenever an
employee’s record is modified.
*/

SELECT * FROM Employees

ALTER TABLE Employees
ADD Last_Update DATETIME2

CREATE TRIGGER trg_LastUpdate ON Employees
AFTER UPDATE 
AS BEGIN
      UPDATE E
	  SET E.Last_Update = SYSDATETIME()
	  FROM Employees E
	  INNER JOIN inserted I
	  ON E.Employee_id = I.Employee_id
END
	

INSERT INTO Employees (Employee_id,First_Name,Last_Name,Department,Salary,Join_Date,Manager_Id)
VALUES(7,'Roni','Leon','Sales',35000,'2025-03-08',5)

UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR'

/*
Scenario: Using a partitioned table for performance optimization
72.Question:
How would you partition a table by department? Partitioning divides large tables into smaller, manageable pieces based on a column, 
improving query performance.
*/

-- 1. Create a partition function
-- This defines how Department_ID values are split into partitions
CREATE PARTITION FUNCTION pf_DepartmentID (INT)
AS RANGE LEFT FOR VALUES (102, 200)
-- Partition ranges:
-- <= 102 goes to partition 1
-- <= 200 goes to partition 2
-- > 200 goes to partition 3

-- 2. Create a partition scheme
-- This maps partitions to filegroups (here all on PRIMARY for simplicity)
CREATE PARTITION SCHEME ps_DepartmentID
AS PARTITION pf_DepartmentID
TO ([PRIMARY], [PRIMARY], [PRIMARY])

-- 3. Create the partitioned table
CREATE TABLE Employees_Partitioned
(
    ID INT,
    Employee_Name VARCHAR(100),
    Salary DECIMAL(10,2),
    Department_ID INT
)
ON ps_DepartmentID(Department_ID)

INSERT INTO Employees_Partitioned VALUES (1, 'Ravi', 50000, 101); -- goes to partition 1
INSERT INTO Employees_Partitioned VALUES (2, 'Anita', 60000, 150); -- goes to partition 2
INSERT INTO Employees_Partitioned VALUES (3, 'Sohan', 70000, 250); -- goes to partition 3

SELECT * FROM Employees_Partitioned

--CHECK PARTITION NUMBER

SELECT ID, Employee_Name, Department_ID,
       $PARTITION.pf_DepartmentID(Department_ID) AS PartitionNumber
FROM Employees_Partitioned

/*
Scenario: Using JSON data in SQL
73.Question: 
How would you store and query JSON data in a SQL table? SQL databases support JSON columns to store semi-structured data
*/

CREATE TABLE Json_Employee_Data(
						  ID INT PRIMARY KEY,
						  Details NVARCHAR(MAX)
						  )

INSERT INTO Json_Employee_Data (ID, Details)
VALUES (1, '{"Name":"Ravi","Salary":50000,"Department":"HR"}');

SELECT * FROM Json_Employee_Data 

/*
Scenario: Creating an updatable view
74.Question: 
How can you create a view that allows updates to the underlying table? An updatable view allows changes to flow through the view into
the base table.
*/

SELECT * FROM Employee_Status

INSERT INTO Employee_Status VALUES(1,'Roni','True'),(2,'Moni','False'),(3,'Alexa','True')

sp_help 'employee_status'

CREATE VIEW Active_Employee
AS
SELECT Employee_ID,First_Name FROM Employee_Status
WHERE IS_ACTIVE = 1
WITH CHECK OPTION

SELECT * FROM Active_Employee

UPDATE Active_Employee SET First_Name = 'Alica'
WHERE Employee_ID = 1

/*
Scenario: Using temporary tables for intermediate calculations
75.Question: 
How would you use a temporary table to store intermediate results? Temporary tables store data temporarily for intermediate processing and 
are dropped automatically after the session ends
*/

-- Local temporary table (For current session)
SELECT *
INTO #Temp_High_Salary
FROM Employees
WHERE Salary > 60000

SELECT * FROM #Temp_High_Salary

DROP TABLE #Temp_High_Salary

-- Check tempdb
SELECT name, object_id
FROM tempdb.sys.objects
WHERE name LIKE '%Temp_High_Salary%'

/*
Scenario: Creating a clustered index on a primary key column
76.Question: 
How would you create a clustered index on the employee_id column of the employees table? A clustered index determines the physical storage 
order of the rows based on the indexed column. Typically, a primary key is a clustered index by default, but it  can be explicitly created 
as well.
*/

SELECT * FROM employees_2023

CREATE CLUSTERED INDEX IDX_Employees ON employees_2023(Expected_salary)

/*
Scenario: Adding a non-clustered index to improve query performance
77.Question: 
How can you create a non-clustered index on the last_name column to speed up queries? A non-clustered index improves search 
performance without altering the physical order of the data. It provides pointers to the actual data location.
*/

CREATE NONCLUSTERED INDEX NON_IDX_Employees ON employees_2023(Salary)

/*
Scenario: Preventing duplicate values in a column
78.Question: 
How can you ensure that the email column in the employees table contains unique values only? The UNIQUE constraint ensures that no duplicate
values are entered into the email column.
*/

SELECT * FROM employees_2023

ALTER TABLE employees_2023
ADD Email NVARCHAR(20)

UPDATE employees_2023
SET Email = CASE
				WHEN Employee_ID = 1 THEN 'ABC@gmail.com'
				WHEN Employee_ID = 2 THEN 'CDE@gmail.com'
				WHEN Employee_ID = 3 THEN 'XYZ@gmail.com'
				WHEN Employee_ID = 4 THEN 'CDF@gmail.com'
			END
				

ALTER TABLE employees_2023
ADD CONSTRAINT unique_Email UNIQUE(Email)

SP_HELP 'employees_2023'

/*
Scenario: Dropping an index from a table
79.Question: 
How do you drop an index named idx_last_name from the employees table? The DROP INDEX statement is used to remove an index when it is
no longer needed, freeing up space and reducing maintenance overhead.
*/

DROP INDEX IDX_Employees ON Employees_2023

/*
Scenario: Ensuring a column cannot have NULL values
80.Question: 
How would you ensure that the last_name column in the employees table cannot store NULL values? The NOT NULL constraint ensures that a 
column must contain a value in every row. If you attempt to insert a row without a value in the last_name column, the database will return 
an error. This constraint helps maintain data consistency and integrity by ensuring critical fields are always populated.
*/

SELECT * FROM employees_2023

ALTER TABLE employees_2023
ALTER COLUMN Emp_Name VARCHAR(50) NOT NULL

/*
Scenario: Renaming a table in the database
81.Question: 
How would you rename the employees table to staff? The ALTER TABLE command with the RENAME TO clause allows us to rename a table while 
keeping its structure and data intact.
*/

EXEC SP_RENAME 'Logs', 'Staff'

/*
Scenario: Using a Trigger to Automatically Update a Timestamp
82.Question: 
How can you create a trigger to update the last_modified column whenever a row in the employees table is updated? A trigger automatically 
updates a column when a certain event occurs, such as an UPDATE. This ensures that last_modified reflects the latest change
*/

SELECT * FROM employees_2023

ALTER TABLE employees_2023 
ADD Last_Modfied DATETIME2

CREATE TRIGGER trg_Update_Last_Modified
ON employees_2023
AFTER UPDATE
AS BEGIN
		UPDATE E
		SET E.Last_Modfied = SYSDATETIME()
		FROM employees_2023 E
		INNER JOIN inserted I
		ON E.Employee_ID = I.Employee_ID
	END

/*
Scenario: Creating a Function to Calculate Bonuses
84.Question:
How can you create a function to calculate a 10% bonus for each employee’s salary? A user-defined function simplifies repeated calculations.
*/

SELECT * FROM Employees

CREATE FUNCTION Calculate_bonus(@Salary DECIMAL(10,2)) 
RETURNS DECIMAL
BEGIN
	RETURN @Salary * 0.10
END

--CALL FUNCTION

SELECT Employee_id,First_Name,Department,Salary,dbo.Calculate_bonus(Salary) AS Bonus
FROM Employees

/*
Scenario: Using Window Functions to Calculate Running Totals
85.Question:
How can you calculate a running total of salaries for employees ordered by their hire date? A window function calculates cumulative 
totals within a specific partition or order. In this case, the running total of salaries is calculated based on hire_date
*/

SELECT * FROM Employees

SELECT Employee_id,First_Name,Department,Salary,SUM(Salary) OVER(ORDER BY Join_Date) AS Running_Total
FROM Employees

/*
Scenario: Using Common Table Expressions (CTE) for Modular Queries
86.Question: 
How can you use a CTE to write modular queries in the employees table? A Common Table Expression (CTE) simplifies complex queries by
breaking them into smaller, modular parts.
*/

WITH High_Sal 
AS(
SELECT * FROM Employees WHERE Salary > 50000
)
SELECT * FROM High_Sal WHERE First_Name LIKE 'J%'

/*
Scenario: Finding Common Employees Across Multiple Departments
87.Question: 
How would you find employees who belong to both the HR and IT departments? The INTERSECT operator returns only the rows that appear in
both result sets, identifying employees belonging to multiple departments
*/

SELECT * FROM Employees WHERE Employee_id = 1
INTERSECT
SELECT * FROM Employees WHERE Employee_id = 6

CREATE TABLE Employees_Tables ( 
							  ID INT PRIMARY KEY, 
				              Name VARCHAR(100), 
							  Department VARCHAR(100), 
							  Manager_id INT, 
							  Salary DECIMAL(10,2), 
							  Hire_date DATE 
							  )

INSERT INTO Employees_Tables (ID, Name, Department, Manager_id, Salary, Hire_date) 
VALUES 
(1, 'Alice', 'HR', NULL, 70000, '2015-06-23'), 
(2, 'Bob', 'IT', 1, 90000, '2016-09-17'), 
(3, 'Charlie', 'Finance', 1, 80000, '2017-02-01'), 
(4, 'David', 'IT', 2, 75000, '2018-07-11'), 
(5, 'Eve', 'Finance', 3, 72000, '2019-04-30'); 

SELECT * FROM Employees_Tables

-- 89. How do you retrieve employees and their hierarchical managers recursively? 

WITH EmployeeHierarchy AS(
					     SELECT ID,Name,Manager_id,0 AS Level
						 FROM Employees_Tables
						 WHERE Manager_id IS NULL 
						 UNION ALL
						 SELECT E.ID,E.Name,E.Manager_id,Eh.level + 1
						 FROM Employees_Tables E
						 JOIN EmployeeHierarchy Eh ON E.Manager_id = Eh.ID
						 )
						 
SELECT * FROM EmployeeHierarchy ORDER BY Level

--90. How do you calculate the number of levels in an organizational hierarchy?

WITH Hierarchy AS(

SELECT ID,Name,Department,Manager_id, 1 AS LEVEL
FROM Employees_Tables
WHERE Manager_id IS NULL
UNION ALL
SELECT E.ID,E.Name,E.Department,E.Manager_id,H.LEVEL + 1
FROM Employees_Tables E
JOIN Hierarchy H ON E.Manager_id = H.ID
)

SELECT MAX(LEVEL) AS MAX_LEVELS FROM Hierarchy

--91.How can you calculate cumulative salary within each department? 

WITH Running_Salary
AS(
SELECT Department,Name,Salary,
						SUM(Salary) OVER(PARTITION BY Department ORDER BY Salary DESC) AS CUMM_SAL
FROM Employees_Tables
)
SELECT * FROM Running_Salary

--92.How do you find the most recent hire in each department? 

SELECT * FROM Employees_Tables

WITH Latest_Hire 
AS (
SELECT Name,Department,Salary,Hire_date,
									RANK() OVER(PARTITION BY Department ORDER BY Hire_date DESC) AS RNK
FROM Employees_Tables
)
SELECT * FROM Latest_Hire 
WHERE RNK = 1


--93.How can you identify employees without direct reports? 

WITH EmployeeReport 
AS(
SELECT E1.ID,E1.Name,COUNT(E2.ID) AS Report_Count
FROM Employees_Tables E1 LEFT JOIN Employees_Tables E2
ON E1.ID = E2.ID
GROUP BY E1.ID,E1.Name
)
SELECT * FROM EmployeeReport 
WHERE Report_Count = 0

--94.How do you rank employees based on salary within each department?

WITH Salary_Range
AS(
SELECT ID,Name,Department,Salary,
						RANK() OVER(PARTITION BY Department ORDER BY Salary) AS RNK											
FROM Employees_Tables
)
SELECT * FROM Salary_Range
WHERE RNK = 2

--95. How do you find employees who are earning below the department’s average salary? 

SELECT * FROM Employees_Tables

WITH DeptAvg AS
(
SELECT Department,CAST(ROUND(AVG(Salary),0) AS INT)  AS Avg_Sal
FROM Employees_Tables
GROUP BY Department
)
SELECT E.* FROM Employees_Tables E
JOIN DeptAvg D ON E.Department = D.Department
WHERE E.Salary < D.Avg_Sal

--96.How do you find the median salary per department using a CTE? 

WITH SalaryRanks AS 
(
SELECT Department, Salary,
				ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Salary) AS RN,
				COUNT(*) OVER(PARTITION BY Department) AS Total
FROM Employees_Tables
)
SELECT Department,AVG(Salary) AS Median_salary
FROM SalaryRanks WHERE RN IN((Total + 1) / 2,(Total + 2)/2)
GROUP BY Department

--97.How do you identify employees hired in the same year as their manager?

SELECT * FROM Employees_Tables

WITH HireYears 
AS(
SELECT E1.Name AS Emp_Name, E1.Hire_Date, E2.Name AS Mgr_name
FROM Employees_Tables E1 JOIN Employees_Tables E2 ON E1.Manager_id = E2.ID
)

SELECT * FROM HireYears WHERE YEAR(Hire_Date) = YEAR(GETDATE())

--98. How do you calculate rolling 3-month average salary per department? 

SELECT * FROM Employees_Tables

WITH RollingSalary 
AS(
SELECT Department,Name,Hire_date,Salary,
AVG(Salary) OVER(PARTITION BY Department ORDER BY Hire_Date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) Rolling_Avg
FROM Employees_Tables
)
SELECT * FROM RollingSalary

--99. How do you identify departments where salaries are increasing over time?

WITH SalaryTrend AS(
SELECT Department, Name,Salary,Hire_date,
LAG(Salary) OVER(PARTITION BY Department ORDER BY Hire_Date) AS Prev_Salary
FROM Employees_Tables
)
SELECT * FROM SalaryTrend
WHERE Salary < Prev_Salary

--100.How do you find employees hired after their manager? 

SELECT * FROM Employees_Tables

WITH ManagerHired 
AS(
SELECT E.Name AS Emp_Name,E.Department AS Emp_Dept,E.Salary AS Emp_Sal,E.Hire_date AS Emp_Hire,M.Name AS Mag_Name,M.Department AS Mag_dept,
M.Salary AS Mag_Sal, M.Hire_date AS Mag_Hire
FROM Employees_Tables E
JOIN Employees_Tables M
ON E.ID = M.Manager_id
)
SELECT * FROM ManagerHired
WHERE Emp_Hire > Mag_Hire

--101.How do you determine the highest and lowest-paid employees using a CTE? 


SELECT * FROM Employees_Table

WITH SalaryExtremes 
AS(
SELECT Name,Salary,
				FIRST_VALUE(Name) OVER(ORDER BY Salary DESC) AS Highest_Paid,
				FIRST_VALUE(Name) OVER(ORDER BY Salary ASC) AS Lowest_Paid
FROM Employees_Tables
)
SELECT DISTINCT Highest_Paid, Lowest_Paid
FROM SalaryExtremes

--102.How can you use a CTE to generate Fibonacci numbers? 

WITH Fibonacci (N, Fib, PrevFib) AS
(
    -- Anchor: first two numbers
    SELECT 1, 0, 0
    UNION ALL
    SELECT 2, 1, 0
    UNION ALL
    -- Recursive member
    SELECT N + 1, Fib + PrevFib, Fib
    FROM Fibonacci
    WHERE N < 10
)
SELECT N, Fib
FROM Fibonacci

--103. How do you pivot department-wise employee counts using a CTE?

SELECT * FROM Employees_Tables

WITH DeptCount
AS(
	SELECT Department,COUNT(*) AS EMP_COUNT FROM Employees_Tables
	GROUP BY Department
)
SELECT * FROM DeptCount

--BY PIVOT
WITH DeptCount AS (
    SELECT Department, COUNT(*) AS EMP_COUNT
    FROM Employees_Tables
    GROUP BY Department
)
SELECT *FROM DeptCount PIVOT
(
    SUM(EMP_COUNT) FOR Department IN ([HR], [IT], [Finance], [Sales])
) AS PivotTable

--104.How do you calculate the difference in salary between an employee and their manager? 

SELECT * FROM Employees

WITH SalaryComparision 
AS(
SELECT E.First_Name,E.Department,E.Salary AS Emp_Salary,M.Salary AS Mgr_Salary,(E.Salary - M.Salary) AS Diff_sal
FROM Employees E
JOIN Employees M 
ON E.Employee_id = M.Manager_Id
)
SELECT * FROM SalaryComparision

--105. How can you find the longest-tenured employees using a CTE?

SELECT * FROM Employees

WITH Tenure 
AS(
SELECT First_Name, Department,Salary,Join_Date,
		RANK() OVER(ORDER BY Join_Date) AS Tenure_Rank
FROM Employees
)
SELECT * FROM Tenure
WHERE Tenure_Rank = 1

--106.How can you create a CTE that identifies salary gaps between employees?

SELECT * FROM Employees

WITH Salary_Gap
AS(
SELECT First_Name,Department,
		LAG(Salary) OVER(ORDER BY Salary) AS Prev_Sal, Salary - LAG(Salary) OVER(ORDER BY Salary) AS Salary_Gap
FROM Employees
)
SELECT * FROM Salary_Gap

--107.How do you filter only employees who received a salary increase over time? 

WITH SalaryCharge
AS(
SELECT First_Name, Department, Join_Date,
					LAG(Salary) OVER(PARTITION BY First_Name ORDER BY Join_Date) AS Prev_Sal
FROM Employees
)
SELECT * FROM SalaryCharge

--108. How do you rank employees within their department based on hire date using a CTE? 

SELECT * FROM Employees

WITH HireRanking
AS(
SELECT First_Name,Department,Salary,Join_Date,
		RANK() OVER(PARTITION BY Department ORDER BY Join_Date) AS Hire_Date
FROM Employees
)
SELECT * FROM HireRanking

--109.How do you use a CTE to determine the cumulative headcount per year?

WITH YearlyHires AS (
    SELECT 
        YEAR(Join_Date) AS Hire_Year,COUNT(*) AS Yearly_Hires
    FROM Employees
GROUP BY YEAR(Join_Date)
)
SELECT Hire_Year,Yearly_Hires,SUM(Yearly_Hires) OVER (ORDER BY Hire_Year) AS Cumulative_Headcount
FROM YearlyHires
ORDER BY Hire_Year

--110.How do you generate a sequence of numbers using a recursive CTE?

WITH NumberSequence AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM NumberSequence
    WHERE num < 10
)
SELECT *
FROM NumberSequence

--111. How do you use a CTE to remove duplicate salaries while keeping the latest employee? 

SELECT * FROM Employees_Tables

WITH Duplicated_Record
AS(
SELECT Name,Department,Salary,Hire_date,
						ROW_NUMBER() OVER(PARTITION BY Salary ORDER BY Salary DESC) AS RWN
FROM Employees_Tables
)
SELECT * FROM Duplicated_Record
WHERE RWN = 1

---112.How do you determine which employees report directly or indirectly to a given manager?

WITH EmployeeHierarchy AS (
    SELECT Employee_id, First_Name, Department, Salary, Manager_Id, 1 AS Level
    FROM Employees
    WHERE Manager_Id = 1

    UNION ALL

    SELECT E.Employee_id, E.First_Name, E.Department, E.Salary, E.Manager_Id, EH.Level + 1
    FROM Employees E
    INNER JOIN EmployeeHierarchy EH
        ON E.Manager_Id = EH.Employee_id
)
SELECT *
FROM EmployeeHierarchy
OPTION (MAXRECURSION 0);  -- unlimited recursion

--113.How do you find the first and last employee hired in each department?

SELECT * FROM Employees

WITH HireOrder
AS(
SELECT First_Name,Department,Salary ,Join_Date,
FIRST_VALUE(First_Name) OVER(PARTITION BY Department ORDER BY Join_Date) AS First_hire,
LAST_VALUE(First_Name) OVER(PARTITION BY Department ORDER BY Join_Date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_Hire
FROM Employees
)
SELECT DISTINCT Department,First_hire,Last_Hire
FROM HireOrder

--114. How do you calculate the percentage of total salary each employee contributes within a department? 

SELECT * FROM Employees

WITH SalaryShare
AS(
SELECT First_Name,Department,Salary,
CAST(ROUND(Salary * 100.0 / SUM(Salary) OVER(PARTITION BY Department),2) AS DECIMAL(5,2)) AS Percentage
FROM Employees
)
SELECT * FROM SalaryShare

--115.How do you identify departments where salary expenses exceed a given threshold? 

SELECT * FROM Employees

WITH DeptSalaries 
AS ( 
SELECT Department,Salary,SUM(Salary) AS Total_salary
FROM Employees
GROUP BY Department,Salary
)

SELECT * FROM DeptSalaries WHERE Total_salary > 50000

--116.How do you identify employees earning within a certain percentile using a CTE? 

WITH SalaryPercentile 
AS ( 
SELECT Department,Salary,NTILE(4) OVER(ORDER BY Salary DESC)  AS salary_quartile 
FROM Employees
)
SELECT * FROM SalaryPercentile WHERE salary_quartile = 1



