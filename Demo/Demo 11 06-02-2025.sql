--SQL SERVER JOINS 
--#########################################################################
--Self learning  
--	https://learn.microsoft.com/en-us/training/modules/transform-data-by-implementing-pivot-unpivot-rollup-cube/
--	https://learn.microsoft.com/en-us/sql/t-sql/functions/functions?view=sql-server-ver16
--#########################################################################
--SQL SERVER JOINS

Create database Ecommerce
go
Use Ecommerce
go
-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);
go

INSERT INTO Customers (CustomerID, CustomerName)
VALUES
    (1, 'John Smith'),
    (2, 'Jane Doe'),
    (3, 'Alice Johnson'),
    (4, 'Bob Williams'),
    (15, 'Emily Brown'),
    (6, 'Michael Davis'),
    (17, 'Olivia Wilson'),
    (8, 'William Taylor'),
    (19, 'Sophia Martinez'),
    (10, 'Liam Anderson');

go
-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);
go

INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES
    (101, 1, '2023-08-01'),
    (102, 2, '2023-08-02'),
    (103, 3, '2023-08-03'),
    (104, 4, '2023-08-04'),
    (115, 5, '2023-08-05'),
    (106, 6, '2023-08-06'),
    (117, 7, '2023-08-07'),
    (108, 8, '2023-08-08'),
    (119, 9, '2023-08-09'),
    (110, 10, '2023-08-10');

go
-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);

go
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
    (501, 'Widget', 10.99),
    (502, 'Gadget', 24.99),
    (503, 'Accessory', 5.99),
    (504, 'Tool', 15.49),
    (515, 'Toy', 7.95),
    (506, 'Device', 49.99),
    (517, 'Appliance', 89.00),
    (508, 'Book', 12.50),
    (519, 'Clothing', 29.95),
    (510, 'Jewelry', 59.00);

go
-- Create OrderDetails table
CREATE TABLE OrderDetails (
    DetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT
);
go
INSERT INTO OrderDetails (DetailID, OrderID, ProductID, Quantity)
VALUES
    (1001, 101, 501, 3),
    (1002, 101, 502, 2),
    (1003, 102, 503, 5),
    (1004, 103, 504, 1),
    (1005, 104, 505, 2),
    (1006, 105, 506, 1),
    (1007, 106, 507, 1),
    (1008, 107, 508, 3),
    (1009, 108, 509, 2),
    (1010, 109, 510, 1);



Select top 1 * from Customers
Select top 1 * from Orders
Select top 1  * from OrderDetails
Select top 1 * from products

--###############################################
--Relationship 
	--Customers		-->Orders		 	Customerid
	--Orders		-->OrderDetails		Orderid
	--OrderDetails	-->products			productid	 
	--Customers		-->products			CustomerID-->OrderID-->ProductID 	
	   
--####################
/*SYNTAX Joins:
	SELECT columns
	FROM table1  JOIN table2 	ON table1.column = table2.column
	JOIN table3 	ON table1.column = table3.column
	JOIN table4 	ON table2.column = table4.column
*/ 
--###############################################
--inner join

	Select top 1 * from Customers
	Select top 1 * from Orders

	Select   * from 
	Customers inner join Orders on CustomerID=CustomerID
			
	Select   * from 
	Customers inner join Orders on Customers.CustomerID=Orders.CustomerID
			
	Select   * from 
	Customers as C inner join Orders as O on C.CustomerID=O.CustomerID
			
	Select   C.CustomerID,c.CustomerName from 
	Customers as C inner join Orders as O on C.CustomerID=O.CustomerID
					
	Select   C.* from 
	Customers as C inner join Orders as O on C.CustomerID=O.CustomerID
			
	Select   O.*  from 
	Customers as C inner join Orders as O on C.CustomerID=O.CustomerID

	Select   C.* , O.*  from 
	Customers as C inner join Orders as O on C.CustomerID=O.CustomerID
			

