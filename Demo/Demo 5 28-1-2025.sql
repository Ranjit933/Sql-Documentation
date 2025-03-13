--ddl(create, alter, drop, use)
--schema, renaming, DML(select , INsert, update, delete, truncate), import/ export
--#################################################
	create database Demo

	use demo

	create table employee (eid INT, ename VARCHAR(20), age tinyint, gender char(10), salary decimal(10,2))

	create table department (eid INT, ename VARCHAR(20), age tinyint, gender char(10), salary decimal(10,2))

--########################################################
--Alter
--Alter to add a column 
/*Syntax:
	alter table tablename 
	add columnname datatype,columnname datatype,.....
*/

--task to add column phnum int
--[Demo]-->[employee]

	alter table employee 
	add phnum int

	alter table employee 
	add email int, desg int

	
--Alter to drop a column 
/*Syntax:
	alter table tablename 
	drop column columnname,columnname
*/ 

	alter table employee 
	drop column gender,ename

--Alter to modify the datatype of a column
/*Syntax:
	alter table tablename 
	alter column columnname datype
*/ 
	alter table employee 
	alter column email char(20)
		
	alter table employee 
	alter column desg varchar(30)

--###############################################
--Drop Table  
	--Syntax: Drop Table TableName
	use Demo
	Drop table employee
	
	use Demo
	Drop table department

--Drop database 
	--Syntax: Drop database name
	USE MASTER
	Drop database Demo

--sp_who2 is used to check the connection details

--##################################################################
--organisation(HR, FIN, SAL, MAR)
	Create database organisation
	
	use organisation
	--hr
	create table t1 (c1 int, c2 int)
	create table t2 (c1 int, c2 int)
	create table t3 (c1 int, c2 int)
	--fin
	create table t4 (c1 int, c2 int)
	create table t5 (c1 int, c2 int)
	create table t6 (c1 int, c2 int)
	--sales
	create table t7 (c1 int, c2 int)
	create table t8 (c1 int, c2 int)
	create table t9 (c1 int, c2 int)
	--mark
	create table t10 (c1 int, c2 int)
	create table t11 (c1 int, c2 int)
	create table t12 (c1 int, c2 int)

--organisation(HR, FIN, SAL, MAR)
	Create database NEWorganisation
	
	use NEWorganisation
	--dbo = default schema
	--hr
	CREATE SCHEMA hr
	create table hr.t1 (c1 int, c2 int)
	create table hr.t2 (c1 int, c2 int)
	create table hr.t3 (c1 int, c2 int)
	--fin
	CREATE SCHEMA fin
	create table fin.t4 (c1 int, c2 int)
	create table fin.t5 (c1 int, c2 int)
	create table fin.t6 (c1 int, c2 int)
	--sales
	CREATE SCHEMA sales
	create table sales.t7 (c1 int, c2 int)
	create table  sales.t8 (c1 int, c2 int)
	create table sales. t9 (c1 int, c2 int)
	--mark
	CREATE SCHEMA mark
	create table mark.t10 (c1 int, c2 int)
	create table mark.t11 (c1 int, c2 int)
	create table mark.t12 (c1 int, c2 int)

--DBO
	
	create table t17 (c1 int, c2 int)
	create table t18 (c1 int, c2 int)
	create table t19 (c1 int, c2 int)

DATABASE --> DBO--> TABLE --> COLUMN

DATABASE --> DBO--> TABLE --> COLUMN
--################################################################

--RENAME A OBJECT
	Create database Demo 

	use Demo

	create table department 
	(eid int, ename varchar(20), age tinyint, gender char(10), salary decimal(10,2))
--create schema
	create schema hr

	create table hr.emp 
	(eid int, ename varchar(20), age tinyint, gender char(10), salary decimal(10,2))
	
	alter schema hr transfer dbo.dept

	alter schema hr transfer dbo.department

--Rename a database 
--Syntax: ALTER DATABASE OldDatabaseName MODIFY NAME = NewDatabaseName
	ALTER DATABASE Demo MODIFY NAME = helloworld

--Caution: Changing any part of an object name could break scripts and stored procedures.

--Rename a Table 
	--Syntax: EXEC sp_rename 'SchemaName.OldTableName', 'NewTableName';
	use helloworld

	EXEC sp_rename 'dbo.department ', 'DEPT'


--Rename a Column
	--Syntax: EXEC sp_rename 'SchemaName.TableName.OldColumnName', 'NewColumnName', 'COLUMN';
	EXEC sp_rename 'hr.emp.eid','depid','column'

		EXEC sp_rename 'hr.emp.age','emp_age','column'


--################################
--database Defnition 
	sp_helpdb [helloworld]

--Table defnition
	sp_help [hr.DEPT]
--################################ 

	Create database SQLDemo 

	use SQLDemo
	
	create table department 
	(eid int, ename varchar(20), age tinyint, gender char(10), salary decimal(10,2))


--DML(Data Manipulation language)
--Select 
	--Syntax: Select Column1,column2, column3,.... from table 
	
	select [eid], [ename], [age], [gender], [salary]  from  department 

	select  [age], [gender], [eid], [ename],[salary]  from  department 
	
	select [eid]  from  department 

	select *  from  department 

	
--Insert
	--Syntax: 
	--Insert into  table(Column1,column2, column3,....)
	--values(value1,value2, value3,....)
	Insert into  department([eid], [ename], [age], [gender], [salary])
	values(101,'alpha',21,'male',123123)

	Insert into  department([age], [gender], [eid], [ename],[salary])
	values(22,'female',102,'beta',2323232)
	
	Insert into  department values
	(103,'charlie',23,'male',4553443)

	Insert into  department values
	(104,'fox',24,'female',654334),
	(106,'echo',24,'female',45774),
	(105,'delta',23,'male',654334),
	(107,'tom,',26,'male',98765)

--Column name or number of supplied values does not match table definition.	
	Insert into  department values
	(108,4553443)	

	Insert into  department([eid], [salary]) values
	(108,4553443)	
--values = empty/absent / not available == NULL
	Insert into  department  values
	(null,null,null,null,null)
		Insert into  department([eid] ) values
	(109 )	
	select *  from  department 

--#################################
























































































