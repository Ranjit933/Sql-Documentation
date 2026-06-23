CREATE DATABASE Company

USE Company

/*
Company Name:- Indium Fiercely Independent

Problem Statement:- You are given a table named teams with a single column team_name that contains the following rows


input table: team                     output:-
-------------                         -----------
team_name                            CSK VS KKR
-------------                        GT VS KKR   
CSK                                  DC VS KKR
KKR                                  CSK VS GT
GT                                   DC VS GT
DC                                   CSK VS DC
LSG					                 CSK VS LGS				
									 KKR VS LGS
									 GT VS LGS
									 DC VS LGS
									------------								
Constraints:-
1. Each pair should appear only one (e.g."CSK VS KKR" is valid, but "KKR VS CSK" should not appear again).

2. A team should not be matched with itself (e.g, "CSK  VS "CSK" is invalid)

Question:- Write a sql query to generate combination between the team_1 vs team_2

*/

CREATE TABLE Team(Team_Name VARCHAR(10));

INSERT INTO Team  VALUES('CSK'),('KKR'),('GT'),('DC'),('LGS');

SELECT * FROM Team;

SELECT CONCAT(T1.Team_Name,' VS ',T2.Team_Name) AS Matches
FROM Team T1
JOIN Team T2
ON T1.Team_Name < T2.Team_Name;


/*
Company:- EY
Find avg month revenue from each sector

Table 1. Transactions
--------------------------------------------------------------
Transaction_ID,   company_id,   transaction_date,  revenue
--------------------------------------------------------------
101                1            2020-01-15         5000
102                2            2020-01-20         8500
103                1            2020-02-10         4500
104                3            2020-02-20         9900
105                2            2020-02-25         7500

Table 2. Sectors
------------------------
company_id,     sector
------------------------
1              Technology
2              Healthcare
3              Technology

Question:- Write a sql query that calculates the average monthly revenue for each sector in the year 2020

The output should show the average revenue for each sector for every month allowing the company performed to see how each sector performed financially
month by month

output Table:-
--------------------------------
Month,   sector,    Avg_revenue
--------------------------------
1       Healthcare    8500
1       Technology    5000
2       Healthcare    7500
2       Technology    7200
---------------------------------
*/

CREATE TABLE Transactions(
						  Transaction_ID INT, 
						  Company_ID INT, 
						  Transaction_Date DATE, 
						  Revenue INT
						  );

INSERT INTO Transactions VALUES(101,1,'2020-01-15',5000),(102,2,'2020-01-10',8500),(103,1,'2020-02-20',4500),(104,3,'2020-02-20',9900),(105,2,'2020-02-25',7500);

CREATE TABLE Sectors(Company_ID INT, Sectore VARCHAR(20));

INSERT INTO Sectors VALUES(1,'Technology'),(2,'Health Care'),(3,'Technology');

SELECT * FROM Transactions;

SELECT * FROM Sectors;

SELECT MONTH(T.Transaction_Date) AS Months,S.Sectore,AVG(T.Revenue) AS Avg_revenue
FROM Transactions T
INNER JOIN Sectors S ON T.Company_ID = S.Company_ID
WHERE YEAR(T.Transaction_Date) = 2020
GROUP BY MONTH(T.Transaction_Date),S.Sectore
ORDER BY Months;



--Solution 2 with CTE

WITH Monthly 
AS(
SELECT T.Company_ID,MONTH(T.Transaction_Date) AS Months,AVG(T.Revenue) AS MonthlyRevenue 
FROM Transactions T
WHERE YEAR(Transaction_Date) = 2020
GROUP BY T.Company_ID, MONTH(T.Transaction_Date)
)

SELECT M.Months,S.Sectore,AVG(MonthlyRevenue) AS AvgMonthlyRevenue
FROM Monthly  M
JOIN Sectors S 
ON M.Company_ID = S.Company_ID
GROUP BY M.Months, S.Sectore
ORDER BY M.Months, S.Sectore;

/*
Company Name:- Zomato
Swapped order details

Imagine Zomato encountered an issue where each order's item was mistakely swapped with the next one. Our task as data analyst is to fix this error and 
ensure that every order_id is paired with the correct item.

If the last item has an odd order_id, it should remain as the last item in the corrected data

Input Table:-- Orders

-------------------------------------------------------------
Order_ID,        Item
-------------------------------------------------------------
1                Chow Mein
2                Pizza
3                Veg Nuggets
4                Panner Butter masala
5                Spring Rolls
6                Veg Burger
7                Panner Tikka
-------------------------------------------------------------

Output Table
-------------------------------------------------------------
Corrected_order_Id,          Item
-------------------------------------------------------------
1                           Pizza
2                           Chow Mein
3                           Panner Butter masala
4                           Veg Nuggets
5                           Veg Burger
6                           Spring Rolls
7                           Panner Tikka
-------------------------------------------------------------

*/

CREATE TABLE Orders(Order_ID INT PRIMARY KEY, Item VARCHAR(30));

ALTER TABLE Orders
ALTER COLUMN Order_ID INT NOT NULL;

ALTER TABLE Orders
ADD CONSTRAINT PK_ID PRIMARY KEY(Order_ID);

INSERT INTO Orders VALUES(1,'Chow Mein'),(2,'Pizza'),(3,'Veg Nuggets'),(4,'Panner Butter masala'),(5,'Spring Rolls'),(6,'Veg Burger'),(7,'Panner Tikka');

SELECT * FROM Orders;

WITH Order_Counts
AS(
SELECT COUNT(Order_ID) AS Total_orders
FROM Orders
)
SELECT 
	  CASE
		 WHEN O.Order_ID % 2 != 0 AND O.Order_ID != OC.Total_orders THEN O.Order_ID + 1
		 WHEN O.Order_ID % 2 != 0 AND O.Order_ID = OC.Total_orders THEN O.Order_ID
		ELSE O.Order_ID - 1
	END Corrected_Order_Id,
	P.Item
FROM Orders O
CROSS JOIN Order_Counts OC
JOIN Orders P
ON P.Order_ID = CASE	
					WHEN O.Order_ID % 2 != 0 AND O.Order_ID != OC.Total_orders THEN O.Order_ID + 1
					WHEN O.Order_ID % 2 != 0 AND O.Order_ID = OC.Total_orders THEN O.Order_ID 
				ELSE O.Order_ID - 1
			END
ORDER BY O.Order_ID;



/*

Company Name: Amazon

Question:- Find the top 2 Highest selling products each category

You're given dates about amazon customers the products they purchased and their spending

Table: Product_Spent
--------------------------------------------------------------
Category,       Products,         User_ID,      Spend
--------------------------------------------------------------
Appliance      Refrigerator        165             26
Appliance      Refrigerator        123             3
Appliance      Washing Machine     123            19.8
Electronics    Vaccum              178             5
Electronics    Wirless Headset     156             7
Electronics    Vaccum              145             15
Electronics    Laptop              114             999.99
Fashion        Dress               117             49.49
Groceries      Milk                243             2.99
Groceries      Bread               645             1.99
Home           Furniture           276             599.99
Home           Decore              456             29.99


Output Table
--------------------------------------------------------------
Category         Products               Total_Spend
--------------------------------------------------------------
Appliance       Refrigerator            29
Appliance       Washing Machine         19.8
Electronics     Laptop                  999.99
Electronics     Vaccum                  20
Fashion         Dress                  49.99
Groceries       Milk                   2.99
Groceries       Bread                  1.99
Home            Furniture              599.99
Home            Furniture              29.99
--------------------------------------------------------------
*/

CREATE TABLE Product_Spent(Category VARCHAR(30),Products VARCHAR(20),User_ID INT, Spend  FLOAT);

INSERT INTO Product_Spent VALUES('Appliance','Refrigerator',165,26),('Appliance','Refrigerator',123,3),('Appliance','Washing Machine',123,19.8),
								('Electronics', 'Vaccum',178,5),('Electronics','Wirless Headset',156,7),('Electronics','Vaccum', 145,15),
								('Electronics','Laptop',114,999.99),('Fashion','Dress',117,49.49),('Groceries','Milk',243, 2.99),
								('Groceries', 'Bread',645,1.99),('Home','Furniture',276,599.99),('Home','Decore',456,29.99);

SELECT * FROM Product_Spent;

-- Using CTE
WITH Ranked_spending
AS(
SELECT Category,Products,SUM(Spend) AS Total_Spent,
												RANK() OVER(PARTITION BY Category ORDER BY SUM(Spend) DESC) AS RNK
FROM Product_Spent
GROUP BY Category,Products
)
SELECT Category,Products,Total_Spent
FROM Ranked_spending
WHERE RNK <= 2;

-- Using Sub-Quary


SELECT Category,Products,Total_Spent
FROM
(
SELECT Category,Products,SUM(Spend) AS Total_Spent,
												RANK() OVER(PARTITION BY Category ORDER BY SUM(Spend) DESC) AS RNK
FROM Product_Spent
GROUP BY Category,Products
) T
WHERE RNK <= 2;

/*

Company Name:- JPMorgan Chase & Co 

Problem Statement:- The capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times return the 
result table ordered by capital_gain_loss column in descending orders.

Input Table:- Stocks
-----------------------------------------------------------------------------------------------
stock_name,           Operation              Operation_day,                  Price
-----------------------------------------------------------------------------------------------
Apple                 Buy                       1                            1500
Tesla                 Buy                       2                            1200
Apple                 Sell                      5                            5000
Samsung               Buy                       17                           20000
Tesla                 Sell                      3                            1300
Tesla                 Buy                       4                            1500
Tesla                 Sell                      5                            1100
Tesla                 Buy                       6                            1400
Samsung               Sell                      29                           15000
Tesla                 Sell                      10                           1200
-----------------------------------------------------------------------------------------------

Output Table: stocks
----------------------------------------------
Stock_Name          Capital_gain_loss
----------------------------------------------
Apple                 3500
Tesla                 -500
Sumsung               -5000
----------------------------------------------


Question:- Write a sql query to report the capital gain/loss for each stock.

Logic Behind this:-

Apple ---> bought at 1500 (Day 1), sold at 5000 (Day 5)---> Profit = 5000-1500 = 3500

Tesla ----> Multiple Trades.

Buy 1200 ----> Sell 1300 ---> Profit = +100
Buy 1500 ----> Sell 1100 ----> Loss = -400
Buy 1400 ----> Sell 1200 ----> Loss = -200

Sumsung --> Buy 20000 ---> Sell 15000 ----> Loss = -5000
*/

--Approach 1 --> ROW_NUMBER()
--STEP 1:-> Give row numbers separetly to buy and sell transactions
--STEP 2:-> Match each buy with corresponding sell by ROW_NUMBER()
--STEP 3:-> Aggregate Profit/loss for each stock

CREATE TABLE Stocks(
					Stock_name VARCHAR(20),
					Operation VARCHAR(10),
					Opeartion_Day INT,
					Price INT
					);

INSERT INTO Stocks VALUES('Apple','Buy',1,1500),('Tesla','Buy',2,1200),('Apple','Sell',5,5000),('Samsung','Buy',17,20000),
('Tesla','Sell',3,1300),('Tesla','Buy',4,1500),('Tesla','Sell',5,1100),('Tesla','Buy',6,1400),('Samsung','Sell',29,15000),('Tesla','Sell',10,1200);

SELECT * FROM Stocks;

--1.CTE Approach

WITH Profit_Loss
AS(
SELECT Stock_name,Operation,Opeartion_Day,Price,
											ROW_NUMBER() OVER(PARTITION BY Stock_name,Operation ORDER BY Opeartion_day) AS RWN
FROM Stocks
),   
Paired 
AS(
SELECT P.Stock_name,(S.price - P.Price) AS Gain_Loss
FROM Profit_Loss P
JOIN Profit_Loss S ON P.Stock_name = S.Stock_name AND P.RWN = S.RWN AND P.Operation = 'Buy' AND S.Operation = 'Sell'
)

SELECT Stock_name,SUM(Gain_Loss) AS Capital_gain_loss
FROM Paired
GROUP BY Stock_name
ORDER BY Capital_gain_loss DESC;

----------------------------------------------------------------
--2.Another CTE Approach

WITH Buy_Orders
AS(
SELECT Stock_name,Operation,Opeartion_Day,Price,
										ROW_NUMBER() OVER(PARTITION BY Stock_name,Operation ORDER BY Opeartion_Day) AS RWN
FROM Stocks
WHERE Operation = 'Buy'
),
Sell_Orders
AS(
SELECT Stock_name,Operation,Opeartion_Day,Price,
										ROW_NUMBER() OVER(PARTITION BY Stock_name,Operation ORDER BY Opeartion_Day) AS RWN
FROM Stocks
WHERE Operation = 'Sell'
),
Paired AS(
SELECT b.Stock_name, (S.Price - b.Price) AS Gain_Loss
FROM Buy_Orders b
JOIN Sell_Orders S
ON b.Stock_name = S.Stock_name AND b.RWN = S.RWN
)

SELECT Stock_name, SUM(Gain_Loss) AS Capital_gain_loss
FROM Paired
Group BY Stock_name
ORDER BY Capital_gain_loss DESC;

------------------------------------------------------------------------------------------------------
-- Method 2 --> Using LEAD()
--Step 1--> Using ROW_NUMBER() to order all transaction per stock
--Step 2---> Using LEAD() to find next transaction
--Step 3 --> Build buy all pairs
--Step 4 ---> Calculate gain_loss
---Step 5 ---> Aggegate the result