---Query (Cntrl +Shift +Q)

	SELECT O.OrderDate, C.CustomerName, O.OrderID, C.CustomerID
	FROM  Customers AS C INNER JOIN
	Orders AS O ON C.CustomerID = O.CustomerID

	Select   * from 
	Customers as C inner join Orders as O on C.CustomerID=O.orderid
			
--###############################################




	Select top 1 * from Customers
	Select top 1 * from Orders
	Select top 1  * from OrderDetails
	Select top 1 * from products

	Select  * from 
	Customers as C inner join Orders as O on C.CustomerID=O.CustomerID
	inner join OrderDetails as OD on o.OrderID=OD.OrderID


	
	Select  * from 
	Customers as C inner join Orders as O on C.CustomerID=O.CustomerID
	inner join OrderDetails as OD on o.OrderID=OD.OrderID
	inner join products as P on od.ProductID=p.ProductID
--###############################################
--Left outer join 
	
	Select  * from 
	Customers as C Left outer join  Orders as O on C.CustomerID=O.CustomerID

	Select  * from 
	Customers as C Left join  Orders as O on C.CustomerID=O.CustomerID

	Select  * from 
	Customers as C Left join Orders as O on C.CustomerID=O.CustomerID
	Left join OrderDetails as OD on o.OrderID=OD.OrderID

	
	Select  * from 
	Customers as C Left join Orders as O on C.CustomerID=O.CustomerID
	Left join OrderDetails as OD on o.OrderID=OD.OrderID
	Left join products as P on od.ProductID=p.ProductID

--Display the records of customers without order	
	Select  * from 
	Customers as C Left join  Orders as O on C.CustomerID=O.CustomerID
	where o.orderid is null


--###############################################
--Right outer join 
	
	
	Select  * from 
	Orders as O 	left outer join Customers as C  on C.CustomerID=O.CustomerID
	
	Select  * from 
	Customers as C Right outer join  Orders as O on C.CustomerID=O.CustomerID

	Select  * from 
	Customers as C Right join  Orders as O on C.CustomerID=O.CustomerID

	Select  * from 
	Customers as C Right join Orders as O on C.CustomerID=O.CustomerID
	Right join OrderDetails as OD on o.OrderID=OD.OrderID

	
	Select  * from 
	Customers as C Right join Orders as O on C.CustomerID=O.CustomerID
	Right join OrderDetails as OD on o.OrderID=OD.OrderID
	Right join products as P on od.ProductID=p.ProductID

--Display the records of order MISSING  customers INFO
	Select  * from 
	Customers as C Right join Orders as O on C.CustomerID=O.CustomerID
	where C.CustomerID is null



--###############################################
--Full outer join 
	
	
	Select  * from 
	Orders as O 	Full outer join Customers as C  on C.CustomerID=O.CustomerID
	
	Select  * from 
	Customers as C Full   join  Orders as O on C.CustomerID=O.CustomerID 

	Select  * from 
	Customers as C Full join Orders as O on C.CustomerID=O.CustomerID
	Full join OrderDetails as OD on o.OrderID=OD.OrderID

	
	Select  * from 
	Customers as C Full join Orders as O on C.CustomerID=O.CustomerID
	Full join OrderDetails as OD on o.OrderID=OD.OrderID
	Full join products as P on od.ProductID=p.ProductID

--Display the records of order without  customers  and customers without order
	Select  * from 
	Customers as C Full join Orders as O on C.CustomerID=O.CustomerID
	where C.CustomerID is null or O.CustomerID is null 

--Ecommerce
--find the tables within a database 
select * from information_schema.tables where tablename ='orders'

--find the columnname within a database 
select * from information_schema.columns where column_name ='CustomerName'


--################################################################################################
USE AdventureWorks2022
--Practice Question for AdventureWorks2022 database 
--1. Inner Join:
	-- Question: Write a query to retrieve the `BusinessEntityID`, `JobTitle`, `FirstName`, and `LastName` of 
	--all employees by joining the `HumanResources.Employee` and `Person.Person` tables on `BusinessEntityID`
	
	select * from information_schema.columns where column_name ='BusinessEntityID'

	SELECT  * FROM [HumanResources].[Employee]

	SELECT  * FROM [Person].[Person]

	SELECT E.BusinessEntityID,E.JobTitle,P.FirstName,P.LastName
	FROM HumanResources.Employee E
	INNER JOIN Person.Person  P
	ON E.BusinessEntityID = P.BusinessEntityID


