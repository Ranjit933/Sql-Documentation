--order by ,top offset fetch, aggregate functions,group by having 
--###################################################
--self learning 
https://learn.microsoft.com/en-us/training/modules/transform-data-by-implementing-pivot-unpivot-rollup-cube/
	use AdventureWorks2022


	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person

--Filter numeric data 
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where BusinessEntityID between 999 and 2000
	 	 	 
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where ModifiedDate between '2011-07-01' and '2012-06-21'
	
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where ModifiedDate between '07-01-2011' and '06-21-2012'
--#####################
--Where like ( % _)
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like 'A%'

	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like 'Ann%'
	
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where BusinessEntityID like '1111%'
		
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where ModifiedDate like '%2014%'
		
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like '%ed'
	
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where BusinessEntityID like '%911'

--like using _

	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like '_'
	
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like '__'

	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like '___'

	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like '____'

--Combine % & _

	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like 'C__s%'
	
	select BusinessEntityID,FirstName,LastName,ModifiedDate from Person.Person
	where FirstName like '%_v_'

---#########################################
create database SQLDEMO
use SQLDEMO

CREATE TABLE department
	  (
		  did INT,
		  [name] VARCHAR(50) ,
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

	SELECT did,[name],gender,salary,dept
	FROM Department

--order by column asc, column desc
	SELECT did,[name],gender,salary,dept
	FROM Department order by  did asc

	SELECT did,[name],gender,salary,dept
	FROM Department order by  [name] asc

	SELECT did,[name],gender,salary,dept
	FROM Department order by  did desc

	SELECT did,[name],gender,salary,dept
	FROM Department order by  [name] desc
		
	SELECT did,[name],gender,salary,dept
	FROM Department order by  did asc

 
	SELECT did,[name],gender,salary,dept
	FROM Department order by  did asc, [name] asc

use AdventureWorks2022

	select FirstName, LastName, ModifiedDate 
	from  Person.person order by FirstName asc

	select FirstName, LastName, ModifiedDate 
	from  Person.person order by FirstName asc, LastName asc
		
	select FirstName, LastName, ModifiedDate 
	from  Person.person order by FirstName asc, LastName desc


---######################################
--Top n
	select  * 	from  Person.person order by BusinessEntityID asc

--lowest BusinessEntityID in table
	select  top 1 * 	from  Person.person order by BusinessEntityID asc

--highest BusinessEntityID in table
	select  top 1 * 	from  Person.person order by BusinessEntityID desc



	select  top 1 title	from  Person.person
	where title is not null order by BusinessEntityID asc

---OFFSET(SKIP) & fetch 
		SELECT column1, column2, ...
		FROM table_name
		ORDER BY column_name
		OFFSET n ROWS       -- Skip the first 'n' rows
		FETCH NEXT m ROWS ONLY; -- Then fetch the next 'm' rows


	select   *  from  Person.person
	order by BusinessEntityID asc
 
--SKIP 10 ROWS 
	select    *  from  Person.person
	order by BusinessEntityID asc
	OFFSET 10 ROWS
	FETCH  NEXT 1 ROWS ONLY
	
	select    *  from  Person.person
	order by BusinessEntityID DESC
	OFFSET 10 ROWS
	FETCH  NEXT 1 ROWS ONLY

	select    *  from  Person.person
	order by BusinessEntityID ASC
	OFFSET 1 ROWS
	FETCH  NEXT 1 ROWS ONLY
		
	select    *  from  Person.person
	order by BusinessEntityID ASC
	OFFSET 1 ROWS
	FETCH  NEXT 5 ROWS ONLY
	   	 
	select    *  from  Person.person
	order by BusinessEntityID DESC
	OFFSET 1 ROWS
	FETCH  NEXT 15 ROWS ONLY

	select    *  from  Person.person
	WHERE TITLE IS NOT NULL
	order by BusinessEntityID DESC
	OFFSET 5 ROWS		--SKIP
	FETCH  NEXT 986 ROWS ONLY --LIMIT

	select    *  from  Person.person
	WHERE column_to_order_by > 'cursor_value' 
	order by BusinessEntityID DESC
	OFFSET 20 ROWS
	FETCH  NEXT 10 ROWS ONLY --LIMIT

--#####################################
--Aggregate function 
--COUNT(*): Counts the number of rows in a dataset include the null values .

	select  COUNT(*) AS COUNTS  from  Person.person

--COUNT(column_name) counts non-NULL values in a specified column.
	select  COUNT(FirstName) AS COUNTS  from  Person.person
	select  COUNT(MiddleName) AS COUNTS  from  Person.person
	select  COUNT(TITLE) AS COUNTS  from  Person.person

--MAX()value from a column.(non-NULL values in a specified column.)
	select  MAX(FirstName) AS MAX_VAL  from  Person.person
	select  MAX(ModifiedDate) AS MAX_VAL  from  Person.person
	select  MAX(BusinessEntityID) AS MAX_VAL  from  Person.person
--MIN ()value from a column.(non-NULL values in a specified column.)

	select  MIN(FirstName) AS MIN_VAL  from  Person.person
	select  MIN(ModifiedDate) AS MIN_VAL  from  Person.person
	select  MIN(BusinessEntityID) AS MIN_VAL  from  Person.person

--Sum  & average (work with numeric data only)
--AVG() value from a column.(non-NULL values in a specified column.)



	select  AVG(BusinessEntityID) AS AVG_VAL  from  Person.person

--SUM()value from a column.(non-NULL values in a specified column.)

	select  SUM(BusinessEntityID) AS SUM_VAL  from  Person.person

	USE sqldemo

	 
	select 
	Count(*) as Counts,
	MAX(did) as Maxval ,
	Min(did) as Minval ,
	avg(did) as Avgal ,
	sum(salary) as total  
	FROM Department

--##########################################

  SELECT did,name,gender,salary,dept FROM Department

--GROUP BY(BREAK MY RESULTSET INTO SUBSET) 

	SELECT did  FROM Department GROUP BY  DID
	SELECT  name  FROM Department GROUP BY name
	SELECT  salary  FROM Department GROUP BY salary
--DUPLICATE DATA
	SELECT  gender  FROM Department GROUP BY gender
	SELECT  dept FROM Department GROUP BY dept

	SELECT  gender , COUNT(*) AS Counts FROM Department GROUP BY gender
	SELECT  dept ,sum(salary) as total FROM Department GROUP BY dept
	   	
	SELECT  dept,gender , COUNT(*) AS Counts,sum(salary) as total
	FROM Department 
	GROUP BY dept,gender
		
	SELECT  dept,gender , COUNT(*) AS Counts,sum(salary) as total
	FROM Department 
	GROUP BY gender,dept 

--filter the aggregates
	SELECT  dept,gender , COUNT(*) AS Counts,sum(salary) as total
	FROM Department 
	GROUP BY gender,dept 
	having sum(salary) >=10000
		
	SELECT  dept,gender , COUNT(*) AS Counts,sum(salary) as total
	FROM Department 
	GROUP BY gender,dept 
	having gender='male'

	SELECT  dept,gender , COUNT(*) AS Counts,sum(salary) as total
	FROM Department 
	GROUP BY gender,dept 
	having COUNT(*)=3

	SELECT  dept,gender , COUNT(*) AS Counts,sum(salary) as total
	FROM Department 
	where gender='male'
	GROUP BY gender,dept 
	having sum(salary) >=10000 or count(*) >2
	order by sum(salary) desc


  --LOGICAL PROCESSING ORDER OF THE SELECT  STATEMENT 
  --Sequence to execute in sql server 
	  --FROM
	  --ON 
	  --JOIN
	  --WHERE
	  --GROUP BY 
	  --WITH (CUBE/ ROLLUP)
	  --HAVING 
	  --SELECT 
	  --DISTINCT
	  --ORDER BY 
	  --TOP 

--generate the subtotal aand granttotal
--of the gender,dept  in the department table
https://learn.microsoft.com/en-us/training/modules/transform-data-by-implementing-pivot-unpivot-rollup-cube/
--
































































































































































































