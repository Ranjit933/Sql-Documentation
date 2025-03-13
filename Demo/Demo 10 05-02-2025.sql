--index,primary  key, composite key  , unique , foreign key, 
--#########################################################################
	create database SQLDemo	
	go
	use SQLDemo	
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


	select * from department 
--Syntax: Create clustered Index Indexname  on tablename(column name Asc/desc)
	Create clustered Index CI_DID  on department(did)
	
	
	select * from department 
	
Create  nonclustered Index NCI_three  on department(ename,salary,dept)

	select ename,salary,dept  from department where
	ename='Kate' and salary=7500 and dept='IT'

---#######################################################
--primary key(unique + not null)// column (or a set of columns)
	-- 1 primary key in 1 table  & 1 CLUSTERED INDEX (SORT & STORE, SEEK FASTER)

--unique(999 UK IN 1 TABLE)
 	--NON CLUSTERED INDEX (SEEK FASTER)

	CREATE TABLE emp
	(
		did INT primary key,
		ename VARCHAR(50) ,
		gender VARCHAR(50) ,
		phnum INT unique,
		dept VARCHAR(50) 
	)

	INSERT INTO emp VALUES
	  (1, 'David', 'Male', 5000, 'Sales'),
	  (5, 'Shane', 'Female', 5500, 'Finance'),
	  (6, 'Shed', 'Male', 8000, 'Sales'),
	  (7, 'Vik', 'Male', 7200, 'HR'),
	  (2, 'Jim', 'Female', 6000, 'HR'),
	  (13, 'Julie', 'Female', 7100, 'IT'),
	  (14, 'Elice', 'Female', 6800,'Marketing'),
	  (3, 'Kate', 'Female', 7500, 'IT'),
	  (4, 'Will', 'Male', 6510, 'Marketing'),
	  (10, 'Laura', 'Female', 6300, 'Finance'),
	  (11, 'Mac', 'Male', 5700, 'Sales'),
	  (12, 'Pat', 'Male', 7000, 'HR'),
	  (8, 'Vince', 'Female', 6600, 'IT'),
	  (9, 'Jane', 'Female', 5400, 'Marketing'),
	  (15, 'Wayne', 'Male', 6810, 'Finance')

	  select * from emp
	  
--############################################# 
	CREATE TABLE hr  
		(did INT  ,
		ename VARCHAR(50) ,
		gender VARCHAR(50) ,
		phnum INT ,
		dept VARCHAR(50) 
		CONSTRAINT PK_TWO PRIMARY  KEY (DID,PHNUM)
		)

	INSERT INTO hr  VALUES
	  (1, 'David', 'Male', 7200, 'Sales'),
	  (2, 'Shane', 'Female', 5500, 'Finance'),
	  (1, 'Shed', 'Male', 8000, 'Sales'),
	  (2, 'Vik', 'Male', 7200, 'HR'),
	  (3, 'Jim', 'Female', 5500, 'HR')

	  SELECT * FROM hr

--DID+PHNUM
	ALTER TABLE hr 
	ALTER COLUMN DID INT NOT NULL


	ALTER TABLE hr 
	ALTER COLUMN PHNUM INT NOT NULL

	
	ALTER TABLE hr 
	ADD CONSTRAINT PK_TWO PRIMARY  KEY (DID,PHNUM)


--FIND DUPLICATES 
	  SELECT DID , COUNT(*) FROM hr GROUP BY DID HAVING  COUNT(*)>1 


--Foreign key -->(Primary key  or unique )
	 --Refrential integrity --> add records (Primary , unique)
	 --Cascading integrity --> delete (foreign key)

	 CREATE TABLE Employees (
		EmployeeID INT primary key  ,
		FirstName NVARCHAR(50),
		LastName NVARCHAR(50)	)

	CREATE TABLE Users (
		UserID INT primary key    ,
		Email NVARCHAR(100) unique,
		Username NVARCHAR(50)	)

	CREATE TABLE Orders (
		OrderID INT PRIMARY KEY,
		OrderDate DATE ,
		CustomerID INT,
		EID INT ,
		Email NVARCHAR(100) , 
		FOREIGN KEY (Email ) REFERENCES Users  (Email )
		on delete no action 
		on update no action
		)

--Refrential integrity --> add records (Primary , unique)
--WE NEED TO INSERT INTO pRIMARY KEY / UNIQUE COLUMN FIRST
	INSERT INTO Employees VALUES 
	(1, 'John', 'Doe'),
	(2, 'Jane', 'Smith'),
	(3, 'Michael', 'Johnson'),
	(4, 'Emily', 'Davis'),
	(5, 'Chris', 'Brown')

	INSERT INTO Users VALUES 
	(1, 'john.doe@example.com', 'johndoe'),
	(2, 'jane.smith@example.com', 'janesmith'),
	(3, 'michael.johnson@example.com', 'mikejohnson'),
	(4, 'emily.davis@example.com', 'emilydavis'),
	(5, 'chris.brown@example.com', 'chrisbrown')

	INSERT INTO Orders VALUES 
	(1, '2024-08-15', 1, 1, 'john.doe@example.com'),
	(2, '2024-08-16', 2, 2, 'jane.smith@example.com'),
	(3, '2024-08-17', 3, 3, 'michael.johnson@example.com'),
	(4, '2024-08-18', 4, 4, 'emily.davis@example.com'),
	(5, '2024-08-19', 5, 5, 'chris.brown@example.com'),
	(6, '2024-08-15', 1, 1, 'john.doe@example.com'),
	(7, '2024-08-16', 2, 2, 'jane.smith@example.com'),
	(8, '2024-08-17', 3, 3, 'michael.johnson@example.com')


	SELECT * FROM Employees;
	SELECT * FROM Users;
	SELECT * FROM Orders;


--Cascading integrity --> delete (foreign key)
	delete FROM Employees;	--PK	
	delete FROM Users		--UK
	delete FROM Orders		--FK


	DROP TABLE  Employees;
	DROP TABLE Users;
	DROP TABLE Orders;


--#################################################
begin tran 
	update Users    set email = 'christien.brown@example.com'    where email ='chris.brown@example.com'    update Orders    set email = 'christien.brown@example.com'    where email ='chris.brown@example.com'



--##################################

CREATE TABLE Countries
 
(CountryID INT PRIMARY KEY,
CountryName VARCHAR(50),
CountryCode VARCHAR(3))
 
 
CREATE TABLE States
 
(StateID INT PRIMARY KEY,
StateName VARCHAR(50),
StateCode VARCHAR(3),
CountryID INT)
 
 --Add foreign key in exisitng table 

	 alter table states 
	 add constraint fk_sid  foreign key (countryid) references  Countries(CountryID)
		on delete cascade
		on update cascade


	INSERT INTO Countries VALUES (1,'United States','USA')
	 INSERT INTO Countries VALUES (2,'United Kingdom','UK')
 
	INSERT INTO States VALUES (1,'Texas','TX',1)
	INSERT INTO States VALUES (2,'Arizona','AZ',1)


	select * from Countries
	select * from States

	delete from Countries where 


		update Countries
		set countryid =101 
		where CountryID=1































































