WITH Ordered 
AS(
SELECT Stock_name,Operation,Opeartion_Day,Price,
											ROW_NUMBER() OVER(PARTITION BY Stock_name,Operation ORDER BY Opeartion_day) AS RWN
FROM Stocks
),
Pairs AS(
SELECT Stock_name,Price AS Buy_Price,Operation, LEAD(Price) OVER(PARTITION BY Stock_name ORDER BY Opeartion_day) AS Sell_Price
FROM Ordered
)

SELECT Stock_name,SUM(Sell_Price - Buy_price) AS Capital_gain_loss
FROM Pairs
WHERE Operation = 'Buy'
GROUP BY Stock_name
ORDER BY Capital_gain_loss DESC;

------------------------------------------------------------------------------------------------------
--Method 3:- Using CASE

SELECT Stock_name,SUM(
				CASE 
					WHEN Operation = 'Buy' THEN -1 * Price
					WHEN Operation = 'Sell' THEN Price
					END 
					)AS Capital_gain_loss
FROM Stocks
GROUP BY Stock_name
ORDER BY Capital_gain_loss DESC;

/*

Company Name:- Volkswagen
Pivot Basket Data

Problem Statement:- You are given table named baskets with following schema

Baskets(Person VARCHAR, Basket VARCHAR)

Each row contains a person's name and a comma - separated list of fruits in their basket

Input Table:- Baskets
---------------------------------------
Person,        Basket
---------------------------------------
A              Apple, Mango,Orange
B              Apple
C              Guava, Cherry
D              Mango, Cherry, Orange
---------------------------------------


Output Table:- Baskets
---------------------------------------
Person,      Apple,    Mango,    Orange,   Guava,    Cherry
--------------------------------------------------------------
A            Yes       Yes       Yes       No        No
B            Yes       No        No        No        No
C            No        No        No        Yes       Yes
D            No        Yes       Yes       No        Yes
--------------------------------------------------------------

Question:- Write a sql query to transform the data so that each fruits be comes it's own column (Apple, Mango, Orange, Guava, Cherry) and the value
should be 'yes' if the person has that fruit in their basket, otherwise 'No'.
*/

CREATE TABLE Baskets(
				   Person VARCHAR(10),
				   Basket VARCHAR(100)
				   );

INSERT INTO Baskets VALUES('A','Apple,Mango,Orange'),('B','Apple'),('C','Guava,Cherry'),('D','Mango,Cherry,Orange');

SELECT * FROM Baskets;

-- Method 1
SELECT Person,
			CASE WHEN Basket LIKE '%Apple%' THEN 'YES' ELSE 'NO' END AS Apple,
			CASE WHEN Basket LIKE '%Mango%' THEN 'YES' ELSE 'NO' END AS Mango,
			CASE WHEN Basket LIKE '%Orange%' THEN 'YES' ELSE 'NO' END AS Orange,
			CASE WHEN Basket LIKE '%Guava%' THEN 'YES' ELSE 'NO' END AS Guava,
			CASE WHEN Basket LIKE '%Cherry%' THEN 'YES' ELSE 'NO' END AS Cherry
FROM Baskets;

--Method 2

SELECT Person,
       CASE WHEN CHARINDEX('Apple', Basket) > 0 THEN 'Yes' ELSE 'No' END AS Apple,
       CASE WHEN CHARINDEX('Mango', Basket) > 0 THEN 'Yes' ELSE 'No' END AS Mango,
       CASE WHEN CHARINDEX('Orange', Basket) > 0 THEN 'Yes' ELSE 'No' END AS Orange,
       CASE WHEN CHARINDEX('Guava', Basket) > 0 THEN 'Yes' ELSE 'No' END AS Guava,
       CASE WHEN CHARINDEX('Cherry', Basket) > 0 THEN 'Yes' ELSE 'No' END AS Cherry
FROM Baskets;

/*
Problem: Restaurant Growth calculation

Assume that you are a resturnat owner and you want to analyze a possible expansion there will be at least one customer every day.

Question:- Write a query to calculate the moving average of how much the customer paid in a 7 days window(i,e, current day + 6 days before). 
Return table  ordered by visited-on in ascending order and the average_amount should be rounded to two decimal/places.

Input Table:- Customer
--------------------------------------------------------------
Customer_ID      Name         Visited_On         Amount
--------------------------------------------------------------
1               Jhon          2019-01-01         100
2               Daniel        2019-01-02         110
3               Jade          2019-01-03         120
4               Khalid        2019-01-04         130
5               Winston       2019-01-05         110
6               Elvis         2019-01-06         140
7               Anna          2019-01-07         150
8               Maria         2019-01-08         80
9               Jhon          2019-01-10         130
3               Jade          2019-01-10         150
------------------------------------------------------------

Output Table Customer
----------------------------------------------------
Visited_on         Amount            Avg_Amount
----------------------------------------------------
2019-01-07         860               122.86
2019-01-08         840               120
2019-01-09         840               120
2019-01-10         1000              142.86
----------------------------------------------------
*/

CREATE TABLE Customer(
					 Customer_ID INT,
					 Name VARCHAR(20),
					 Visited_on DATE,
					 Amount INT
					 );

INSERT INTO Customer VALUES(1,'Jhon','2019-01-01',100),(2,'Daniel','2019-01-02',110),(3,'Jade','2019-01-03',120),(4,'Khalid','2019-01-04',130),
(5,'Winston','2019-01-05',110),(6,'Elvis','2019-01-06',140),(7,'Anna','2019-01-07',150),(8,'Maria','2019-01-08',80),(9,'Jhon','2019-01-10',130),
(3,'Jade','2019-01-10',150);

SELECT * FROM Customer;

