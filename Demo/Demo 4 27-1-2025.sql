--Datetime, System databases,schema,ddl(create, alter, drop, use)

--###########################################################
--Self learning 
	https://learn.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver16
--XML data in SQL Server
	https://learn.microsoft.com/en-us/sql/relational-databases/xml/xml-data-sql-server?view=sql-server-ver16
--JSON data in SQL Server
	https://learn.microsoft.com/en-us/sql/relational-databases/json/json-data-sql-server?view=sql-server-ver16
--###########################################################
--Datetime 
--Timestamp 'YYYY-MM-DD HH:MM:SS'
--Date (3 byte)
	--input ='YYYY-MM-DD' or 'MM-DD-YYYY'
	--Output ='YYYY-MM-DD'
		
	Declare @value  date
	Set @value='01-27-2025'
	Select @value as Number, datalength(@value) As Byte
			
	Declare @value  date
	Set @value='2025-01-27'
	Select @value as Number, datalength(@value) As Byte
	
	Declare @value  date
	Set @value='27-01-2025'
	Select @value as Number, datalength(@value) As Byte
			
--time(5 byte)	
	--input 'HH:MM:SS'
	--output'HH:MM:SS:MMMMMMM'

	Declare @value time
	Set @value='00:20:51'
	Select @value as Number, datalength(@value) As Byte

--Timestamp 'YYYY-MM-DD HH:MM:SS'
--Smalldatetime(4 byte)'YYYY-MM-DD HH:MM:SS'
	Declare @value  Smalldatetime
	Set @value=getdate()
	Select @value as Number, datalength(@value) As Byte

--datetime(8 byte), 'YYYY-MM-DD HH:MM:SS:mmm'3 milisecond info	
	Declare @value1  datetime2
	Set @value1=getdate()
	Select @value1 as Number, datalength(@value1) As Byte		
			

--datetime2(8 byte), 'YYYY-MM-DD HH:MM:SS:mmmMMMM'7 milisecond info
	Declare @value  datetime2
	Set @value='27 jan 25 21:12:51:987'
	Select @value as Number, datalength(@value) As Byte		
			
--##################################################
--System Databases
https://learn.microsoft.com/en-us/sql/relational-databases/databases/system-databases?view=sql-server-ver16

--master Database(Critical)
	--Records all the system-level information for an instance of SQL Server.

--model Database	
	--Is used as the template for all databases created on the instance of SQL Server.

	--Syntax:	create database databasename 
	create database demo 
		--how many  files 
		--size of files
		--path of files 
		--name of files

--msdb Database	
	--Is used by SQL Server Agent for scheduling alerts and jobs.

--tempdb Database(Critical)	
	--Is a workspace for holding temporary objects or intermediate result sets.
	--temporary data,  It resets every time the SQL Server restarts.


--Resource Database	
	--Is a read-only database that contains system objects that are included with SQL Server. 

	https://learn.microsoft.com/en-us/sql/relational-databases/databases/resource-database?view=sql-server-ver16
	--Installation drive>:\Program Files\Microsoft SQL Server\MSSQL<version>.<instance_name>\MSSQL\Binn\ 
	--Name  =  mssqlsystemresource


--##########################################################
select * from sys.time_zone_info
--##################################################
--System Databases
https://learn.microsoft.com/en-us/sql/relational-databases/databases/system-databases?view=sql-server-ver16

--master Database(Critical)
	--Records all the system-level information for an instance of SQL Server.

--model Database	
	--Is used as the template for all databases created on the instance of SQL Server.

	--Syntax:	create database databasename 
	create database SQLDEMO 
	create database  DEMO 
		--how many  files 
		--size of files
		--path of files 
		--name of files

--msdb Database	
	--Is used by SQL Server Agent for scheduling alerts and jobs.

--tempdb Database(Critical)	
	--Is a workspace for holding temporary objects or intermediate result sets.
	--temporary data,  It resets every time the SQL Server restarts.


--Resource Database	
	--Is a read-only database that contains system objects that are included with SQL Server. 

	https://learn.microsoft.com/en-us/sql/relational-databases/databases/resource-database?view=sql-server-ver16
	--Installation drive>:\Program Files\Microsoft SQL Server\MSSQL<version>.<instance_name>\MSSQL\Binn\ 
	--Name  =  mssqlsystemresource

--#################################################
--DDL(Data Definition Language)
--create.
	--Create database
		--Syntax: create database DatabaseName
		create database Hello
		
		create database world

		create database [hello world]
		
		create database [1sql]

[] = Qoute identifier


--Task to create table employee (eid, ename , age , gender, salary) 
--ondb= hello
--SYNATX:
		--CREATE TABLE table_name (column1_name datatype ,column2_name datatype,column3_name datatype,...)
--Current database name =master

use hello

create table employee (eid int, ename varchar(10), age tinyint, gender char(10), salary float)


---#####################################################################################################


--QUESTION TO PRACTICE 
--step 1
	Create database school 
--step 2
	use school
--step 3

--1. Teachers Table:
	--Columns: TeacherID int, Name varchar(20), Age int , Class varchar(20)
	create table Teachers (TeacherID int, Name varchar(20), Age int , Class varchar(20))

--2. Students Table:
	--Columns: StudentID, FirstName, LastName, Age, Class, TeacherID
	
--3. Courses Table:
	--Columns: CourseID, CourseName, Department, TeacherID
	
--4. Departments Table:
	--Columns: DepartmentID, DepartmentName
	
--5. Enrollments Table:
	--Columns: EnrollmentID, StudentID, CourseID, EnrollmentDate
	
--6. Teachers_Departments Table:
	--Columns: TeacherDepartmentID, TeacherID, DepartmentID
	
----*****************************************************************************************
--practice question
 Create database hospital

 Use hospital

-- 1. Doctors Table:
   -- Columns: DoctorID, FirstName, LastName, Specialization, Age
  create table Doctors ( DoctorID int , FirstName varchar(20), LastName varchar(20), Specialization  varchar(20), Age int)
-
-- 2. Patients Table:
   -- Columns: PatientID, FirstName, LastName, Age, AdmissionDate, DischargeDate, DoctorID
   
-- 3. Departments Table:
   -- Columns: DepartmentID, DepartmentName, HeadDoctorID
   
-- 4. Nurses Table:
   -- Columns: NurseID, FirstName, LastName, Age, DepartmentID
   
-- 5. Medications Table:
   -- Columns: MedicationID, MedicationName, Dosage
   
-- 6. Prescriptions Table:
   -- Columns: PrescriptionID, PatientID, DoctorID, MedicationID, PrescribedDate, DosageInstructions
   




























































































































































