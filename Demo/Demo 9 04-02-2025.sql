--Constraint ( not null , check,default, UNIQUE ), index,
--#######################################################
	create database Demo	
	go
	use Demo	
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
	(1, 'David', 'Male', -5000, 'Sales'),
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
	(15, 'Wayne', 'Male', 6800, 'Finance'),	
	(NULL,NULL,NULL,NULL, NULL)

	select * from department order by did asc
--Constraint 
	--Duplicate data		--> Unique key 
	--null values			--> Not Null			
	--values out of range	-->	check() 
	--default				--> default

CREATE TABLE emp
	(
		eid INT not null unique,
		ename VARCHAR(50) not null ,
		gender VARCHAR(50)  not null ,
		salary INT  not null check (if gender='male' salary<50000 and if gender='female' salary<50000),
		phnum VARCHAR(50)  not null check (len(phnum)=10 and phnum like '[0-9]%' and  phnum like '9%'),
		dept VARCHAR(50) not null default 'Support'
	)

--Table defintion 
	sp_help emp


 
	INSERT INTO emp  VALUES
	(1, 'David', 'Male',  5000, 9234567890,'Sales'),
	(5, 'Shane', 'Female',  5500,9234567890, 'Finance'),
	(6, 'Shed', 'Male', 8000,9234567890, 'Sales'),
	(7, 'Vik', 'Male', 7200,9234567890, 'HR')


select * from emp
--Cannot insert duplicate key in object 
	INSERT INTO emp  VALUES
	(1, 'David', 'Male',  5000, 9234567890,'Sales')
--Null values(column does not allow nulls.) 
	INSERT INTO emp  VALUES
	(null, null ,'Male',  5000, 9234567890,'Sales')

--conflicted with the CHECK constraint(salary)
	INSERT INTO emp  VALUES
	(2, 'David', 'Male',  5999, 9234567890,'Sales')

--conflicted with the CHECK constraint(phnum)	
	INSERT INTO emp  VALUES
	(3, 'David', 'Male',  5999, 92347890,'Sales')
--Column name or number of supplied values does not match table definition.
	INSERT INTO emp([eid], [ename], [gender], [salary], [phnum])  VALUES
	(4, 'David', 'Male',  5999, 9234567890)
	
select * from emp




select * from [dbo].[Department]

delete from [dbo].[Department]


--Not null 
	alter table department 
	Alter column did int not null

--Unique key  
	alter table department 
	add constraint uk_did unique(did)

--Check 
	alter table department 
	add constraint CK_Sal check(salary>=5000)

--Default
	alter table department 
	add constraint dfdept  default  'unknown' for dept




CREATE TABLE test
	(
		eid INT not null unique,
		ename VARCHAR(50) not null ,
		gender VARCHAR(50)  not null ,
		salary INT  not null ,
		dept VARCHAR(50) not null default 'Support',
		 constraint ck_sssal check (( gender='male'  and salary<=50000 )or(  gender='female' and salary<=50000))
	)

--Indexing 
CREATE TABLE Dep  (
		  did INT    ,
		  ename VARCHAR(50) ,
		  gender VARCHAR(50) ,
		  phnum INT  ,
		  dept VARCHAR(50) 
	   )

	INSERT INTO Dep  VALUES
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

   select *  from dep




   select *  from dep where did =1

--Execution plan(cntrl +M)

   select *  from dep where did =1
--Index (search fast , improve the speed of read)
--B+ tree
--Clustered Index
	--Sort and store data  in  (existing & new records)
	--1 clustered index in 1 table
	-- improve the speed of read when searching

--Syntax: Create clustered Index Indexname  on tablename(column name Asc/desc)
	Create clustered Index CI_did 	on dep(did)
	   
   select *  from dep where did =13

   select *  from dep where   ename ='Julie'

--Non Clustered Index
	--999 non clustered index in 1 table
	-- improve the speed of read when searching
--Syntax: Create nonclustered Index Indexname  on tablename(column name)
	Create nonclustered Index CI_ename	on dep(ename)
	

   select  *  from dep where   ename ='Julie'

	select ename,phnum,dept  from dep where
	ename='Kate' and phnum=7500 and dept='IT'

--Composite index 

	Create nonclustered Index CI_three on dep(ename,phnum,dept)
	
	select ename,phnum,dept  from dep where
	ename='Kate' and phnum=7500  

	select ename,phnum,dept  from dep where
	ename='Kate' and dept='IT'

	select ename,phnum,dept  from dep where
	ename='Kate'  
	
	select ename,phnum,dept  from dep where
	  phnum=7500 and dept='IT'



























































































































































































