WITH CTE AS (
    SELECT Visited_on, SUM(Amount) AS Total_Amount
    FROM Customer
    GROUP BY Visited_on
),
Rolling AS (
    SELECT Visited_on,
           SUM(Total_Amount) OVER(ORDER BY Visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS Seven_day_rolling_sum,
           CAST(ROUND(AVG(Total_Amount) OVER(ORDER BY Visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS DECIMAL(10,2)) AS Seven_day_rolling_Avg,
           ROW_NUMBER() OVER(ORDER BY Visited_on) AS rn
    FROM CTE
)
SELECT Visited_on, Seven_day_rolling_sum, Seven_day_rolling_Avg
FROM Rolling
WHERE rn >= 7
ORDER BY Visited_on;

/*
Sandwich Pattern Problem

Problem Statement:- You're given table named Num with two columns-SN representing the series number and NumB, the numeric value.

Find all unique values in Numb that form a 'standwich pattern'. In other words the same value should appear at rows i and i+2, while the row in between -- 
that is i+1-- should contain a different value.

Input table:- Num
-----------------------
SN             NumB
1               4
2               7
3               4
4               9
5               9
6               7
7               9
8               4
-----------------------

Output Table: Num
-----------------------
4
9
-----------------------
*/

CREATE TABLE Num(
				SN INT, 
				NumB INT
				);

INSERT INTO Num VALUES(1,4),(2,7),(3,4),(4,9),(5,9),(6,7),(7,9),(8,4);


SELECT * FROM Num;

SELECT A.NumB
FROM Num A
JOIN Num B 
ON A.SN + 1 = B.SN
JOIN Num C
ON A.SN + 2 = C.SN
WHERE A.NumB = C.NumB AND A.NumB != B.NumB;

/*
Find users with above-average conversion probability

You are given A/B testing dataset. Each row represents a user's interaction, wheather they where shown a variant and wheather they converted.

Your task: Calculate the conversion rate(Probability) for each variant(A and B) and list users who had a higher probability of converting based on their 
variant, compared to the overall average conversion rate.

Input table: Ab_Test
-----------------------------------------
User_id     varient          converted
-----------------------------------------
1             A                 1          
2             A                 0            
3             A                 1
4             A                 0
5             B                 1
6             B                 1
7             B                 1
8             B                 0
-----------------------------------------

Converted:- 1 (Yes), 0(No)

Output Table:Ab_Test
-------------------------------------------------------------------------------------------
User_ID         Varient          Varient_conversion_rate        Overall_conversion_rate
-------------------------------------------------------------------------------------------
5                 B                   0.75                          0.625 --> (round(0.63))
6                 B                   0.75                          0.625 --> (round(0.63))
7                 B                   0.75                          0.625 --> (round(0.63))
8                 B                   0.75                          0.625 --> (round(0.63))
-------------------------------------------------------------------------------------------

Our gaol is to:
1. Calculate the overall conversion rate across all users.
2. Calculate the conversion rate of each varient(A and B)
3. Return the list of users who where part of varient the performed better than overall average.

1. Calculate the overall conversion rate

Conversion rate = Total Conversion / Toyal Users

Overall Conversion rate = 5/8 
						= 0.625

2. Calculate the conversion rate by variant

Variant A:
      Users: 1,2,3,4 --> Converted: 1 and 3 ----> 2 conversion
	  conversion rate = 2/4 
					  = 0.5

Variant B:
		 Users: 5,6,7,8 --> Converted: 5,6,7 ----> 3 conversion
	     conversion rate = 3/4 
					    = 0.75
*/

CREATE TABLE Ab_Test(
					User_id INT PRIMARY KEY,
					variant VARCHAR(5),
					converted INT
					);

INSERT INTO Ab_Test VALUES(1,'A',1),(2,'A',0),(3,'A',1),(4,'A',0),(5,'B',1),(6,'B',1),(7,'B',1),(8,'B',0);

SELECT * FROM Ab_Test;

WITH Overall
AS(
SELECT CAST(ROUND(SUM(converted) * 1.0 / COUNT(*),2) AS DECIMAL(10,2)) AS Overall_Conversion_rate
FROM Ab_Test
),
Variant_rate
AS(
SELECT variant,CAST(ROUND(SUM(converted) * 1.0 / COUNT(*),2) AS DECIMAL(10,2)) AS Variant_Conversion_rate
FROM Ab_Test
GROUP BY variant
)

SELECT A.User_id,A.variant, VR.Variant_Conversion_rate,O.Overall_Conversion_rate
FROM Ab_Test A
JOIN Variant_rate VR
ON A.variant = VR.variant
CROSS JOIN Overall O
WHERE VR.Variant_Conversion_rate > O.Overall_Conversion_rate;

/*
Company:-  JPMorgan Chase & Co 

Card Issued Difference

Your team at JPMorgan Chase & Co is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards
where issued each month

Question:- Write a query that output the name of each credit card and the difference in the month with the highest issuance cards and the lowest issuance.
Arrange the result based on the largest dispurity.

Input Table:- Monthly_Card_issued
--------------------------------------------------------------------------------------
Card_Name                   Issued_Amount          Issued_Month      Issued_Year
--------------------------------------------------------------------------------------
Chase Freedom Flex          55000                    1                 2021
Chase Freedom Flex          60000                    2                 2021
Chase Freedom Flex          65000                    3                 2021
Chase Freedom Flex          70000                    4                 2021
Chase Supphire Reserve      170000                   1                 2021
Chase Supphire Reserve      175000                   2                 2021
Chase Supphire Reserve      180000                   3                 2021
--------------------------------------------------------------------------------------

Output Table:- Monthly_Card_issued
--------------------------------------------
Card_Name                   Difference
--------------------------------------------
Chase Freedom Flex           15000
Chase Supphire Reserve       10000
--------------------------------------------
*/

CREATE TABLE Monthly_Card_issued(
								Card_Name VARCHAR(30),
								Issued_Amount INT,
								Issued_Month INT,
								Issued_Year INT
								);

INSERT INTO Monthly_Card_issued VALUES('Chase Freedom Flex',55000,1,2021),('Chase Freedom Flex',60000,2,2021),('Chase Freedom Flex',65000,3, 2021),
('Chase Freedom Flex',70000,4,2021),('Chase Supphire Reserve',170000,1,2021),('Chase Supphire Reserve',175000,2,2021),('Chase Supphire Reserve',180000,3,2021)


SELECT * FROM Monthly_Card_issued;

SELECT Card_Name,MAX(Issued_Amount) - MIN(Issued_Amount) AS Differences
FROM Monthly_Card_issued
GROUP BY Card_Name
ORDER BY Differences DESC;

/*
Company:- American Express

Calculate the average transaction Amount per year

You are an analyst at American Express, and you have a database table named transaction which contains the transaction data of users.

Input Table:- Transactions
----------------------------------------------------------------------------
Transaction_ID          User_ID       Transaction_Date         Amount
----------------------------------------------------------------------------
1                       269           08/15/2018               500
2                       478           11/25/2018               400
3                       269           01/05/2019               1000
4                       123           10/10/2020               600
5                       478           07/05/2021               700
6                       123           03/05/2022               900
----------------------------------------------------------------------------

Output Table:- Transactions
------------------------------------------------------------
Year         User_ID          Avg_transaction_amount
------------------------------------------------------------
2018          269              500
2018          478              400
2019          269              1000
2020          123              600
2021          478              700
2022          123              900
------------------------------------------------------------
Question:- Write a sql query to calculate the average transaction amount per year for each client, where the years ar in range of 2018 to 2022.
*/

CREATE TABLE Transactionss(
					     Transaction_ID INT PRIMARY KEY NOT NULL,
						 User_ID INT NOT NULL,
						 Transaction_Date DATE NOT NULL,
						 Amount INT NOT NULL
						 );

INSERT INTO Transactionss VALUES(1,269,'08-15-2018',500),(2,478,'11-25-2018',400),(3,269,'01-05-02019',1000),(4,123,'10-10-2020',600),
(5,478,'07-05-2021',700),(6,123,'03-05-2022',900);

SELECT * FROM Transactionss;

SELECT YEAR(Transaction_Date) AS Years,User_ID,AVG(Amount) AS Avg_transaction_amount
FROM Transactionss
WHERE YEAR(Transaction_Date) BETWEEN 2018 AND 2022 
GROUP BY YEAR(Transaction_Date),User_ID
ORDER BY Years ASC;


/*
Company:- Meesho

Find 3-Month moving Average

Table: Customer
-----------------------------------------------------
Customer_ID         Name              Join_Date
-----------------------------------------------------
1                  John                2023-01-10
2                  Simmy               2023-02-15
3                  lris                2023-03-20
-----------------------------------------------------

Table:- Orders
--------------------------------------------------------------------
Order_ID           Customer_ID         Order_Date         Amount
--------------------------------------------------------------------
1                    1                  2023-01-05        100
2                    2                  2023-02-14        150
3                    1                  2023-02-28        200
4                    3                  2023-03-22        300
5                    2                  2023-04-10        250
6                    1                  2023-05-15        400
7                    3                  2023-06-10        350
--------------------------------------------------------------------


Question:- your task is to calculate the 3- month moving average of sales revenue for each month, using the sales data in the ordes table.

The moving average should start calculating ionce three months of data are available, providing insight into average sales trends overtime.

Output Table
---------------------------------------------------------------
Month           Monthly_sales           moving_Avg_sales
---------------------------------------------------------------
2023-01          100                     100
2023-02          350                     225
2023-03          300                     250
2023-04          250                     300
2023-05          400                     316.67
2023-06          350                     333.33
---------------------------------------------------------------

3 - month moving average = Revenue of current month + Revenue of previous month + Revenue of month before previous month / 3

March 2023:- Average of January, February and March
		 = (100 + 350 + 300) / 3 = 250

April 2023:- Average of February, March and April 
		  = (350 + 300 + 250) / 3 = 300

May 2023:- Average of MArch, April and May
         = (300 + 250 + 400) / 3 = 316.67

June 2023:- Average of April, May and June
         = (250 + 400 + 350) / 3 = 333.33
*/

CREATE TABLE Customers(
					 Customer_ID INT PRIMARY KEY NOT NULL,        
					 Name VARCHAR(20) NOT NULL,
					 Join_Date DATE NOT NULL
					 );

INSERT INTO Customers VALUES(1,'John','2023-01-10'),(2,'Simmy','2023-02-15'),(3,'lris','2023-03-20');

CREATE TABLE Orderss(
				Order_ID INT PRIMARY KEY NOT NULL,
				Customer_ID INT NOT NULL,
				Order_Date DATE NOT NULL,
				Amount INT NOT NULL,
				CONSTRAINT PK_orders_Customers FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
				);

INSERT INTO Orderss VALUES(1,1,'2023-01-05',100),(2,2,'2023-02-14',150),(3,1,'2023-02-28',200),(4,3,'2023-03-22',300),(5,2,'2023-04-10',250),
(6,1,'2023-05-15',400),(7,3,'2023-06-10',350);

SELECT * FROM Customers

SELECT * FROM Orderss

WITH Monthly_Sales
AS(
SELECT FORMAT(Order_Date, 'yyyy-MM') AS Months,SUM(Amount) AS Monthly_total_sales
FROM Orderss
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
)

SELECT Months, Monthly_total_sales, AVG(Monthly_total_sales) OVER(ORDER BY Months ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_avg_sales
FROM Monthly_Sales
ORDER BY Months


/*
Company:- Walmart

Department Manager Counts

Input Table:- Employees
-------------------------------------------------------------------
ID        Name          Department           ManagerID
-------------------------------------------------------------------
1         John           HR                   Null
2         Bob            HR                    1
3         Olivia         HR                    1
4         Emma           Finance              Null
5         Sophia         HR                    1 
6         Mason          Finance               4
7         Ethan          HR                    1
8         Ava            HR                    1
9         Lucas          HR                    1
10        Isabella       Finance               4
11        Harper         Finance               4
12        Hemla          HR                    3
13        Aisha          HR                    2
14        Himani         HR                    2
15        Lily           HR                    2
-------------------------------------------------------------------

Question:- Write a sql query to find the names of a managers who directly manage at least five employee in the same department

Return the department name and the total number of direct report for each manager.

Note:- Ensure that only employees from departments with more than 10 total employees are considered in your query.

Output Table:- Employees
---------------------------------------------------------
Manager_Name       Department         Direct_Reports
---------------------------------------------------------
John                   HR                  6
---------------------------------------------------------
*/

CREATE TABLE Employees(
					  ID INT PRIMARY KEY NOT NULL,
					  Name VARCHAR(20) NOT NULL,
					  Department VARCHAR(10),
					  ManagerID INT
						)

INSERT INTO Employees VALUES(1,'John','HR',Null),(2,'Bob','HR',1),(3,'Olivia','HR',1),(4,'Emma','Finance',Null),(5,'Sophia','HR',1 ),(6,'Mason','Finance',4),
(7,'Ethan','HR',1),(8,'Ava','HR',1),(9,'Lucas','HR',1),(10,'Isabella','Finance',4),(11,'Harper','Finance',4),(12,'Hemla','HR',3),
(13,'Aisha','HR ',2),(14,'Himani','HR',2),(15,'Lily','HR',2);

SELECT * FROM Employees

SELECT M.Name AS Manager_Name, M.Department,COUNT(E.ID) AS Direct_Report
FROM Employees M
JOIN Employees E
ON M.ID = E.ManagerID AND M.Department = E.Department
GROUP BY M.Name,M.Department,M.ID
HAVING COUNT(M.ID)>=5


SELECT M.Name,M.Department,COUNT(E.ID) AS Direct_Report
FROM Employees M
JOIN Employees E
ON M.ID = E.ManagerID AND M.Department = E.Department
JOIN(
	SELECT Department,COUNT(ID) AS Total_Employees
	FROM Employees
	GROUP BY Department
	HAVING COUNT(ID) > 10
	)D
ON M.Department = D.Department
GROUP BY M.ID, M.Name,M.Department
HAVING COUNT(E.ID)>=5

/*
Company:- Indium Make Technology Work

Find The Consecutive Number

Input Table: logs
-----------------------------------
ID               Num
-----------------------------------
1                 1
2                 1
3                 1
4                 2
5                 1
6                 2
7                 2
----------------------------------

Question:- Write a sql query to find all numbers that appear at least three times consecutivey
*/

CREATE TABLE logs(
				 ID INT PRIMARY KEY NOT NULL,
				 Num INT NOT NULL
					)
					
INSERT INTO logs VALUES(1,1),(2,1),(3,1),(4,2),(5,1),(6,2),(7,2)

SELECT * FROM logs

SELECT DISTINCT L1.Num AS Consecutive_nums 
FROM logs L1,logs l2, logs l3
WHERE L1.ID = L2.ID - 1 AND L2.ID = L3.ID - 1 AND L1.Num = L2.Num AND L3.Num = L3.Num


--With CTE

WITH Consecutive 
AS(
SELECT ID,Num,
			LAG(Num,1) OVER(ORDER BY ID) AS Prev1,
			LAG(Num,2) OVER(ORDER BY ID) AS Prev2
FROM logs
)
SELECT DISTINCT Num AS Consecutive_nums 
FROM Consecutive
WHERE Num = Prev1 AND Num = Prev2

/*
Company:- Mckinsey & Company

Find the net present value(NPV) for quaries

Input Table 1: NPV
---------------------------
ID       Year        NPV
---------------------------
1        2018        100
7        2020        30
13       2019        40
1        2019        113
2        2008        121
3        2009        12
11       2020        99
7        2019        0
---------------------------

Input Table 2:- Quaries
---------------------------
ID             Year
---------------------------
1               2019
2               2008
3               2009
7               2018
7               2019
7               2020
13              2019
---------------------------

Question:- Find the NPV of each query from the queries table. Return the output order by ID and year in the ascending order.

Note: If no NPV is available for a particular combination in the NPV table, assign a 0 Value of instance.

Output Table
---------------------------
ID       Year        NPV
---------------------------
1       2019         113
2       2008         121
3       2009         12
7       2018         0
7       2019         0
7       2020         30
13      2019         40
---------------------------
*/

CREATE TABLE NPV(
				ID INT NOT NULL,
				Year INT NOT NULL,
				NPV INT NOT NULL
				)

INSERT INTO NPV VALUES(1,2018,100),(7,2020,30),(13,2019,40),(1,2019,113),(2,2008,121),(3,2009,12),(11,2020,99),(7,2019,0)

CREATE TABLE Quaries(
					ID INT NOT NULL,
					Year INT NOT NULL
					)

INSERT INTO Quaries VALUES(1,2019),(2,2008),(3,2009),(7,2018),(7,2019),(7,2020),(13,2019)

SELECT * FROM NPV
SELECT * FROM Quaries


SELECT Q.*, ISNULL(N.NPV,0) AS NPV
FROM Quaries Q
LEFT JOIN NPV N
ON N.ID = Q.ID AND N.Year = Q.Year
ORDER BY ID,Year ASC;

--Using case statement

SELECT ID_1 AS ID, Year_1 AS Year,
			CASE 
				WHEN NPV IS NOT NULL THEN NPV 
			ELSE 0 
		END AS NPV
FROM(
	SELECT Q.ID AS ID_1,Q.Year AS Year_1,N.NPV
	FROM Quaries Q
	LEFT JOIN NPV N
	ON N.ID = Q.ID AND Q.Year = N.Year
	) AS Window_Table
ORDER BY ID,Year

/*
Company:- Walmart

Count of products purchased based on recent transaction date

Assume you're given a table on walmart user transactions.

Input Table:- Transactions
------------------------------------------------------------------------
Product_ID       User_ID         Spend       Transaction_date
------------------------------------------------------------------------
3673              123            68.9         07/08/2022   10:00:00 
9623              123            274.1        07/08/2022   10:00:00 
1467              115            19.9         07/08/2022   10:00:00 
2513              159            25           07/08/2022   10:00:00 
1452              159            74.5         07/10/2022   10:00:00 
1452              123            74.5         07/10/2022   10:00:00 
9765              123            100.15       07/11/2022   10:00:00 
6536              115            57           07/12/2022   10:00:00 
7834              159            15.5         07/12/2022   10:00:00 
1247              159            23.4         07/12/2022   10:00:00 
------------------------------------------------------------------------

Based on their must recent transaction date. Write a query that retrieves the users along with number of products they bought. Output the user's 
most recent transaction date, User_Id and the number of products sorted in chornological order by the transaction date.

Output Table:- Transactions
---------------------------------------------------------------
Transaction_Date            User_ID           Purchase_avg
---------------------------------------------------------------
07/11/2022  10:00:00        123                 1
07/12/2022  10:00:00        115                 1
07/12/2022  10:00:00        159                 2
---------------------------------------------------------------
*/

CREATE TABLE Transactionsss(
						Product_ID INT NOT NULL,
						User_ID INT NOT NULL,
						Spend DECIMAL(10,2) NOT NULL,
						Transaction_date DATETIME NOT NULL
						)

INSERT INTO Transactionsss VALUES(3673,123,68.9,'07/08/2022  10:00:00'),(9623,123,274.1,'07/08/2022   10:00:00'),(1467,115,19.9,'07/08/2022   10:00:00'),
(2513,159,25,'07/08/2022   10:00:00'),(1452,159,74.5,'07/10/2022   10:00:00'),(1452,123,74.5,'07/10/2022   10:00:00'),(9765,123,100.15,'07/11/2022   10:00:00'),
(6536,115,57,'07/12/2022   10:00:00'),(7834,159,15.5,'07/12/2022   10:00:00'),(1247,159,23.4,'07/12/2022   10:00:00')

SELECT * FROM Transactionsss

WITH Latest_transaction
AS(
SELECT Transaction_date,User_ID,Product_ID,
								RANK() OVER(PARTITION BY User_ID ORDER BY Transaction_date DESC) AS RNK
FROM Transactionsss
)
SELECT Transaction_date,User_ID,COUNT(Product_ID) AS Purchase_Count
FROM Latest_transaction
WHERE RNK = 1
GROUP BY Transaction_date,User_ID

/*
Company Name:- Zomato

Analyze Restaurant rating overtime

you are a data analyst working with zomato your task is to analyze restaurant ratings overtime to understand how the average rating of each 
restaurant changes monthly.

Objective:- You need to calculate the average rating for each restuarnt for each month

Note:- Include restaurants that have recieved at least 2 reviews in a given month.

Input Table:- Reviews
----------------------------------------------------------------------------------------
Review_ID        User_ID           Submit_Date            Restaurant_ID        Rating
----------------------------------------------------------------------------------------
1001             501                2022-01-15              101                  4  
1002             502                2022-01-20              101                  5
1003             503                2022-01-25              102                  3
1004             504                2022-01-15              102                  4
1005             505                2022-02-20              101                  5
1006             506                2022-02-26              101                  4
1007             507                2022-03-01              101                  4 
1008             508                2022-03-05              102                  2
----------------------------------------------------------------------------------------

To FInd: Average rating for each restaurant for each month. Include restaurants that have received at least 2 reviews in a given month

Output Table:- Reviews
-------------------------------------------------
Month            Restaurant_ID       Avg_rating
-------------------------------------------------
1                  101                4.5
2                  101                4.5
1                  101                3.5
-------------------------------------------------
*/

CREATE TABLE Reviews (
					 Review_ID INT NOT NULL,
					 User_ID INT NOT NULL,
					 Submit_Date DATE,
					 Restaurant_ID INT NOT NULL,
					 Rating INT NOT NULL
					 )

INSERT INTO Reviews VALUES(1001,501,'2022-01-15',101,4),(1002,502,'2022-01-20',101,5),(1003,503,'2022-01-25',102,3),(1004,504,'2022-01-15',102,4),
(1005,505,'2022-02-20',101,5),(1006,506,'2022-02-26',101,4),(1007,507,'2022-03-01',101,4),(1008,508,'2022-03-05',102,2)

SELECT * FROM Reviews

SELECT MONTH(Submit_Date) AS Month,Restaurant_ID,AVG(Rating) AS Avg_rating
FROM Reviews
GROUP BY MONTH(Submit_Date),Restaurant_ID
HAVING COUNT(Review_ID)>=2

/*
Company Name:- Spotify

Select the top 5 Artist

Input Table:- Artists
--------------------------------------------------------------------
Artist_ID            Artist_Name              Label_Owner
--------------------------------------------------------------------
101                   Ed Sheeran               Warm Music Group
120                   Drake                    Warmer Music group
125                   Bad Bunny                Rimas Entertainment
130                   Lady Gaga                Interscope Records
140                   Katy Perry               Capital Records   
--------------------------------------------------------------------

Input Table: Song
--------------------------------------------------------------------
Song_ID              Artist_ID                  Name
--------------------------------------------------------------------
55511                 101                       Perfect
45202                 101                       Sirape of you
22222                 120                       One Dance
19960                 120                       Hotline Bling
33333                 125                       Dakiti
44444                 125                       Younagani
55555                 130                       Bad Romance
66666                 130                       Pokar Face
99999                 140                       Roar
101010                140                       Fire Work
--------------------------------------------------------------------

Input Table:- Golabal_Song_rank
--------------------------------------------
Day           Song_ID          Rank
--------------------------------------------
1              45202            5
3              45202            2
1              19960            3
9              19960            6
1              55511            8
2              33333            4
4              44444            8
6              55555            1
7              66666            10

--------------------------------------------

Output table
--------------------------------------
Artist_name        Artist_rank
--------------------------------------
Ed Sheeran           1
Drake                2
Bad Bunny            2
Lady Gaga            2
Katy Perry           3
--------------------------------------

Question:- Our objective is to identify top 5 artists whose songs appear most frequently in the top 10 of the global song ranking.

Note:- If multiple songs from the same artist are in the top 10, they should all count towrads that to rank these artists basd on the number of times
their songs have appeared in the Top 10. If there are ties, they should have the same ranking, but the overall ranking numbers should remain continous.
*/

CREATE TABLE Artists(
					Artist_ID INT NOT NULL,
					Artist_Name VARCHAR(50) NOT NULL,
					Label_Owner VARCHAR(100) NOT NULL
					);

INSERT INTO Artists VALUES(101,'Ed Sheeran','Warm Music Group'),(120,'Drake','Warmer Music group'),(125,'Bad Bunny','Rimas Entertainment'),
(130,'Lady Gaga','Interscope Records'),(140,'Katy Perry','Capital Records');

CREATE TABLE Song(
				  Song_ID INT NOT NULL,
				  Artist_ID INT NOT NULL,
				  Name VARCHAR(30)
				  );

INSERT INTO Song VALUES(55511,101,'Perfect'),(45202,101,'Sirape of you'),(22222,120,'One Dance'),(19960,120,'Hotline Bling'),(33333,125,'Dakiti'),
(44444,125,'Younagani'),(55555,130,'Bad Romance'),(66666,130,'Pokar Face'),(99999,140,'Roar'),(101010,140,'Fire Work');

CREATE TABLE Golabal_Song_rank(
								Day INT NOT NULL,
								Song_ID INT NOT NULL,
								Rank INT NOT NULL
								);

INSERT INTO Golabal_Song_rank VALUES(1,45202,5),(3,45202,2),(1,19960,3),(9,19960,6),(1,55511,8),(2,33333,4),(4,44444,8),(6,55555,1),(7,66666,10),(5, 99999,5);

SELECT * FROM Artists

SELECT * FROM Song

SELECT * FROM Golabal_Song_rank

WITH Artist_Rank
AS(
SELECT A.Artist_Name,DENSE_RANK() OVER(ORDER BY COUNT(S.Song_ID) DESC) AS Artist_Rank
FROM Artists A
INNER JOIN Song S
ON S.Artist_ID = A.Artist_ID
INNER JOIN Golabal_Song_rank G
ON S.Song_ID = G.Song_ID
GROUP BY A.Artist_Name
)

SELECT TOP 5 Artist_Name,Artist_Rank
FROM Artist_Rank

/*
Company Name:- IBM

FInd 3rd highest Salary for each category

Input Table:- Employee
----------------------------------------------------------------------------------
Employee_ID     First_Name        Last_Name        Salary          Job_category
----------------------------------------------------------------------------------
101              John              Doe             50000            DEV
102              Jane              Smith           60000            DEV
104              Charli            Davis           58000            DEV
108              Ivan              Hall            62000            DEV
103              Alice             Johnson         61000            HR
105              Eva               Miller          61000            HR
107              Heidi             Cleark          57000            HR
109              Judy              Lavis           53000            HR
110              Paul              Allen           70000            FIN
113              Olivia            Scott           65000            FIN
115              Nora              Adams           72000            FIN
106              Grace             Wilson          66000            PDT
111              Rose              Baker           68000            PDT
112              Max               Curtan          68000            PDT
114              Lucas             Turn            64000            PDT
----------------------------------------------------------------------------------

Question:- Write a query to display the details of the employees who have the 3rd highest salary in each job category. Return the column 'Employee_ID',
'First_Name' and 'Job_category'.

Return the resukt ordered by employee_id in ascending order.

Output Table: Employee
--------------------------------------------------------
Employee_ID        First_Name         Job_category
--------------------------------------------------------
103                Judy                HR
104                Chalie              Dev
113                Olivia              FIN
114                Lucas               PDT
--------------------------------------------------------
*/

CREATE TABLE Employee(
					  Employee_ID INT NOT NULL,
					  First_Name VARCHAR(30) NOT NULL,
					  Last_Name VARCHAR(30) NOT NULL,
					  Salary INT NOT NULL,
					  Job_category VARCHAR(10)
					  );

INSERT INTO Employee VALUES(101,'John','Doe',50000,'DEV'),(102,'Jane','Smith',60000,'DEV'),(104,'Charli','Davis',58000,'DEV'),(108,'Ivan','Hall',62000,'DEV'),
(103,'Alice','Johnson',61000,'HR'),(105,'Eva','Miller',61000,'HR'),(107,'Heidi','Cleark',57000,'HR'),(109,'Judy','Lavis',53000,'HR'),(110,'Paul','Allen',70000,'FIN'),
(113,'Olivia','Scott',65000,'FIN'),(115,'Nora','Adams',72000,'FIN'),(106,'Grace','Wilson',66000,'PDT'),(111,'Rose','Baker',68000,'PDT'),
(112,'Max','Curtan',68000,'PDT'),(114,'Lucas','Turn',64000,'PDT');


SELECT * FROM Employee

WITH Third_Highest_Salary
AS(
SELECT Employee_ID,First_Name,Job_category,
									DENSE_RANK() OVER(PARTITION BY Job_category ORDER BY Salary DESC) AS DNS_RNK 
FROM Employee
)

SELECT Employee_ID,First_Name,Job_category
FROM Third_Highest_Salary
WHERE DNS_RNK = 3
ORDER BY Employee_ID ASC;

/*
Company Name:- Swiggy

Delivery Partner Wise dealyed orders

Find out the delivery partner wise delayed orders count (delay means the ordered which look more than the predicted time to deliver the order).

You are given the following dataset.

Input Table:- Order_Details
------------------------------------------------------------------------------------------------------------------------------------------------------------
Order_ID     Cust_ID        City          Order_Date           Delivery_Partner       Order_Time        Delivery_Time           Predicted_Time         AOV
-------------------------------------------------------------------------------------------------------------------------------------------------------------
1             101           Banglore      2024-01-01      Partner A             10:00:00           11:30:00                       60                   100
2             102           Chennai       2024-01-02      Partner B             12:00:00           13:30:00                       45                   200
3             103           Banglore      2024-01-03      Partner A             14:00:00           15:40:00                       60                   300
4             104           Chennai       2024-01-04      Partner B             16:00:00           17:30:00                       90                   400
-------------------------------------------------------------------------------------------------------------------------------------------------------------

Questionn:- Write a sql query to calculate the number of delayed orders for each delivery partner. An order is considered delayed if the 
actual delivery time excceds the predicted delivery time.

Partner A:-

Order 1:- Placed at 10:00 AM. 
		 Delivered at 11:30 AM. 
		 Actual delivery time 90 minutes
		 Predicted delivery time : 60 minutes Delayed.

Order 3:- Placed at 14:00 PM.
		  Delivery at 15:45 PM.
		  Actual delivery time : 105 minutes.
		  Predicted delivery time: 60 minutes Delayed

Partner B:-

Order 2:- Placed at 12:00 PM.
		  Delivery at 12:15 PM.
		  Actual delivery time : 75 minutes.
		  Predicted delivery time: 45 minutes Delayed

Order 4:- Placed at 16:00 PM.
		  Delivery at 17:30 PM.
		  Actual delivery time : 90 minutes.
		  Predicted delivery time: 90 minutes Not Delayed

Output Table:- Order_Details
-----------------------------------------------
Delivery_Partner               Order_Count
-----------------------------------------------
Partner A                         2
Partner B                         1
-----------------------------------------------

To find the number of delayed orders for each delivery partner.
*/

CREATE TABLE Order_Details(
						  Order_ID INT PRIMARY KEY,
						  Cust_ID INT NOT NULL,
						  City VARCHAR(30) NOT NULL,
						  Order_Date DATE,
						  Delivery_Partner VARCHAR(20) NOT NULL,
						  Order_Time TIME,
						  Delivery_Time TIME,
						  Predicted_Time INT,
						  AOV DECIMAL(10,2)
						  );

INSERT INTO Order_Details VALUES(1,101,'Banglore','2024-01-01','Partner A','10:00:00','11:30:00',60,100),(2,102,'Chennai','2024-01-02','Partner B','12:00:00','13:30:00',45,200),
(3,103,'Banglore','2024-01-03','Partner A','14:00:00','15:40:00',60,300),(4,104,'Chennai','2024-01-04','Partner B','16:00:00','17:30:00',90,400);

SELECT * FROM Order_Details

SELECT Delivery_Partner,COUNT(*) AS Order_Count
FROM Order_Details
WHERE DATEDIFF(
			 MINUTE,
			 CAST(Order_Date AS DATETIME) + CAST(Order_Time AS DATETIME),
			 CAST(Order_Date AS DATETIME) + CAST(Delivery_Time AS DATETIME)) > Predicted_Time
GROUP BY Delivery_Partner;

/*
Company Name:- Target

Find sellers with no sales

Input Table:- Orders
-------------------------------------------------------------------------------------
Order_ID       Sale_Date       Order_Cost        Customer_ID        Seller_ID
-------------------------------------------------------------------------------------
1              2020-03-01       1500                101              1
2              2020-05-25       2400                102              2
3              2019-05-25       800                 101              3
4              2020-09-13       1000                100              2
5              2019-02-11       700                 101              2
-------------------------------------------------------------------------------------

Input Table:- Sallers
---------------------------------------------
Seller_ID         Seller_Name
---------------------------------------------
1                  Daniel
2                  Ben
3                  Frank
---------------------------------------------

Question:- Write a query to report the names of all sellers who did not make any sales in 2020.

Return the result table ordered by seller_name in ascending orders.
*/

CREATE TABLE Ordersss(
					Order_ID INT PRIMARY KEY,
					Sale_Date DATE,
					Order_Cost INT,
					Customer_ID INT,
					Seller_ID INT
					);

INSERT INTO Ordersss VALUES(1,'2020-03-01',1500,101,1),(2,'2020-05-25',2400,102,2),(3,'2019-05-25',800,101,3),(4,'2020-09-13',1000,100,2),
(5,'2019-02-11',700,101,2);

CREATE TABLE Sellers(	
					Saller_ID INT PRIMARY KEY,
					Seller_Name VARCHAR(20)
					);

INSERT INTO Sellers VALUES(1,'Daniel'),(2,'Daniel'),(3,'Frank');

SELECT * FROM Orderss

SELECT * FROM Sellers

SELECT Seller_Name
FROM Sellers 
WHERE Saller_ID NOT IN (
						SELECT Seller_ID
						FROM Ordersss
						WHERE YEAR(Sale_Date) = 2020
						)

--Method 2:

SELECT S.Saller_ID,S.Seller_Name
FROM Sellers S
LEFT JOIN (
		  SELECT O.Seller_ID FROM Ordersss O
		  WHERE YEAR(Sale_Date) = 2020
		  ) O
		  ON S.Saller_ID = O.Seller_ID
		  WHERE O.Seller_ID IS NULL

/*
Company Name:- LinkedIn

Identify Duplicate Job Listings

Imagine you're working with a table named job_listings, which contains job postings from various companies on LinkedIn. The objective is to 
write a SQL query that identifies and counts the number of companies that have posted duplicated job listings.

Note:- Duplicate job Listings are those job postings that are from the same company(company_id) taht have identical title and description.

Input Table:- Job_Listings
------------------------------------------------------------------------------------------------------------------------------
Company_ID         Job_ID          Title                Description
-------------------------------------------------------------------------------------------------------------------------------
827                248           Business Analyst       Business analyst evaluates past and current business data
														with the primary goal of improving decision-making processes
														with organisations.

845                149           Business Analyst       Business analyst evaluates past and current business data
														with the primary goal of improving decision-making processes
														with organisations.

345                945           Data Analyst           Data analyst reviews data to identify key insights into a business's
														customers and way the data can be used to solve problems.

345                164           Data Analyst           Data analyst reviews data to identify key insights into a business's
														customers and way the data can be used to solve problems.

244                172           Data Engineer          Data engineer works in a variety of settings to build systems that
														collect, manage, and convert raw data into usable information for data 
														scientistis and business to interpet.
-------------------------------------------------------------------------------------------------------------------------------

Output Table:- Job_Listings
--------------------------------------
Duplicate_companies
--------------------------------------
          1
--------------------------------------
*/

CREATE TABLE Job_Listings(
						 Company_ID INT NOT NULL,
						 Job_ID INT NOT NULL,
						 Title VARCHAR(30),
						 Description VARCHAR(500)
						 );

INSERT INTO Job_Listings VALUES(827,248,'Business Analyst','Business analyst evaluates past and current business data
														with the primary goal of improving decision-making processes
														with organisations.'),

(845,149,'Business Analyst','Business analyst evaluates past and current business data
							 with the primary goal of improving decision-making processes
							 with organisations.'),

(345,945,'Data Analyst','Data analyst reviews data to identify key insights into a business
						 customers and way the data can be used to solve problems.'),

(345,164,'Data Analyst','Data analyst reviews data to identify key insights into a business
						 customers and way the data can be used to solve problems.'),

(244,172,'Data Engineer','Data engineer works in a variety of settings to build systems that
						  collect, manage, and convert raw data into usable information for data 
						  scientistis and business to interpet.')

SELECT * FROM Job_Listings

-- WITH CTE Method

WITH Linkedin_job
AS(
SELECT Company_ID,Job_ID,Title,Description,
		ROW_NUMBER() OVER(PARTITION BY Company_ID ORDER BY Job_ID DESC) AS RWN
FROM Job_Listings
)

SELECT COUNT(Company_ID) AS Duplicate_companies
FROM Linkedin_job
WHERE RWN > 1

--Method 2

SELECT COUNT(DISTINCT Company_ID) AS Duplicate_companies
FROM Job_Listings
GROUP BY Company_ID
HAVING COUNT(Company_ID) > 1

/*
Company Name:- Uber

User's Third Transaction

Assume you are given a table named transactions which contains Uber transactions made by users. The table has three columns-

1. User_ID(Integer): The unique identifier for each user.
2. Spend (decimal): The amount sepnt on the transaction.
3. Transaction_Date(timestamp): The date and time of the transaction.

Input Table:-Transaction
-------------------------------------------------
User_ID     Spend      Transaction_Date
-------------------------------------------------
111         100.5       01/08/2022   12:00:00
111         55          01/10/2022   12:00:00
121         36          01/18/2022   12:00:00
145         24.99       01/26/2022   12:00:00
111         89.6        02/05/2022   12:00:00
-------------------------------------------------

Question:- Write a SQL query to obtain the third transaction of every user. The output should include the user_id, spend and transaction_date

Output Table:- Transaction
---------------------------------------------------
User_ID     Spend         Transaction_Date
---------------------------------------------------
111          89.6         2022-02-05   12:00:00
---------------------------------------------------
*/

CREATE TABLE Transactionssss(
						 User_ID INT,
						 Spend  FLOAT,
						 Transaction_Date DATETIME
						 )

INSERT INTO Transactionssss VALUES(111,100.5,'01-08-2022   12:00:00'),(111,55,'01-10-2022   12:00:00'),(121,36,'01-18-2022   12:00:00'),(145,24.99,'01-26-2022   12:00:00'),
(111,89.6,'02-05-2022   12:00:00')

SELECT * FROM Transactionssss

WITH Third_Transaction
AS(
SELECT User_ID,Spend,Transaction_Date,
    ROW_NUMBER() OVER(PARTITION BY User_ID ORDER BY Transaction_Date) AS RWN
FROM Transactionssss
)

SELECT User_ID,Spend,Transaction_Date
FROM Third_Transaction
WHERE RWN = 3

/*
Company Name:- Microsoft

Find SuperCloud Customer

you're given details of the customers and the products purchased by them.

Input Table:- Customer_contracts
-------------------------------------------------------
Customer_ID       Product_ID          Amount
-------------------------------------------------------
1                   1                 100  
2                   2                 2000
3                   1                 1100  
4                   1                 1000
7                   1                 1000
7                   3                 4000
6                   4                 2000
1                   5                 1500 
2                   5                 2000
4                   5                 2200
7                   6                 5000
1                   2                 2000  
-------------------------------------------------------

Input Table:- Product
---------------------------------------------------------------
Product_ID    Product_Category       Product_Name
---------------------------------------------------------------
1               Analytics            Azure Databricks
2               Analytics            Azure Stream Analytics
3               Containers           Azure Kubernetes Service
4               Containers           Azure Service Fabric
5               Compute              Virtual Machines
6               Compute              Azure Functions
---------------------------------------------------------------

Your task to identify customers who have purchased at least one product from every product category listed in the products table.

Output Table
---------------
Customer_ID
---------------
7
---------------
*/

CREATE TABLE Customer_contracts(
							   Customer_ID INT,
							   Product_ID  INT,
							   Amount INT
							   );


INSERT INTO Customer_contracts VALUES(1,1,100),(2,2,2000),(3,1,1100),(4,1,1000),(7,1,1000),(7,3,4000),(6,4,2000),(1,5,1500),(2,5,2000),(4,5,2200),
(7,6,5000),(1,2,2000);

CREATE TABLE Product(
					Product_ID INT PRIMARY KEY,
					Product_Category VARCHAR(30),
					Product_Name VARCHAR(50)
					);
								
INSERT INTO Product VALUES(1,'Analytics','Azure Databricks'),(2,'Analytics','Azure Stream Analytics'),(3,'Containers','Azure Kubernetes Service'),
(4,'Containers','Azure Service Fabric'),(5,'Compute','Virtual Machines'),(6,'Compute','Azure Functions')

SELECT * FROM Customer_contracts

SELECT * FROM Product

WITH CTE
AS(
SELECT C.*,P.Product_Category
FROM Customer_contracts C 
LEFT JOIN Product P
ON C.Product_ID = P.Product_ID
)

SELECT Customer_ID
FROM CTE 
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Product_Category) = (
										  SELECT COUNT(DISTINCT Product_Category) 
										  FROM Product
										  )
/*
Company Name:- Wipro
-------------------------------------
Emp_name      dept_Id      salary
-------------------------------------
Siva            1          30000
Ravi            2          40000
Prasad          1          50000
Sau             2          20000
Amma            2          10000
-------------------------------------

Expected output
------------------------------------------------------
Dept_id     min_sal_emp_name     max_sal_emp_name
------------------------------------------------------
1              Siva                  Prasad
2              Anna                  Ravi
------------------------------------------------------

Question:- Find the minimum and maximum salary of a employees
*/

CREATE TABLE Emp(
				Emp_name VARCHAR(20),
				dept_Id INT,
				salary INT
				)


INSERT INTO Emp VALUES('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sau',2,20000),('Amma',2,10000)

SELECT * FROM Emp

SELECT DISTINCT dept_Id,FIRST_VALUE(Emp_name) OVER(PARTITION BY dept_Id ORDER BY Salary) AS min_sal_emp_name,
FIRST_VALUE(Emp_name) OVER(PARTITION BY dept_Id ORDER BY Salary DESC) AS max_sal_emp_name
FROM Emp

--Method 2

WITH CTE
AS(
SELECT *, ROW_NUMBER() OVER(PARTITION BY dept_Id ORDER BY Salary) AS RWN_1,
ROW_NUMBER() OVER(PARTITION BY dept_Id ORDER BY Salary DESC) AS RWN_2
FROM Emp
)
SELECT dept_Id,MAX(CASE WHEN RWN_1 = 1 THEN Emp_Name END) AS Min_sal_emp_name,
MAX(CASE WHEN RWN_2 = 1 THEN Emp_Name END) AS Max_sal_emp_name
FROM CTE
GROUP BY Dept_ID

/*
Company_Name:- HCL
-------------                     -------------
Table_1								Table_2
-------------					  -------------
ID                                    ID
-------------                     -------------
1                                    1
1                                    3
2                                    Null
Null
Null
-------------                   ------------- 
--------------------------------------------------------------------------
Inner Join     Left Join      Right join     Full Join      Cross Join
--------------------------------------------------------------------------
2               5               4             7               15
--------------------------------------------------------------------------
*/

CREATE TABLE Table_1(ID INT)

INSERT INTO Table_1 VALUES(1),(1),(2),(NULL),(NULL)

CREATE TABLE Table_2(ID INT)

INSERT INTO Table_2 VALUES(1),(3),(NULL)


SELECT * FROM Table_1

SELECT * FROM Table_2

-- INNER JOIN

SELECT * FROM Table_1 T
INNER JOIN Table_2 V
ON T.ID = V.ID

-- LEFT JOIN

SELECT * FROM Table_1 T
LEFT JOIN Table_2 V
ON T.ID = V.ID

-- RIGHT JOIN

SELECT * FROM Table_1 T
RIGHT JOIN Table_2 V
ON T.ID = V.ID

-- FULL JOIN

SELECT * FROM Table_1 T
FULL JOIN Table_2 V
ON T.ID = V.ID

-- CROSS JOIN

SELECT * FROM Table_1 T
CROSS JOIN Table_2 

/*
--------------------------
Company Name:- KPMG
---------------------------
Students
--------------------------
S_name     S_Id    Marks
--------------------------
A           X       75
A           Y       75
A           Z       80
B           X       90
B           Y       91
B           Z       75
--------------------------

Expected output
--------------------------
S_Name    Total_Marks
--------------------------
A           155
B           181
--------------------------

Question:- Find the top two highest marks for each students
*/

CREATE TABLE Students(
					 S_name VARCHAR(2),
					 S_Id VARCHAR(2),
					 Marks INT
					 )

INSERT INTO Students VALUES('A','X',75),('A','Y',75),('A','Z',80),('B','X',90),('B','Y',91),('B','Z',75)

SELECT * FROM Students

WITH Highest_marks
AS(
SELECT *,ROW_NUMBER() OVER(PARTITION BY S_name ORDER BY Marks) AS RWN
FROM Students
)
SELECT S_name,SUM(Marks) AS Total_marks
FROM Highest_marks
WHERE RWN >= 2
GROUP BY S_name

--Method 2

SELECT S_name,SUM(Marks) AS Total_marks
FROM(
SELECT *,ROW_NUMBER() OVER(PARTITION BY S_name ORDER BY Marks) AS RWN
FROM Students
) M
WHERE RWN >=2
GROUP BY S_name

/*
Company Name:- HexaWare

Employees
------------
ID
------------
2
5
6
6
7
8
8
------------

Expected output
----------------
max_id
----------------
7
----------------

Question:- identify the mazximum ID
*/

CREATE TABLE EMP_1(ID INT)

INSERT INTO EMP_1 VALUES (2),(5),(6),(6),(7),(8),(8)

SELECT * FROM  EMP_1

WITH CTE
AS(
SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) AS RWN
FROM EMP_1
)
SELECT MAX(ID) AS Max_ID
FROM CTE
WHERE ID NOT IN (
				SELECT ID FROM CTE
				WHERE RWN > 1
				)

--Method 2

SELECT MAX(ID) AS Max_ID 
FROM EMP_1
WHERE ID NOT IN (
				SELECT ID FROM EMP_1
				GROUP BY ID
				HAVING COUNT(*) > 1
				)

/*
Compnay Name:- Movate

Table_A												Table_B
----------------------------                  ----------------------------       
Emp_ID    Ename    Salary						Emp_ID    Ename    Salary
----------------------------				  ----------------------------
1          AA        1000						2          BB        400
2          BB        3000						3          CC        100
---------------------------------------------------------------------------------------------

Expected Output
--------------------------------
Emp_ID    Ename    Salary
--------------------------------
1          AA        1000
2          BB        400
3          CC        100
--------------------------------
*/

CREATE TABLE Table_A(
					Emp_ID INT,
					Ename VARCHAR(3),
					Salary INT
					)

INSERT INTO Table_A VALUES(1,'AA',1000),(2,'BB',3000)

CREATE TABLE Table_B(
					Emp_ID INT,
					Ename VARCHAR(3),
					Salary INT
					)

INSERT INTO Table_B VALUES(2,'BB',400),(3,'CC',100)


SELECT * FROM Table_A

SELECT * FROM Table_B

WITH CTE 
AS(
SELECT * FROM Table_A
UNION
SELECT * FROM Table_B
)
SELECT Emp_ID,EName,MIN(Salary) AS Salary
FROM CTE
GROUP BY Emp_ID,EName

--Another Method

WITH CTE 
AS(
SELECT *, ROW_NUMBER() OVER(PARTITION BY Emp_ID ORDER BY Emp_ID) AS RWN
FROM (
	 SELECT * FROM Table_A
	 UNION 
	 SELECT * FROM Table_B
	 ) T
)

SELECT * FROM CTE
WHERE RWN <= 1


/*
Company Name:- TRELEEBORG
-----------------------
Input Table:-Sales
-----------------------
Month     Ytd_Sales
-----------------------
Jan        15
Feb        22
Mar        35
Apr        45
May        60
-----------------------

Expected output
---------------------------------------
Month     Ytd_sales    Peridic_sales
---------------------------------------
Jan        15             15
Feb        22             7
Mar        35             13
Apr        45             10
May        60             15
---------------------------------------

Question:- Find the Peridic_sales
*/

CREATE TABLE Sales(
				  Month VARCHAR(10),
				  Ytd_Sales INT,
				  Month_num INT
				  )

INSERT INTO Sales VALUES('Jan',15,1),('Feb',22,2),('Mar',35,3),('Apr',45,4),('May',60,5)

SELECT * FROM Sales

WITH CTE
AS(
SELECT *, LAG(Ytd_Sales,1,0) OVER(ORDER BY Month_num) AS Lag_sales
FROM Sales
)

SELECT Month,Ytd_Sales,(Ytd_Sales - Lag_sales) AS Peridic_sales 
FROM CTE

/*
Company Name:- PWC

Input Table:- Employee
-------------------------------------------------------------------------------------------------------------------------------------------
Employee_ID		Employee_Name		Department		Manager_ID		  Hire_Date			Monthly_Sales		  Sales_Amount		 Month
--------------------------------------------------------------------------------------------------------------------------------------------
1                Alice               Sales            101              01/01/2020            90000				150000			01/01/2025
1                Alice               Sales            101              01/01/2020            90000				200000			01/01/2025
2                Bob				 Sales            101              03/15/2021            85000				100000			01/01/2025
2                Bob				 Sales            101              03/15/2021            85000				120000			02/01/2025
3                Carot				 HR               102              07/10/2019            95000				  0			    01/01/2025
4                David				 HR               102              06/25/2020            87000				  0			    02/01/2025
5                Evan				 IT               103              05/05/2022            80000				60000			01/01/2025
5                Evan				 IT               103              05/05/2022            80000				75000			02/01/2025
--------------------------------------------------------------------------------------------------------------------------------------------

A Single table containing employe details, department information, and their monthly sales.

Question Asked:

1) For each employee, calculate: Total sales, Average monthly sales.
2) Rank Employee with each department based on total sales.
3) Compute a running total of sales per department, ordered by total sales.
4) Perform a month-over-month companies:
-Previous month's sales
- Difference from current month
5) Show only those department whose total sales exceed ₹100,000. Classify employee as:-
-Top performer + total sales > department average
- Below Average
*/

CREATE TABLE Pwc_Employee(
						 Employee_ID INT,
						 Employee_Name VARCHAR(30),
						 Department	VARCHAR(30),
						 Manager_ID	INT,
						 Hire_Date	DATE,
						 Monthly_Sales INT,
						 Sales_Amount INT,
						 Month DATE
						 )

INSERT INTO Pwc_Employee VALUES(1,'Alice','Sales',101,'01-01-2020',90000,150000,'01-01-2025'),(1,'Alice','Sales',101,'01-01-2020',90000,200000,'01-01-2025'),
(2,'Bob','Sales',101,'03-15-2021',85000,100000,'01-01-2025'),(2,'Bob','Sales',101,'03-15-2021',85000,120000,'02-01-2025'),
(3,'Carot','HR',102,'07-10-2019',95000,0,'01-01-2025'),(4,'David','HR',102,'06-25-2020',87000,0,'02-01-2025'),
(5,'Evan','IT',103,'05-05-2022',80000,60000,'01-01-2025'),(5,'Evan','IT',103,'05-05-2022',80000,75000,'02-01-2025')

SELECT * FROM Pwc_Employee

--1) For each employee, calculate: Total sales, Average monthly sales.

SELECT Employee_ID,Employee_Name,Department,Manager_ID,Hire_Date,AVG(Sales_Amount) AS Average_monthly_sales,SUM(Sales_Amount) AS Total_sales
FROM Pwc_Employee
GROUP BY  Employee_ID,Employee_Name,Department,Manager_ID,Hire_Date
ORDER BY Total_sales DESC


--2) Rank Employee with each department based on total sales.

SELECT Employee_ID,Employee_Name,Department,Manager_ID,Hire_Date,AVG(Sales_Amount) AS Average_monthly_sales,SUM(Sales_Amount) AS Total_sales,
RANK() OVER(PARTITION BY Department ORDER BY SUM(Sales_Amount) DESC) AS RNK
FROM Pwc_Employee
GROUP BY  Employee_ID,Employee_Name,Department,Manager_ID,Hire_Date;

--3) Compute a running total of sales per department, ordered by total sales.

WITH DeptTotals
AS(
SELECT Department,Employee_ID,Employee_Name,SUM(Sales_Amount) AS Total_sales
FROM Pwc_Employee
GROUP BY Department,Employee_ID,Employee_Name
)

SELECT  Department,Employee_ID,Employee_Name,Total_sales,SUM(Total_sales) OVER(PARTITION BY Department ORDER BY Total_sales DESC) AS Running_Total
FROM DeptTotals
ORDER BY Department,Running_Total

--4) Perform a month-over-month companies:
--Previous month's sales
-- Difference from current month

WITH MonthlyTotal
AS(
SELECT Month,SUM(Sales_Amount) AS Total_Sales
FROM Pwc_Employee
GROUP BY Month
)
SELECT Month,Total_Sales,LAG(Total_Sales,1,0) OVER(ORDER BY Month) AS Previous_month_sales,
Total_Sales - LAG(Total_Sales,1,0) OVER(ORDER BY Month) AS Difference_from_previous
FROM MonthlyTotal
ORDER BY Month

--5) Show only those department whose total sales exceed ₹100,000. Classify employee as:-
--Top performer + total sales > department average
-- Below Average

WITH DeptAgg
AS(
SELECT Department,SUM(Sales_Amount) AS Dept_Total,
AVG(SUM(Sales_Amount)) OVER(PARTITION BY Department) AS Dept_Avg
FROM Pwc_Employee
GROUP BY Department
),
EmpAgg AS(
		SELECT Employee_ID,Employee_Name,Department,SUM(Sales_Amount) AS Emp_Total
		FROM Pwc_Employee
		GROUP BY Employee_ID, Employee_Name,Department
		)

SELECT E.Employee_ID,
E.Department,
E.Emp_Total,
		CASE 
			WHEN E.Emp_Total > (
								SELECT AVG(Emp_Total)
								FROM EmpAgg EA
								WHERE EA.Department = E.Department
								)
			THEN 'Top Performance' ELSE 'Below Performance'
			END  AS Classification
			FROM EmpAgg E
WHERE E.Department IN(
					SELECT Department FROM EmpAgg GROUP BY Department HAVING SUM(Emp_Total) > 100000
					)
ORDER BY E.Department, E.Emp_Total DESC;

/*
Company Name:- Deloite

Problem :- Employees may have multiple clock-in / clock-out enteries per day(for example, after breaks or lunch).
You need to calculate the total hours worked per employees per day

Input Table:- Attendance
--------------------------------------------------
Emp_ID     Date			Clock_in      Clock_out
--------------------------------------------------
101       27-10-2025    09:00:00      12:00:00
101       27-10-2025    13:00:00      17:00:00 
102       27-10-2025    09:30:00      18:00:00
101       28-10-2025    09:15:00      17:45:00
--------------------------------------------------

Output Table:- Attendance
----------------------------------------------
Emp_ID       Attendance_Date         Total_hours
----------------------------------------------
101			  27-10-2025				7
102           27-10-2025				8.5
101           28-10-2025				8.5
----------------------------------------------
*/

CREATE TABLE Attendance(
					   Emp_ID INT,
					   Attendance_Date DATE,
					   Clock_in TIME,
					   Clock_out TIME
					   )

INSERT INTO Attendance VALUES(101,'2025-10-27','09:00:00','12:00:00'),(101,'2025-10-27','13:00:00','17:00:00'),(102,'2025-10-27','09:30:00','18:00:00'),(101,'2025-10-28','09:15:00','17:45:00')

SELECT * FROM Attendance

SELECT Emp_ID,Attendance_Date, SUM(CAST(DATEDIFF(SECOND,Clock_in,Clock_out) AS FLOAT) / 3600) AS Total_hours
FROM Attendance
GROUP BY Emp_ID,Attendance_Date

/*
Company Name:- Accenture

Input Table:- EmployeeAction

Calculate the average time difference between consecutive actions per employees and include the output
------------------------------------------------------
Emp_ID        Action           Action_time
--------------------------------------------------------
1             Login            14-10-2025    09:00:00
1             Browse           14-10-2025    09:20:00
1             Logout           14-10-2025    10:00:00
2             Login            14-10-2025    09:10:00
2             logout           14-10-2025    09:30:00
--------------------------------------------------------

Output Table:- EmployeeAction

----------------------------------------------
Emp_id            Avg_time_diff_minutes
----------------------------------------------
1                          30
2                          20
----------------------------------------------
*/

CREATE TABLE EmployeeAction(
						   Emp_ID INT,
						   Action VARCHAR(50),
						   Action_time DATETIME
						   )

INSERT INTO EmployeeAction VALUES(1,'Login','2025-10-14  09:00:00'),(1,'Browse','2025-10-14  09:20:00'),(1,'Logout','2025-10-14  10:00:00'),(2,'Login','2025-10-14  09:10:00'),
(2,'logout','2025-10-14  09:30:00')

SELECT * FROM EmployeeAction

WITH CTE
AS(
SELECT *,LEAD(Action_time) OVER(PARTITION BY Emp_ID ORDER BY Action_time) AS Next_Action_time
FROM EmployeeAction
)
SELECT Emp_ID,AVG(DATEDIFF(MINUTE,Action_time,Next_Action_time)) AS Avg_Difference
FROM CTE
WHERE Next_Action_time IS NOT NULL
GROUP BY Emp_ID

/*
Question 1: (Amazon)

Find all numbers that appear at least three times consecutively. Return one column
named Consecutive Nums.
Table: Logs
-------------------
Columns: id, num
-------------------
id	num
-------------------
1	1
2	1
3	1
4	2
5	2
6	3
7	3
8	3
9	3
10	1
11	1
12	4
13	4
14	4
15	5
-------------------
*/

CREATE TABLE Logss (
				id INT,
				num INT
				);

INSERT INTO Logss (id, num) VALUES(1, 1),(2, 1),(3, 1),(4, 2),(5, 2),(6, 3),(7, 3),(8, 3),(9, 3),(10, 1),(11, 1),(12, 4),(13, 4),(14, 4),(15, 5);

SELECT * FROM Logss

WITH Consective
AS(
SELECT id,num,LAG(num,1) OVER(ORDER BY ID) AS Lag_1,
LAG(num,2) OVER(ORDER BY id) AS Lag_2
FROM Logss 
)
SELECT DISTINCT num AS Consecutive_Number
FROM Consective
WHERE Num = Lag_1 AND Num = Lag_2

--Another Method

SELECT DISTINCT L1.num AS Consecutive_Number
FROM Logss L1,Logss L2, Logss L3
WHERE L1.id = L2.id + 1 AND L2.id = L3.id - 2 AND L3.num = L2.num

/*
Question 2: (Myntra)
Write a query to find the employees who have the third highest salary. Return - id,name, salary

Input Table: emp
-------------------------------
id	name	salary
1	Amit	90000
2	Rahul	75000
3	Sneha	90000
4	Vijay	65000
5	Priya	65000
6	Karan	80000
7	Simran	70000
8	Rohan	70000
9	Meera	60000
-------------------------------
*/

CREATE TABLE emp2 (
			id INT,
			name VARCHAR(100),
			salary INT
			);

INSERT INTO emp2 (id, name, salary) VALUES(1, 'Amit', 90000),(2, 'Rahul', 75000),(3, 'Sneha', 90000),(4, 'Vijay', 65000),(5, 'Priya', 65000),(6, 'Karan', 80000),(7, 'Simran', 70000),
(8, 'Rohan', 70000),(9, 'Meera', 60000);

SELECT * FROM emp2

WITH Third_Highest_Sal
AS(
SELECT id,name, salary,DENSE_RANK() OVER(ORDER BY salary DESC) AS Dns_Rnk
FROM emp2
)
SELECT id,name, salary
FROM Third_Highest_Sal
WHERE Dns_Rnk = 3

/*
Question 3: (Amazon)

Write a query to find the length of the longest consecutive sequence of numbers.
Input Table: Consecutive
--------------------
number
1
2
3
5
6
7
10
11
12
13
20
--------------------
*/

CREATE TABLE Consecutive (
					number INT
					);

INSERT INTO Consecutive (number) VALUES(1),(2),(3),(5),(6),(7),(10),(11),(12),(13),(20);

SELECT * FROM Consecutive

WITH CTE 
AS(
SELECT number,number - ROW_NUMBER() OVER(ORDER BY number) AS grp
FROM Consecutive
),
grouped
AS( 
  SELECT grp,COUNT(*) AS Seq_length
  FROM CTE
  GROUP BY grp
  )
SELECT MAX(Seq_length) AS longest_consecutive_sequence
FROM grouped

/*
Question 4: (Deloitte)

For each product category and calendar year, calculate the year-on-year growth rate
in the number of distinct purchasing users. Return - year, category,

curr_year_users, prev_year_users, and yoy_rate.
Input Table: user_purchases
-----------------------------------------------------------------------
purchase_id	user_id	product_id	category	amount	purchase_date
1			101			1001	Electronics	  250.00	2021-01-15
2			102	        1002	Electronics	  300.00	2021-03-10
3		    103			1003	Electronics	  150.00	2021-11-20
4			101			1004	Electronics	  400.00	2022-02-05
5			104			1005	Electronics	  220.00	2022-05-18
6			105			1006	Electronics	  180.00	2022-09-09
7			101			1007	Electronics	  500.00	2023-01-12
8			102			1008	Electronics	  260.00	2023-03-03
9			106			1009	Electronics	  300.00	2023-07-21
10			201			2001	Clothing	  80.00	    2021-04-02
11			202			2002	Clothing	  90.00 	2021-06-15
12			201			2003	Clothing	  120.00	2022-03-30
13			203			2004	Clothing	  70.00	    2022-08-11
14			201			2005	Clothing	  130.00	2023-02-19
15			202			2006	Clothing	  95.00	    2023-05-27
16			204			2007	Clothing	  60.00	    2023-10-05
-----------------------------------------------------------------------
*/

CREATE TABLE user_purchases (
							purchase_id INT,
							user_id INT,
							product_id INT,
							category VARCHAR(50),
							amount DECIMAL(10,2), purchase_date DATE
							);

INSERT INTO user_purchases (purchase_id, user_id, product_id, category,amount, purchase_date) VALUES
(1, 101, 1001, 'Electronics', 250.00, '2021-01-15'),
(2, 102, 1002, 'Electronics', 300.00, '2021-03-10'),
(3, 103, 1003, 'Electronics', 150.00, '2021-11-20'),
(4, 101, 1004, 'Electronics', 400.00, '2022-02-05'),
(5, 104, 1005, 'Electronics', 220.00, '2022-05-18'),
(6, 105, 1006, 'Electronics', 180.00, '2022-09-09'),
(7, 101, 1007, 'Electronics', 500.00, '2023-01-12'),
(8, 102, 1008, 'Electronics', 260.00, '2023-03-03'),

(9, 106, 1009, 'Electronics', 300.00, '2023-07-21'),
(10, 201, 2001, 'Clothing', 80.00, '2021-04-02'),
(11, 202, 2002, 'Clothing', 90.00, '2021-06-15'),
(12, 201, 2003, 'Clothing', 120.00, '2022-03-30'),
(13, 203, 2004, 'Clothing', 70.00, '2022-08-11'),
(14, 201, 2005, 'Clothing', 130.00, '2023-02-19'),
(15, 202, 2006, 'Clothing', 95.00, '2023-05-27'),
(16, 204, 2007, 'Clothing', 60.00, '2023-10-05');

SELECT * FROM user_purchases

WITH Yearly_Users 
AS (
SELECT YEAR(purchase_date) AS Yrs,category,COUNT(DISTINCT user_id) AS Curr_yrs_users
FROM user_purchases
GROUP BY YEAR(purchase_date), category
)
SELECT Yrs,category,Curr_yrs_users,LAG(Curr_yrs_users) OVER(PARTITION BY category ORDER BY Yrs) AS prev_year_users,
ISNULL(ROUND((Curr_yrs_users - LAG(Curr_yrs_users) OVER(PARTITION BY category ORDER BY Yrs)) * 1.0/ NULLIF(LAG(Curr_yrs_users) OVER(PARTITION BY category ORDER BY Yrs),0),2),0) AS yoy_rate
FROM Yearly_Users
ORDER BY category, Yrs;

/*
Company Name:- WinWire

Input Table:- Happiness_tbl
------------------------------------
Ranking             Country
------------------------------------
1					Finland
2					Denmark
3					Iceland
4					Israel
5					Netherlands
6					Sweden
7					Norway
123                 India
128					Srilanka

------------------------------------

Output Table:- Happiness_tbl
----------------
Country
----------------
India
Srilanka
Finland
Denmark
Iceland
Israel
Natherlands
Swedan
Norway
----------------
*/

CREATE TABLE Happiness_tbl (Ranking INT,Country VARCHAR(20))

INSERT INTO Happiness_tbl VALUES(1,'Finland'),(2,'Denmark'),(3,'Iceland'),(4,'Israel'),(5,'Netherlands'),(6,'Sweden'),(7,'Norway'),(123,'India'),(128,'Srilanka')

SELECT * FROM Happiness_tbl

SELECT *, CASE
			WHEN Country = 'India' THEN 1
			WHEN Country = 'Srilanka' THEN 2
		ELSE 3 END AS Derived_rank
FROM Happiness_tbl
ORDER BY Derived_rank

/*
Company Name:- Incedeo

Input Table:- Student_tbl
----------------------------
Sname          Marks
----------------------------
A               75
B               30
C               55
A               60
D               91
B               19
G               36
S               65
K               49
----------------------------

Output Table:- Student_tbl
---------------------------------------
Sname          Marks          Grade
---------------------------------------
A               81           Excellent
B               30           Poor
C               55           Good
A               60           VGood
D               91           Excellent
B               19           Poor
G               36           Good
S               72           VGood
K               49           Good
---------------------------------------
*/

CREATE TABLE Student_tbl(Sname VARCHAR(5),Marks INT)

INSERT INTO Student_tbl VALUES('A',75),('B',30),('C',55),('A',60),('D',91),('B',19),('G',36),('S',65),('K',49)

SELECT * FROM Student_tbl

ALTER TABLE Student_tbl
ADD Gender 
AS(
	CASE
		WHEN Marks >=  80 THEN 'Excellent'
		WHEN Marks >=  60  AND Marks < 80 THEN  'VGood'
		WHEN Marks >=  35  AND Marks < 60  THEN  'Good'
		ELSE 'Poor' END)

/*
Company Name:- U.ST

Input Table:- Cinemas_tbl
---------------------------
Seat_id        Free
---------------------------
1               1
2               0
3               1
4               0
5               1
6               1
7               1
8               0
9               1
10              1
---------------------------

Output Table:- Cinemas_tbl
---------------------------
Seat_Id
---------------------------
5
6
7
9
10
---------------------------
*/

CREATE TABLE Cinemas_tbl(Seat_id INT,Free INT)

INSERT INTO Cinemas_tbl VALUES(1,1),(2,0),(3,1),(4,0),(5,1),(6,1),(7,1),(8,0),(9,1),(10,1)

SELECT * FROM Cinemas_tbl

WITH CTE
AS(
SELECT *,(LAG(Free) OVER(ORDER BY Seat_ID) * Free) AS Previous_Seat,
(LEAD(Free) OVER(ORDER BY Seat_ID) * Free) AS Next_Seat
FROM Cinemas_tbl
)

SELECT Seat_ID FROM CTE
WHERE Previous_Seat = 1 OR Next_Seat = 1 

/*
Problem Statement

You are given a table named purchases with the following columns:
1. User_ID(Integer): Unique identifier for each user
2. Purchase_date(Date): Date on which the purchase was made

Task:
1. For each user. identify the first purchase date.
2. Calculate the number of days since the first purchase from the current date

Expected output:
1. User_ID
2. First_purchase_date
3. Days_since_first_purchase

Follow_up(Advanced):
Modify your solution to return all transaction along with the first purchase date days since first purchase for each record
----------------------------------------------
User_ID                 Purchase_date
----------------------------------------------
1                        2023-01-10
1                        2023-02-15
1                        2023-03-20
2                        2023-05-05
2                        2023-06-01
3                        2024-01-12
3                        2024-02-18
3                        2024-03-25
4                        2025-07-01
----------------------------------------------
*/

CREATE TABLE Purchase(User_ID INT,Purchase_Date DATE);

INSERT INTO Purchase VALUES(1,'2023-01-10'),(1,'2023-02-15'),(1,'2023-03-20'),(2,'2023-05-05'),(2,'2023-06-01'),(3,'2024-01-12'),(3,'2024-02-18'),(3,'2024-03-25'),(4,'2025-07-01');

SELECT * FROM Purchase

SELECT User_ID,MIN(Purchase_Date) AS First_purchase_date,DATEDIFF(DAY,MIN(Purchase_Date),GETDATE()) AS Days_since_first_purchase
FROM Purchase
GROUP BY User_ID
ORDER BY User_ID;

--Another Method

SELECT User_ID,Purchase_Date,MIN(Purchase_Date) OVER(PARTITION BY User_ID) AS First_purchase_date,
DATEDIFF(DAY,MIN(Purchase_Date) OVER(PARTITION BY User_ID),GETDATE()) AS Days_since_first_purchase
FROM Purchase
GROUP BY User_ID,Purchase_Date;

/*
Company Name:- EY

Input Table:-
----------------------------------------------------------------------------------------
Center_id    case_id     stage1      stage2     stage3      stage4       stage5
----------------------------------------------------------------------------------------
C1              1        01/01/24                           13/01/24
C1              2        05/01/24   10/01/24
C2              3                   10/01/24                             20/01/24
C3              4        05/01/24   12/01/24    12/01/24    14/01/24     20/01/24   
C3              5        10/01/24   15/01/24
C3              6                                           15/01/24
----------------------------------------------------------------------------------------

Expected Output
----------------------------------------------------------------------------
Center_id    stage1      stage2       stage3      stage4       stage5
----------------------------------------------------------------------------
C1             2            2           1             1            0
C2             1            1           1             1            1
C3             3            3           2             2            1
----------------------------------------------------------------------------

How many cases have reached each stage of completion(stage1 to stage 5) for each center?
*/

CREATE TABLE Cases(
				  Center_id VARCHAR(5),
				  case_id INT,
				  stage1 DATE,
				  stage2 DATE,
				  stage3 DATE,
				  stage4 DATE,
				  stage5 DATE
				  );

INSERT INTO Cases VALUES('C1',1,'2024-01-01',NULL,NULL,'2024-01-13',NULL),('C1',2,'2024-01-25','2024-01-10',NULL,NULL,NULL),('C2',3,NULL,'2024-01-10',NULL,NULL,'2024-01-20'),
('C3',4,'2024-01-05','2024-01-12','2024-01-12','2024-01-24','2024-01-20'),('C3',5,'2024-01-10','2024-01-15',NULL,NULL,NULL),('C3',6,NULL,NULL,NULL,'2024-01-24',NULL);

SELECT * FROM Cases

WITH Filled_Stages
AS(
SELECT Center_id,case_id,
COALESCE(stage1,stage2,stage3,stage4,stage5) AS Stage1,
COALESCE(stage2,stage3,stage4,stage5) AS Stage2,
COALESCE(stage3,stage4,stage5) AS Stage3,
COALESCE(stage4,stage5) AS Stage4,Stage5
FROM Cases
)
SELECT Center_id,
COUNT(stage1) AS stage1,
COUNT(stage2) AS stage2,
COUNT(stage3) AS stage3,
COUNT(stage4) AS stage4,
COUNT(stage5) AS stage5
FROM Filled_Stages
GROUP BY Center_id

/*
Company Name:- KPMG

Input Table: Orders
-----------------------------------------------
Order_ID     Customer_ID       Order_Date
-----------------------------------------------
1               101             2024-01-05   
2               101             2024-03-15   
3               101             2024-05-20
4               102             2024-02-10
5               102             2024-04-25   
6               102             2024-06-30
7               103             2024-01-01
8               103             2024-02-18
9               103             2024-03-25 
-----------------------------------------------

Expected Ourtput:- Orders
------------------------------------------------------------
Order_ID     Customer_ID       Order_Date      Order_type
------------------------------------------------------------
101             1              2024-01-05       First Order
101             3              2024-05-20       Last Order
102             4              2024-02-10       First Order
102             6              2024-06-30       Last Order
103             7              2024-01-01       First Order
103             9              2024-03-25       Last Order
------------------------------------------------------------

Question:- Write a SQL query to retrieve the first and last order for each customer from the orders table
*/

CREATE TABLE Orderssss(
					 Order_ID  INT,
					 Customer_ID INT,
					 Order_Date DATE
					 )

INSERT INTO Orderssss VALUES(1,101,'2024-01-05'),(2,101,'2024-03-15'),(3,101,'2024-05-20'),(4,102,'2024-02-10'),(5,102,'2024-04-25'),(6,102,'2024-06-30'),
(7,103,'2024-01-01'),(8,103,'2024-02-18'),(9,103,'2024-03-25');

SELECT * FROM Orderssss

WITH CTE
AS(
SELECT Order_ID,Customer_ID,Order_Date,
						DENSE_RANK() OVER(PARTITION BY Customer_ID ORDER BY Order_Date ASC) AS First_Order,
						DENSE_RANK() OVER(PARTITION BY Customer_ID ORDER BY Order_Date DESC) AS Last_Order
FROM Orderssss
)
SELECT Customer_ID,Order_ID,Order_Date,
									 CASE
										WHEN First_Order = 1 THEN 'First Order'
										WHEN Last_Order = 1 THEN 'Last Order'
									END AS Order_Type
FROM CTE
WHERE First_Order = 1 OR Last_Order = 1
ORDER BY Order_ID

/*
Companu Name:- Deloitte

Input Table:- Order_tbl
--------------------------------
Order_Date           Item
--------------------------------
2024-03-01           Apple
2024-03-01           Banana
2024-03-01           Apple
2024-03-02           Orange
2024-03-02           Orange
2024-03-02           Mango
2024-03-03           Banana
2024-03-03           Banana
2024-03-03           Mango
2024-03-03           Mango
--------------------------------

Expected Output:- Order_tbl
------------------------------------------------
Order_Date           Item       Order_Count
------------------------------------------------
2024-03-01           Apple          2
2024-03-02           Orange         2
2024-03-03           Banana         2
2024-03-03           Mango          2
------------------------------------------------

Question:- Write a SQL query to retrieve the most frequently ordered item(S) for each data from a given orders table. If multiple items have the highest order count
on a particular date, include all such items in the result.
*/

CREATE TABLE Order_tbl(
					 Order_Date DATE,
					 Item VARCHAR(20)
					 )

INSERT INTO Order_tbl VALUES('2024-03-01','Apple'),('2024-03-01','Banana'),('2024-03-01','Apple'),('2024-03-02','Orange'),('2024-03-02','Orange'),('2024-03-02','Mango'),
('2024-03-03','Banana'),('2024-03-03','Banana'),('2024-03-03','Mango'),('2024-03-03','Mango');

SELECT * FROM Order_tbl

WITH ItemCounts
AS(
SELECT Order_Date,Item,COUNT(*) AS Order_Count
FROM Order_tbl				
GROUP BY Order_Date,Item
),
MaxCounts
AS(
  SELECT Order_Date,MAX(Order_Count) AS Max_count
  FROM ItemCounts
  GROUP BY Order_Date
  )
SELECT I.Order_date,I.Item,I.Order_Count
FROM ItemCounts I 
JOIN MaxCounts M
ON I.Order_Date = M.Order_Date AND I.Order_Count = M.Max_count
ORDER BY I.Order_Date,I.Item;

-- Another method

WITH CTE
AS(
SELECT Order_Date,Item,COUNT(*) AS Order_Count,RANK() OVER(PARTITION BY Order_Date ORDER BY COUNT(*) DESC) AS Ranked_item
FROM Order_tbl
GROUP BY Order_Date,Item
)
SELECT Order_Date,Item,Order_count
FROM CTE
WHERE Ranked_item = 1
ORDER BY Order_Date;

/*
Company Name:- Capgemini

Given a Teams table with a columns TeamID(Integer) abd Members(comma-separated string of names), Write a query to calculate and display the total number of memebers in each team

Input Table
-------------------------------------------------------------------------
Team_ID             Memebers
-------------------------------------------------------------------------
1                 Chris, Evan,Marty,Eva          
2                 Jake, Olivia
3			      Sophia, Liam, Noah, Emma
4				  Ava, Lucas, Mia, Ethan, Amelia
5                 Benjamin, Chariotte
6				  Harper, Henry, Evelyn, Deniel,Ella
7                 Micheal,Emily,Alexander
8                 James,Abigail,William,Isabella,Jack,Grace
9				  Sebastian,Chloe
10                David, lily,Samuel,Madison
-------------------------------------------------------------------------


Expected Output
----------------------------------------------------------------------------------------------------------
Team_ID             Memebers												Total_Members
----------------------------------------------------------------------------------------------------------
1                 Chris, Evan,Marty,Eva												4
2                 Jake, Olivia														2				
3			      Sophia, Liam, Noah, Emma											4			
4				  Ava, Lucas, Mia, Ethan, Amelia									5	
5                 Benjamin, Chariotte												2
6				  Harper, Henry, Evelyn, Deniel,Ella								5
7                 Micheal,Emily,Alexander											3
8                 James,Abigail,William,Isabella,Jack,Grace							6
9				  Sebastian,Chloe													2
10                David,lily,Samuel,Madison											4					
----------------------------------------------------------------------------------------------------------
*/

CREATE TABLE Teams(
				TeamID INT,
				Members VARCHAR(150)
				)

INSERT INTO Teams VALUES(1,'Chris, Evan, Marty, Eva'),(2,'Jake, Olivia'),(3,'Sophia, Liam, Noah, Emma'),(4,'Ava, Lucas,  Mia, Ethan, Amelia'),
(5,'Benjamin, Chariotte'),(6,'Harper, Henry, Evelyn, Deniel,Ella'),(7,'Micheal, Emily, Alexander'),(8,'James, Abigail, William, Isabella, Jack, Grace'),
(9,'Sebastian, Chloe'),(10,'David, lily, Samuel, Madison')

SELECT * FROM Teams

SELECT TeamID,Members,LEN(Members) - LEN(REPLACE(Members,',','')) + 1 AS Total_Memebers
FROM Teams;

/*
Write a SQL query to reterieve the most frequently ordered item(s) for each date from a given orders table. If multiple item have the highest order count on a
particular date, include all such items in the result.

Input Table
-----------------------------
Order_Date          Item
-----------------------------
2024-03-01          Apple
2024-03-01          Banana
2024-03-01          Apple
2024-03-02          Orange
2024-03-02          Orange
2024-03-02          Mango
2024-03-03          Banana
2024-03-03          Banana
2024-03-03          Mango
-----------------------------

Expected Output
-------------------------------------
Order_Date     Item     Order_Count
-------------------------------------
2024-03-01      Apple        2
2024-03-02      Orange       2
2024-03-03      Banana       2
2024-03-03      Mango        2
-------------------------------------
*/

CREATE TABLE Orders_tbl(
					Order_Date DATE,
					Item VARCHAR(15)
					)

INSERT INTO Orders_tbl VALUES('2024-03-01','Apple'),('2024-03-01','Banana'),('2024-03-01','Apple'),('2024-03-02','Orange'),('2024-03-02','Orange'),
('2024-03-02','Mango'),('2024-03-03','Banana'),('2024-03-03','Banana'),('2024-03-03','Mango')

SELECT * FROM Order_tbl

WITH Total_orders
AS(
SELECT Order_Date,Item,COUNT(*) AS orders_count,RANK() OVER(PARTITION BY Order_Date ORDER BY COUNT(*) DESC) AS Ranked_item
FROM Order_tbl
GROUP BY Order_Date,Item
)
SELECT Order_Date,Item,orders_count
FROM Total_orders
WHERE Ranked_item = 1 
ORDER BY Order_Date

-- Top 10 Question asked in interview

CREATE TABLE Orders_tbls(
					Order_ID INT,
					User_ID INT,
					Order_Date DATE,
					Ship_Date DATE,
					Order_status VARCHAR(20),
					Product_Category VARCHAR(50),
					Payment_method VARCHAR(20),
					Order_Amount DECIMAL(10,2),
					City VARCHAR(50),
					State VARCHAR(50)
					);


INSERT INTO Orders_tbls VALUES(120, 3, '2024-02-17', '2024-02-20', 'Delivered', 'Electronics', 'Credit Card', 9999.00, 'Jaipur', 'Rajasthan'),
(119, 10, '2024-02-15', '2024-02-17', 'Delivered', 'Beauty', 'Net Banking', 699.00, 'Lucknow', 'Uttar Pradesh'),
(118, 4, '2024-02-13', '2024-02-16', 'Delivered', 'Home Decor', 'Wallet', 799.00, 'Pune', 'Maharashtra'),
(117, 2, '2024-02-11', '2024-02-14', 'Delivered', 'Electronics', 'Credit Card', 15999.00, 'Delhi', 'Delhi'),
(116, 7, '2024-02-09', '2024-02-13', 'Returned', 'Books', 'Net Banking', 599.00, 'Chennai', 'Tamil Nadu'),
(115, 9, '2024-02-08', '2024-02-11', 'Delivered', 'Fashion', 'Wallet', 1999.00, 'Kolkata', 'West Bengal'),
(114, 6, '2024-02-07', '2024-02-10', 'Delivered', 'Beauty', 'Credit Card', 499.00, 'Ahmedabad', 'Gujarat'),
(113, 5, '2024-02-06', '2024-02-09', 'Cancelled', 'Fashion', 'COD', 1299.00, 'Bangalore', 'Karnataka'),
(112, 8, '2024-02-04', '2024-02-07', 'Delivered', 'Home Decor', 'Net Banking', 1999.00, 'Hyderabad', 'Telangana'),
(111, 3, '2024-02-02', '2024-02-04', 'Delivered', 'Books', 'COD', 699.00, 'Jaipur', 'Rajasthan'),
(110, 1, '2024-02-01', '2024-02-03', 'Delivered', 'Electronics', 'Credit Card', 12999.00, 'Mumbai', 'Maharashtra'),
(109, 7, '2024-01-28', '2024-01-30', 'Delivered', 'Beauty', 'Wallet', 799.00, 'Chennai', 'Tamil Nadu'),
(108, 6, '2024-01-25', '2024-01-28', 'Delivered', 'Fashion', 'Net Banking', 999.00, 'Ahmedabad', 'Gujarat'),
(107, 5, '2024-01-22', '2024-01-25', 'Returned', 'Books', 'Credit Card', 399.00, 'Bangalore', 'Karnataka'),
(106, 2, '2024-01-20', '2024-01-22', 'Delivered', 'Books', 'COD', 499.00, 'Delhi', 'Delhi'),
(105, 4, '2024-01-15', '2024-01-19', 'Delivered', 'Electronics', 'Credit Card', 8999.00, 'Pune', 'Maharashtra'),
(104, 3, '2024-01-10', '2024-01-12', 'Delivered', 'Fashion', 'Wallet', 1499.00, 'Jaipur', 'Rajasthan'),
(103, 1, '2024-01-05', '2024-01-07', 'Returned', 'Home Decor', 'Net Banking', 499.00, 'Mumbai', 'Maharashtra'),
(102, 2, '2024-01-02', '2024-01-06', 'Cancelled', 'Fashion', 'COD', 2999.00, 'Delhi', 'Delhi'),
(101, 1, '2024-01-01', '2024-01-03', 'Delivered', 'Electronics', 'Credit Card', 19999.00, 'Mumbai', 'Maharashtra');


SELECT * FROM Orders_tbls

--1. Calculate the average delivery time (in days) for each product_category, only for delivery orders.

SELECT Product_category,AVG(DATEDIFF(DAY,Order_Date,Ship_Date)) AS Delivery_time
FROM Orders_tbls
WHERE Order_status = 'Delivered'
GROUP BY Product_category

--2. Find the top 3 states with the highest total order value in january 2024.

SELECT TOP 3 State,DATENAME(MONTH, Order_Date) AS Months,SUM(Order_Amount) AS Highest_Order_amount
FROM Orders_tbls
WHERE MONTH(Order_Date) = 1 AND YEAR(Order_Date) = 2024
GROUP BY State,DATENAME(MONTH, Order_Date)
ORDER BY Highest_Order_amount DESC

--3. Identify users who have placed orders using at least 2 different payment methods.

SELECT DISTINCT User_ID,Payment_method
FROM Orders_tbls
WHERE User_ID IN (
				 SELECT User_ID
				 FROM Orders_tbls
				 GROUP BY User_ID
				 HAVING COUNT(DISTINCT Payment_method) >= 2
				 )	
ORDER BY User_ID


--4. Calculate the month-over-month growth in total orders values.

WITH MonthlyTotals 
AS (
SELECT YEAR(Order_Date) AS Yr,MONTH(Order_Date) AS Mn,SUM(Order_Amount) AS Total_Order_Value
FROM Orders_tbls
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
)
SELECT Yr,DATENAME(MONTH, DATEFROMPARTS(Yr, Mn, 1)) AS Month_Name,Total_Order_Value,LAG(Total_Order_Value, 1, 0) OVER (ORDER BY Yr, Mn) AS Prev_Month_Value,
Total_Order_Value - LAG(Total_Order_Value, 1, 0) OVER (ORDER BY Yr, Mn) AS MOM_Growth_Value,
   CASE 
       WHEN LAG(Total_Order_Value, 1, 0) OVER (ORDER BY Yr, Mn) = 0 THEN NULL
        ELSE ROUND((Total_Order_Value - LAG(Total_Order_Value, 1, 0) OVER (ORDER BY Yr, Mn)) * 100.0 /LAG(Total_Order_Value, 1, 0) OVER (ORDER BY Yr, Mn), 2)
END AS MOM_Growth_Percent
FROM MonthlyTotals
ORDER BY Yr, Mn;


-- Another Method
SELECT YEAR(Order_Date) AS Yr,MONTH(Order_Date) as Mn,SUM(Order_Amount) AS Total_Amount_value,
SUM(Order_Amount) - LAG(SUM(Order_Amount)) OVER(ORDER BY YEAR(Order_Date),MONTH(Order_Date)) AS MoM_Growth
FROM Orders_tbls
GROUP BY YEAR(Order_Date),MONTH(Order_Date)
ORDER BY Yr,Mn

--5. Determine the cummulative order amount per users ordered by order_date

SELECT *,SUM(Order_Amount) OVER(PARTITION BY User_ID ORDER BY Order_date) AS Cumm_Orders
FROM Orders_tbls

--6.For each product_category, calculate the percentage of orders that were returned.

SELECT Product_Category,CAST(ROUND(100.0 * SUM(CASE WHEN Order_status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*),2) AS DECIMAL(10,2)) AS Returned_Percentage
FROM Orders_tbls
GROUP BY Product_Category

--7.Rank Cities within each state based on their total orders value.

WITH Cities_rank
AS(
SELECT City,State,SUM(Order_Amount) AS Total_orders
FROM Orders_tbls
GROUP BY City,State
)
SELECT City,State,RANK() OVER(PARTITION BY State ORDER BY Total_orders DESC) AS RNK
FROM Cities_rank

--8.Find the records rate: the percentage of users who placed more than one orders.

SELECT CAST(COUNT(*) AS DECIMAL(10,2)) / (SELECT CAST(COUNT(DISTINCT User_ID) AS DECIMAL(10,2)) FROM Orders_tbls) * 100 AS Percentage_of_users
FROM (
SELECT User_ID
FROM Orders_tbls
GROUP BY User_ID
HAVING COUNT(DISTINCT Order_ID) > 1
) A

--9.Among the top 1 users by total spend, and their most frequently ordered product category.

WITH User_spend
AS(
SELECT User_ID, SUM(Order_Amount) AS Total_sepnd
FROM Orders_tbls
GROUP BY User_ID
),
Top_Users AS(
SELECT TOP 1 USER_ID
FROM User_spend
ORDER BY Total_sepnd DESC
),
User_category AS(
			    SELECT O.User_ID,O.Product_Category,COUNT(*) AS Category_count
				FROM Orders_tbls O
				INNER JOIN Top_Users T ON O.User_ID = T.User_ID
				GROUP BY O.User_ID,o.Product_Category
				)
SELECT TOP 1 USER_ID,Product_Category,Category_Count
FROM User_category
ORDER BY Category_Count DESC;

--Another method

WITH User_spend
AS(
SELECT User_ID,SUM(Order_Amount) AS Total
FROM Orders_tbls
GROUP BY User_ID
)
SELECT TOP 1 Product_Category
FROM Orders_tbls
WHERE USER_ID = (SELECT TOP 1 User_ID FROM User_spend ORDER BY Total DESC)
GROUP BY Product_Category 
ORDER BY COUNT(Order_ID) DESC;

--10.Calculate the average order value for each payment method, excluding cancelled and return orders.

SELECT Payment_method,AVG(Order_Amount) AS Avg_orders
FROM Orders_tbls
WHERE Order_status NOT IN ('Cancelled','Returned')
GROUP BY Payment_method
ORDER BY Avg_orders DESC