--2. Left Join:
	--Question: Write a query to list all persons with their addresses, including those who do not have an 
	--address. Use the `Person.Person` table and the `Person.Address` table, joining on `BusinessEntityID`.

	SELECT  * FROM [Person].[Person]
	SELECT * FROM [Person].[Address]

	SELECT * FROM information_schema.columns where column_name='BusinessEntityID'

	SELECT P.BusinessEntityID,A.AddressLine1,A.AddressLine2
	FROM Person.Person P
	LEFT JOIN Person.Address A
	ON P.BusinessEntityID=A.AddressID


--3. Right Join:
	-- Question: Write a query to list all product reviews along with the names of the reviewers.
    --Include all reviews even if the reviewer s name is not available. 
	--Use the `Production.ProductReview` table and the `Person.Person` table, joining on 	`ReviewerID`.

	SELECT  * FROM [Person].[Person]
	SELECT  * FROM [Production].[ProductReview]

	SELECT Pr.*,P.*
	FROM Person.Person P
	RIGHT JOIN Production.ProductReview Pr
	ON P.BusinessEntityID = Pr.ProductReviewID
	

--4. Full Outer Join:
	--Question: Write a query to list all employees and their associated departments. 
	--Include employees without departments and departments without employees.
	 --Use the `HumanResources.Employee` and `HumanResources.Department` tables, joining on `DepartmentID`.

	SELECT  * FROM [HumanResources].[Employee]
	SELECT  * FROM [HumanResources].[Department]

	SELECT * FROM information_schema.columns WHERE column_Name = 'DepartmentID'

	SELECT E.*,D.*
	FROM HumanResources.Employee E
	FULL JOIN HumanResources.Department D
	ON E.BusinessEntityID = D.DepartmentID


--5. Join with Aggregates:
	--Question: Write a query to find the total sales amount for each sales person.
	 --Use the `Sales.SalesOrderHeader` and `Sales.SalesPerson` tables, joining on `SalesPersonID`.

	 SELECT * FROM [Sales].[SalesOrderHeader]
	 SELECT * FROM [Sales].[SalesPerson]

	SELECT SP.BusinessEntityID, SUM(SOH.TotalDue) AS TotalSales
	FROM Sales.SalesPerson SP
	INNER JOIN Sales.SalesOrderHeader SOH 
	ON SP.BusinessEntityID = SOH.SalesPersonID
	GROUP BY SP.BusinessEntityID
	ORDER BY TotalSales DESC;

--6. Join with Multiple Tables:
	--Question: Write a query to retrieve the `ProductID`, `Name`, `SalesOrderID`, and `OrderDate`
	 --for all sales orders. Use the `Sales.SalesOrderDetail`, `Production.Product`, and `Sales.SalesOrderHeader` 
	--tables, joining on `ProductID` and `SalesOrderID`.

	SELECT * FROM[Sales].[SalesOrderDetail]
	SELECT * FROM[Production].[Product]
	SELECT * FROM[Sales].[SalesOrderHeader]

	--ProductID -> SOD
	--Name -> PP
	--SalesOrderID -> SOD,SOH
	--OrderDate ->  SOH

	SELECT SOD.ProductID,SOD.SalesOrderID,SOH.SalesOrderID,PP.Name,SOH.OrderDate
	FROM Sales.SalesOrderDetail SOD
    INNER JOIN Production.Product PP
	ON SOD.ProductID = PP.ProductID
	INNER JOIN Sales.SalesOrderHeader SOH
	ON SOD.SalesOrderID = SOH.SalesOrderID
	ORDER BY SOH.OrderDate DESC;

--7. Join with Subquery:
	--Question: Write a query to find the names of employees who have placed an order. 
	
	SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='Name'

	SELECT * FROM[Person].[Person]
	SELECT * FROM[HumanResources].[Employee]













































































































