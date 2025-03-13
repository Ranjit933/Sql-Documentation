--SQl server DML trigger , exception handling,   NORMALISATION , SCEHMAS
--#######################################################
	Create database  SQLDEMO
	go
	use SQLDEMO
	go

	CREATE TABLE emp
	  (
		  eid INT,
		  ename VARCHAR(50) ,
		  gender VARCHAR(50) ,
		  salary INT ,
		  dept VARCHAR(50) 
	   )

	go
		INSERT INTO DEPARTMENT  VALUES
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

	go

--#######################################################
--Trigger in SQL server (event  --> Action  is performed)
	--DML(Insert, Update , delete)


--Two logical trigger in DML trigger 
	--Inserted (add a new records,new info will be records)
	--Deleted (removal old record,old info  will be records )

/*
	Syntax:
		Create trigger TriggerName 
		on tablename 
		for insert, update, delete
		as 
		begin 
			--sql logic 
		end
*/

-- Trigger 

-- freeze changes due to holiday -19-02-2025
	alter trigger tg_dep 
	on department  
	for insert, update, delete
	as
	begin 
			if  getdate() <='02-17-2025'
			begin 
				print  ' user cannot perform action on the department table'
				rollback
			end 
	end 




	delete from Department

	select * from Department

 
--Enable/ disable a trigger
	--Enable TRIGGER trigger_name ON table_name;
	--DISABLE TRIGGER trigger_name ON table_name;


	Enable TRIGGER tg_dep ON Department;

	DISABLE TRIGGER tg_dep ON Department;



  SELECT * FROM Department


-- CREATE A another  TABLE DEPT_HIST--> DEPARTMENT

	create table dept_hist
	(
		sno int identity(1,1),
		timestamps datetime default getdate(),
		loginname varchar(50)  default suser_name(),
		DML_Ops varchar(20),

		old_eid INT,
		old_ename VARCHAR(50) ,
		old_gender VARCHAR(50) ,
		old_salary INT ,
		old_dept VARCHAR(50),		
		
		New_eid INT,
		New_ename VARCHAR(50) ,
		New_gender VARCHAR(50) ,
		New_salary INT ,
		New_dept VARCHAR(50) 

	)
 

--TRIGGER INSERT
	CREATE trigger TG_Insert 
	on department  
	for insert 
	as
	begin
		insert into dept_hist (  [DML_Ops], [old_eid], [old_ename], [old_gender], [old_salary], [old_dept], [New_eid], [New_ename], [New_gender], [New_salary], [New_dept])
		select 'Insert',null, null, null,null, null ,[did], [ename], [gender], [salary], [dept] from inserted
	END

	INSERT INTO Department  VALUES
	  (1, 'David', 'Male', 5000, 'Sales'),
	  (5, 'Shane', 'Female', 5500, 'Finance'),
	  (6, 'Shed', 'Male', 8000, 'Sales'),
	  (7, 'Vik', 'Male', 7200, 'HR'),
	  (2, 'Jim', 'Female', 6000, 'HR') 

	  
  SELECT * FROM Department
  SELECT * FROM dept_hist



--TRIGGER delete
	CREATE trigger TG_DELETE 
	on department  
	for delete
	as
	begin
		insert into dept_hist (  [DML_Ops], [old_eid], [old_ename], [old_gender], [old_salary], [old_dept], [New_eid], [New_ename], [New_gender], [New_salary], [New_dept])
		select 'delete' ,[did], [ename], [gender], [salary], [dept],null, null, null,null, null from deleted
	END


	DELETE FROM Department WHERE GENDER ='MALE'
	
 


  --TRIGGER update
	CREATE trigger TG_update 
	on department  
	for  update 
	as
	begin
		insert into dept_hist (  DML_Ops, old_eid, old_ename, old_gender, old_salary, old_dept, New_eid, New_ename, New_gender, New_salary, New_dept)
		select 'update' ,D.did, D.ename, D.gender, D.salary, D.dept,I.did, I.ename, I.gender, I.salary, I.dept from INSERTED  I JOIN  deleted D ON I.DID=D.DID

	END


UPDATE Department
SET ENAME ='DAVE' , GENDER =NULL , SALARY =100


 SELECT  * FROM Department
  SELECT * FROM dept_hist


--##############################################################
--Exception /Error handling 

	select * from sys.messages where message_id = 207


	SELECT 1/0

--error 1 (Cannot insert duplicate key in object)
	create table demo101
	(id int identity , phnum int unique)

	insert into demo101
	values (3467)

	select * from demo101
---Error related function
	select error_message(), error_line(), error_state(), error_Severity(),error_procedure(),error_number()
 
 	select * from sys.messages WHERE message_id=2627



--Error handling 
	Begin Try
			--SQL stmt
	end Try

	Begin Catch
			--generate Errors
			--Write to table
	end Catch


--Error 1 
	Begin Try
			--SQL stmt
			SELECT 1/0
	end Try

	Begin Catch
			--generate Errors
			--Write to table
			 PRINT ' CANNOT DIVIDE'
	end Catch


	
--Error 1 
	Begin Try
			--SQL stmt
			insert into demo101	values (3467)
	end Try

	Begin Catch
			--generate Errors
			--Write to table
			 RAISERROR('DUPLICATE VALUE',16,1)
	end Catch


	
--Error 1 
	Begin Try
			--SQL stmt
			insert into demo101	values (3467)
	end Try

	Begin Catch
			--generate Errors
			--Write to table
			 	select error_message(), error_line(), error_state(), error_Severity(),error_procedure(),error_number()
	end Catch


--NORMALISATION



--DISTINCT 

SELECT DISTINCT * FROM Department ORDER BY DID 


SELECT DISTINCT DID FROM Department ORDER BY DID 




















































































































































































































