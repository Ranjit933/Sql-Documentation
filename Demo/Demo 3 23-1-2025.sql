--Data type(String, numeric,unicode)
--###########################################################
--Self learning 
	https://learn.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver16
--XML data in SQL Server
	https://learn.microsoft.com/en-us/sql/relational-databases/xml/xml-data-sql-server?view=sql-server-ver16
--JSON data in SQL Server
	https://learn.microsoft.com/en-us/sql/relational-databases/json/json-data-sql-server?view=sql-server-ver16
--###########################################################
--Exact numerics
123
6465
460
0
-5613
-
-45
-4646

--Declare , help us to intialise a temp variable
--set , assign temp variable a value
--select , display the value
--Tinyint, range(0-255), 1 Byte.
	declare @val tinyint
	set @val =0
	select @val

	declare @val tinyint
	set @val =10
	select @val

	declare @val tinyint
	set @val =100
	select @val
	
	declare @val tinyint
	set @val =200
	select @val
	
	declare @val tinyint
	set @val =255
	select @val, datalength(@val) as Byte

	declare @val tinyint
	set @val =256
	select @val
--##########################################################
--smallint, range(-32768 to 32767), 2 byte  
	declare @val smallint
	set @val =-32768
	select @val, datalength(@val)  

	declare @val smallint
	set @val =-0
	select @val as Valuee, datalength(@val) as Byte 

	declare @val smallint
	set @val =32767
	select @val as Valuee, datalength(@val) as Byte 

	declare @val smallint
	set @val =250
	select @val as Valuee, datalength(@val) as Byte 

	declare @val smallint
	set @val =32768
	select @val as Valuee, datalength(@val) as Byte 
--##########################################################
--Int (-2,147,483,648 to 2,147,483,647), 4 byte

	declare @val int
	set @val =-2147483648
	select @val as Valuee, datalength(@val) as Byte 

	declare @val int
	set @val =2147483647
	select @val as Valuee, datalength(@val) as Byte 

	declare @val int
	set @val =0
	select @val as Valuee, datalength(@val) as Byte 

	declare @val int
	set @val =10
	select @val as Valuee, datalength(@val) as Byte 
	
	declare @val int
	set @val =-21474836480
	select @val as Valuee, datalength(@val) as Byte 

--#######################################################
--Bigint (-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807), 8 byte
	declare @val Bigint
	set @val =-9223372036854775808
	select @val as Valuee, datalength(@val) as Byte 
	
	declare @val Bigint
	set @val =-0
	select @val as Valuee, datalength(@val) as Byte 

	declare @val Bigint
	set @val =100
	select @val as Valuee, datalength(@val) as Byte 
	
	declare @val Bigint
	set @val =        9223372036854775807
	select @val as Valuee, datalength(@val) as Byte 
---###################################################################

--Approximate numerics
	--Precision (data which is presenet towards the left and right of the decimal point)
	--Scale(data which is presenet towards right of the decimal point)

968457.789654958	
123456 789012345	
.789654958	
 123456789
p =15
s=9

--Float, 15 Precision , 8 byte
	declare @val Float
	set @val = 123456789012345
	select @val as Valuee, datalength(@val) as Byte 

	declare @val Float
	set @val = 1234567890123456
	select @val as Valuee, datalength(@val) as Byte 

1.23456789012346E+15
--1.23456789012346* 10 raised to power of 15


	declare @val Float
	set @val = 123456789.0123456 
	select @val as Valuee, datalength(@val) as Byte 

	declare @val Float
	set @val = 12345678987653.0123456 
	select @val as Valuee, datalength(@val) as Byte 

--#####################################################################
--decimal(precision , scale)

	Precision			Storage bytes
	1 - 9					5
	10-19					9
	20-28					13
	29-38					17
	
	declare @val decimal
	set @val = 1234567.00 
	select @val as Valuee, datalength(@val) as Byte 

	declare @val decimal
	set @val = 123456789012345678 
	select @val as Valuee, datalength(@val) as Byte 

	declare @val decimal(38,0)
	set @val = 92233720368547758089223372036854775892 
	select @val as Valuee, datalength(@val) as Byte 

	
	declare @val decimal(38,0)
	set @val = 12 
	select @val as Valuee, datalength(@val) as Byte 

	
	declare @val decimal(38,38)
	set @val = 0.922337203685477580892233720368547758901
	select @val as Valuee, datalength(@val) as Byte 

	declare @val decimal(38,2)
	set @val =922337203685477580892233720368547758.92
	select @val as Valuee, datalength(@val) as Byte 
	
	
	declare @val decimal(38,2)
	set @val =1.45765464564592
	select @val as Valuee, datalength(@val) as Byte 

	
	declare @val decimal(38,2)
	set @val =192
	select @val as Valuee, datalength(@val) as Byte 
