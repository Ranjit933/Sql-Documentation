-- IF , IF ELSE , STORED PROCEDURE, DDL trigger, TCL
--################################################
	Create database  SQLDEMO

	use SQLDEMO

	CREATE TABLE Department
	  (
		  did INT,
		  ename VARCHAR(50) ,
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


	  SELECT * FROM Department


--#######################################################
--conditional statement 
	if 1=1
		print'true'  -- exit
	else
		print'false'-- exit
--#################


	if 1=2
		print'true'  -- exit
	else
		print'false'-- exit


	if 'a'='A'
		print'true'  -- exit
	else
		print'false'-- exit



	if 1=2
		print'true1'  -- exit 
	else if 1=1
		print'true 3'
	else if 1=1
		print'true 4'
	else  if 'a'='A'
		print'true2'  -- exit
	else
		print'false'-- exit
--#############################
	declare @action varchar(20)
	set @action ='Inserts'	

	if @action ='Insert' 
		print'True-Insert '
	else if @action ='Update' 
		print'True Update '
	else if @action ='delete' 
		print'True delete '
	else if @action ='select' 
		print'True select '
	else
		print'False, Invalid action'

--##################################################
	--Grade A: Salary > 7501 
	--Grade B: Salary between 7001 and 7500
	--Grade C: Salary between 6501 and  7000
	--Grade D: Salary between 5000  and 6500
	--Grade E: Salary < 5000 



	  SELECT did,ename,gender,dept,salary,
	  case 
		when Salary > 7501 then 'Grade A'  
		when Salary between 7001 and 7500 then 'Grade B'  
		when Salary between 6501 and  7000 then 'Grade C'  
		when Salary between 5000  and 6500 then 'Grade D'  
		when Salary < 5000  then 'Grade E'  
	  end AS Grades
	  FROM Department
	  
	  
	  SELECT did,ename,gender,dept,salary,
	  case 
		when Salary > 7501 then salary * 1.1
		when Salary between 7001 and 7500 then salary * 1.2
		when Salary between 6501 and  7000 then salary * 1.3
		when Salary between 5000  and 6500 then salary * 1.4
		when Salary < 5000  then salary * 1.5
	  end AS Increment
	  FROM Department order by Increment

--Update based on case 
	update Department
	set salary =	case 
			when Salary > 7501 then salary * 1.1
			when Salary between 7001 and 7500 then salary * 1.2
			when Salary between 6501 and  7000 then salary * 1.3
			when Salary between 5000  and 6500 then salary * 1.4
			when Salary < 5000  then salary * 1.5
			else  1000
		  end

 SELECT did,ename,gender,dept,salary 	  delete FROM Department order by salary


 with  countgrades 
 as
 (
	  SELECT did,ename,gender,dept,salary,
	  case 
		when Salary > 7501 then 'Grade A'  
		when Salary between 7001 and 7500 then 'Grade B'  
		when Salary between 6501 and  7000 then 'Grade C'  
		when Salary between 5000  and 6500 then 'Grade D'  
		when Salary < 5000  then 'Grade E'  
	  end AS Grades
	  FROM Department
	 ) 
select Grades, count(*) AS Counts from countgrades group by Grades

--##################################################

--logic (select,insert, update , delete )
--Stored procedure 
/*Syntax:
	CREATE PROCEDURE procedure_name   
		@parameter1 datatype [= default OUTPUT],
		@parameter2 datatype [= default OUTPUT],
    ...
	AS
	BEGIN
		-- SQL statements here(Insert, select , update, delete )
	END;
*/
--create procedure
	create procedure sp_grades
	as 
	begin 
			with  countgrades 
			as
			(
				SELECT did,ename,gender,dept,salary,
					case 
						when Salary > 7501 then 'Grade A'  
						when Salary between 7001 and 7500 then 'Grade B'  
						when Salary between 6501 and  7000 then 'Grade C'  
						when Salary between 5000  and 6500 then 'Grade D'  
						when Salary < 5000  then 'Grade E'  
					end AS Grades
				FROM Department
				) 
			select Grades, count(*) AS Counts from countgrades group by Grades
	end 

--call procedure 
	exec sp_grades
--Alter procedure
	Alter procedure sp_grades @grade varchar(10)
	as 
	begin 
			with  countgrades 
			as
			(
				SELECT did,ename,gender,dept,salary,
					case 
						when Salary > 7501 then 'Grade A'  
						when Salary between 7001 and 7500 then 'Grade B'  
						when Salary between 6501 and  7000 then 'Grade C'  
						when Salary between 5000  and 6500 then 'Grade D'  
						when Salary < 5000  then 'Grade E'  
					end AS Grades
				FROM Department
				) 
			select Grades, count(*) AS Counts from countgrades group by Grades having grades=@grade
	end 



--call procedure 
	exec sp_grades @grade='Grade D' 
	exec sp_grades @grade='Grade A'
	
	exec sp_grades [Grade B] 
	exec sp_grades [Grade C] 

--##################################################
--Stored Procedure to perform DML operation
	create table userdata (id int , ename varchar(20), age  int)

--logic (select,insert, update , delete )

create procedure autoupdt
	@action varchar(20),@id int = null, @ename varchar(20)= null, @age  int = null
as 
begin 
	if @action ='Insert'
		Begin
			insert into userdata values (@id, @ename,@age)
		end
	else if @action ='Update' 
		Begin
			update userdata
			set ename=@ename, age=@age  
			where id =@id
		end
	else if @action ='delete'
		Begin
			delete from userdata where id =@id
		end
	else if @action ='select' 
		Begin
			select * from userdata 
		end
	else
		Begin
					print'Invalid action'
		end

end 
--Call procedures

	exec autoupdt 	@action ='insert',@id   = 101, @ename ='alpha' , @age  =23

	exec autoupdt  'insert',  102,  'beta' , 22
	
	exec autoupdt [insert], 103, charlie , 21
	
	exec autoupdt [update], 103, fox , aa
	
	exec autoupdt [delete], 102
	  
	exec autoupdt 	[select]

--Object Definition 
	sp_helptext autoupdt



--#####################################
--TCL Transaction Control Language 
	--Save		Commit
	--dont'save	Rollback 


	BEGIN TRAN --START TRANSACTIN

			--SQL LOGIC

	Commit		--Save		
	Rollback	--dont'save
--###################

	BEGIN TRAN --START TRANSACTIN

		--Completion time: 2025-02-17T22:04:26.8622527-05:00

		  SELECT * FROM Department

		  delete from department where gender ='female'

		update department set  salary =99999


	Rollback	--dont'save


--###################
	 

	BEGIN TRAN  

		  SELECT * FROM Department

		  delete from department where gender ='female'
	Commit		--Save

--#####################################
	Begin Tran

		 T
		update department set  salary =salary *1.5
 
	Commit

SELECT * FROM Department

 
--##########################################################
--DDL trigger (create_table, alter_table, drop_table)
--XML datatype in SQL server --EVENTDATA()

/*
	Syntax:
		Create trigger TriggerName 
		on database 
		for create_table, alter_table, drop_table
		as 
		--sql logic 
	*/


create table ddllogs
(sno int identity(1,1), ddlevents xml)
--create trigger
	create trigger ddlmon
	on database 
	for  create_table, alter_table, drop_table
	as 
	begin 
		insert into ddllogs values (EVENTDATA())
	end 


-- monitor events 
select * from ddllogs


--Perform DDL operation
	--create table
		create table test	(id int , age int, ph int)

	--alter table 
		alter table test drop column id

	--drop table 
		drop table test

---####################################
-- user not allowed to create a table which has name = temp


	create trigger checktable 
	on database 
	for  create_table, alter_table, drop_table
		as 
		begin 
			declare @tbl varchar(30)
			set @tbl =EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(30)')

			if @tbl like '%temp%'
				begin 
					print 'user is not allowed to create a table names as temp'
					rollback 
				end 
		end


--scenario

	 Create table demo2 (id int ,age int , phnum int)
	 Create table demtempo2 (id int ,age int , phnum int)
	 Create table asdfgtemp23123o (id int ,age int , phnum int)

--##############################################################























































