CREATE DATABASE [Solving Question 1]

USE [Solving Question 1]

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT );

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    LocationID INT,
    Email VARCHAR(100) );

CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50) );

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    SaleDate DATE,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalAmount DECIMAL(10,2) );

 
-- Insert into Product Table
INSERT INTO Product (ProductID, ProductName, Category, Price, StockQuantity) VALUES
(101, 'Laptop', 'Electronics', 1200.00, 50),
(102, 'Mouse', 'Accessories', 25.00, 200),
(103, 'Keyboard', 'Accessories', 45.00, 150),
(104, 'Monitor', 'Electronics', 300.00, 80);

-- Insert into Customer Table
INSERT INTO Customer (CustomerID, CustomerName, LocationID, Email) VALUES
(1001, 'Alice', 1, 'alice@example.com'),
(1002, 'Bob', 2, 'bob@example.com'),
(1003, 'Charlie', 3, 'charlie@example.com'),
(1004, 'David', 4, 'david@example.com');

-- Insert into Location Table
INSERT INTO Location (LocationID, City, State, Country) VALUES
(1, 'New York', 'NY', 'USA'),
(2, 'Los Angeles', 'CA', 'USA'),
(3, 'Chicago', 'IL', 'USA'),
(4, 'Houston', 'TX', 'USA');

-- Insert into Sales Table
INSERT INTO Sales (SaleID, ProductID, CustomerID, SaleDate, Quantity, UnitPrice, TotalAmount) VALUES
(1, 101, 1001, '2024-03-01', 2, 1200.00, 2400.00),
(2, 102, 1002, '2024-03-02', 3, 25.00, 75.00),
(3, 101, 1003, '2024-03-03', 1, 1200.00, 1200.00),
(4, 103, 1004, '2024-03-04', 5, 45.00, 225.00),
(5, 104, 1001, '2024-03-05', 2, 300.00, 600.00);

SELECT * FROM Product
SELECT * FROM Customer
SELECT * FROM Location
SELECT * FROM Sales

--1. Find the total revenue generated per product category

SELECT Category,SUM(StockQuantity * Price) AS Total_revenue
FROM Product
GROUP BY Category

--With joins
SELECT P.Category,SUM(S.TotalAmount) AS Total_Revenue
FROM Sales S
INNER JOIN Product P 
ON S.ProductID = P.ProductID
GROUP BY P.Category;


--2. Identify the top 3 highest spending customers

SELECT TOP 3 C.CustomerID,C.CustomerName,SUM(S.TotalAmount) AS Total_Spent
FROM Customer C
INNER JOIN Sales S
ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerID, C.CustomerName
ORDER BY Total_Spent DESC

--3. Rank customers based on their total purchase amount (using Window Function)

SELECT S.CustomerID,S.CustomerID,CustomerName,C.Email,SUM(S.TotalAmount) AS Purchase_Amount,
RANK() OVER(ORDER BY SUM(S.TotalAmount) DESC) AS Rnk
FROM Customer C
INNER JOIN Sales S
ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerID,S.CustomerID,CustomerName,C.Email
ORDER BY Rnk

--4. Find the product that has been sold the most

SELECT TOP 1 P.ProductID,P.ProductName,C.CustomerName,SUM(S.Quantity) AS Total_Quantity_Sold
FROM Product P
INNER JOIN Sales S
ON P.ProductID = S.ProductID
INNER JOIN Customer C
ON C.CustomerID = S.CustomerID
GROUP BY P.ProductID,P.ProductName,C.CustomerName
ORDER BY Total_Quantity_Sold DESC

--5. Find monthly sales trends (Using GROUPING SETS)

SELECT YEAR(SaleDate) AS Sale_Year,
	   MONTH(SaleDate) AS Sale_Month,
	   SUM(TotalAmount) AS Total_Sales
FROM Sales
GROUP BY GROUPING SETS (
        (YEAR(SaleDate), MONTH(SaleDate)),  
        (YEAR(SaleDate))                    
    )
ORDER BY 
    Sale_Year, Sale_Month;

--6. Identify which locations generate the highest revenue

SELECT L.LocationID,L.City,L.State,L.Country,SUM(S.Quantity * S.UnitPrice) AS Highest_Revenue
FROM Sales S
INNER JOIN Customer C
ON C.CustomerID = S.CustomerID
INNER JOIN Location L
ON L.LocationID = C.LocationID
GROUP BY L.LocationID,L.City,L.State,L.Country
ORDER BY Highest_Revenue DESC

--7. Predict future stock needs by finding products with low stock but high sales

SELECT P.ProductID,P.ProductName,P.StockQuantity,SUM(S.Quantity) AS Total_Sales
FROM Product P
INNER JOIN Sales S ON P.ProductID = S.ProductID
GROUP BY P.ProductID, P.ProductName, P.StockQuantity
HAVING P.StockQuantity < 250 AND SUM(S.Quantity) > 2      
ORDER BY P.StockQuantity ASC,Total_Sales DESC           

--8. Find customers who bought more than one product category
SELECT C.CustomerID,C.CustomerName,COUNT(DISTINCT P.Category) AS Category_Count
FROM Customer C
INNER JOIN Sales S ON C.CustomerID = S.CustomerID
INNER JOIN Product P ON S.ProductID = P.ProductID
GROUP BY C.CustomerID, C.CustomerName
HAVING COUNT(DISTINCT P.Category) > 2

--9. Identify the percentage of total revenue contributed by each product

SELECT P.ProductID,P.ProductName,SUM(S.TotalAmount) AS ProductRevenue,(SUM(S.TotalAmount) * 100.0) / (SELECT SUM(TotalAmount)
   FROM Sales) AS RevenuePercentage
FROM 
    Sales S
INNER JOIN 
    Product P ON S.ProductID = P.ProductID
GROUP BY 
    P.ProductID, P.ProductName
ORDER BY 
    RevenuePercentage DESC;

--10. Find customers who haven't purchased in the last 3 months

SELECT 
    C.CustomerID,
    C.CustomerName,
    C.Email
FROM 
    Customer C
LEFT JOIN 
    Sales S ON C.CustomerID = S.CustomerID 
    AND S.SaleDate > DATEADD(MONTH, -3, GETDATE())
GROUP BY 
    C.CustomerID, C.CustomerName, C.Email
HAVING 
    COUNT(S.SaleID) = 0;