--###############################################################
--String in SQl server
'12 3567 89 0SDFGHJ L:as dfghjkl:?" !@#$ %^&*()_+'
--Char(n), range (1 to 8000)
	--It is a fixed length data type
	--Used to store non-Unicode characters
	--Occupiers 1 byte of space for each character
	--Static memory allocation
	

	declare @val CHAR
	set @val ='A1@ B'
	select @val as Valuee, datalength(@val) as Byte 
	
	declare @val CHAR(1)
	set @val ='A1@ B'
	select @val as Valuee, datalength(@val) as Byte 

	declare @val CHAR(8000)
	set @val ='A1@ B'
	select @val as Valuee, datalength(@val) as Byte 

	
	declare @val CHAR(100)
	set @val ='ALPHA BETA CHARLIE '
	select @val as Valuee, datalength(@val) as Byte 

	
	declare @val CHAR(100)
	set @val ='ALPHA'
	select @val as Valuee, datalength(@val) as Byte 
--###########################################################
--varchar(n), range 1-8000 / max
	--It is a variable-length data type
	--Used to store Unicode characters
	--Occupies 1 bytes of space for each character
	--dynamic memory allocation

	declare @val varchar
	set @val='alph'
	select @val, datalength(@val) as Byte

	declare @val varchar(1)
	set @val='alpha'
	select @val, datalength(@val) as Byte
	
	declare @val varchar(50)
	set @val='a lp ha'
	select @val, datalength(@val) as Byte

	declare @val varchar(8000)
	set @val='asfgh jkRTY UIOP@#$%^&* ()2345 67890 as'
	select @val, datalength(@val) as Byte

	declare @val varchar(10)
	set @val='12345@deln'
	select @val, datalength(@val) as Byte
	
	declare @val varchar(8000)
	set @val='asfgh jkRTY UIOP@#$%^&* ()2345 67890 as'
	select @val, datalength(@val) as Byte
	
	declare @val varchar(max)
	set @val='asfgh'
	select @val, datalength(@val) as Byte

--###############################################


	Declare @value  char(30)
	Set @value=N'नमस्ते दुनिया'
	Select @value as Number, datalength(@value) As Byte



	Declare @value  varchar(30)
	Set @value=N'नमस्ते दुनिया'
	Select @value as Number, datalength(@value) As Byte

--###############################################
--Unicode (nchar & nvachar)
	--nchar(1 to 4000) 
	--It is a fixed length data type
	--Used to store non-Unicode characters
	--Occupiers 2 byte of space for each character
	--static memory allocation

	Declare @value  nchar(30) --30 *2
	Set @value=N'नमस्ते दुनिया'
	Select @value as Number,  datalength(@value) As Byte

	Declare @value  nchar(15)	--15*2
	Set @value=N'hello world'
	Select @value as Number,  datalength(@value) As Byte
	
	Declare @value  nchar(25) --25*2
	Set @value=N'你好，世界'
	Select @value as Number,  datalength(@value) As Byte

		Declare @value  nchar(35)	--35*2
	Set @value=N'नमस्ते दुनिया, 你好，世界'
	Select @value as Number,  datalength(@value) As Byte
--###########################################################
--nvarchar()
--1-4000
--It is a variable-length data type
--Used to store Unicode characters
--Occupies 2 bytes of space for each character
--dynamic memory allocation
		
	Declare @value  nvarchar(20) 
	Set @value=N'hello world'
	Select @value as Number, datalength(@value) As Byte
	
	Declare @value  nvarchar(20) 
	Set @value=N'नमस्ते दुनिया'
	Select @value as Number, datalength(@value) As Byte
	
	Declare @value  nvarchar(15) 
	Set @value=N'你好，世界'
	Select @value as Number, datalength(@value) As Byte
		
	Declare @value  nvarchar(30) 
	Set @value=N'नमस्ते दुनिया 你好，世界'
	Select @value as Number, datalength(@value) As Byte

	Declare @value  nvarchar(max) 
	Set @value=N'नमस्ते दुनिया 你好，世界'
	Select @value as Number, datalength(@value) As Byte
--###########################################################












































































































































































































































































































































































