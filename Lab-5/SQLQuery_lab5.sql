use CSE_4B_407

---Lab-5----

-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);
-- Creating PersonLog Table
CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL,
 
);

--Part-A--
--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display
-- a message “Record is Affected.”

create or alter trigger TR_displayMSG
on PersonInfo
after insert,update,delete
as
begin
	print 'Record is Affected'
end


insert into PersonInfo values
(2,'prince',60000,'2005-12-24','Gondal',20,'2005-10-15')

select * from PersonInfo
select * from PersonLog
delete from PersonInfo
where PersonName = 'prince'

update PersonInfo 
set PersonName='kp'
where PersonID=1

--2.Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that,
--  log all operations performed on the person table into PersonLog.

--insert--
create or alter trigger TR_StoreInLog_INS
on PersonInfo
after insert
as
begin
	declare @PerId int
	declare @PerName varchar(50)
	declare @Operation varchar(50)
	declare @date datetime
	set @date = GETDATE()
	set @Operation = 'insert'
	select @PerId = PersonID,@PerName=PersonName from inserted
	insert into PersonLog values
	(@PerId,@PerName,@Operation,@date)
end

select * from PersonLog
--delete
create or alter trigger TR_StoreInLog_DEL
on PersonInfo
after delete
as
begin
	declare @PerId int
	declare @PerName varchar(50)
	declare @Operation varchar(50)
	declare @date datetime
	set @date = GETDATE()
	set @Operation = 'delete'
	select @PerId = PersonID,@PerName=PersonName from deleted
	insert into PersonLog values
	(@PerId,@PerName,@Operation,@date)
end

--Update
create or alter trigger TR_StoreInLog_Up
on PersonInfo
after update
as
begin
	declare @PerId int
	declare @PerName varchar(50)
	declare @Operation varchar(50)
	declare @date datetime
	set @date = GETDATE()
	set @Operation = 'Update'
	select @PerId = PersonID,@PerName=PersonName from inserted
	insert into PersonLog values
	(@PerId,@PerName,@Operation,@date)
end

select * from PersonLog



--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into uppercase whenever the record is inserted.
create or alter trigger TR_ConvertUpperCase
on PersonInfo
after insert
as
begin
	declare @name varchar(250)
	declare @id int
	select @id=PersonID,@name=PersonName from inserted

	update PersonInfo
	set PersonName=UPPER(@name)
	where PersonID=@id
end

--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog.
--insert
create or alter trigger TR_StoreInLog_insteadOF_ins
on PersonInfo
INSTEAD OF insert
as
begin
	declare @PerId int
	declare @PerName varchar(50)
	declare @Operation varchar(50)
	declare @date datetime
	set @date = GETDATE()
	set @Operation = 'insert'
	select @PerId = PersonID,@PerName=PersonName from inserted
	insert into PersonLog values
	(@PerId,@PerName,@Operation,@date)
end

--delete
create or alter trigger TR_StoreInLog_insteadOF_del
on PersonInfo
INSTEAD OF delete
as
begin
	declare @PerId int
	declare @PerName varchar(50)
	declare @Operation varchar(50)
	declare @date datetime
	set @date = GETDATE()
	set @Operation = 'delete'
	select @PerId = PersonID,@PerName=PersonName from deleted
	insert into PersonLog values
	(@PerId,@PerName,@Operation,@date)
end

--5. Create trigger that prevent duplicate entries of person name on PersonInfo table. 
create trigger tr_duplicate_p_name
on PersonInfo 
instead of insert
as 
	begin 
	DECLARE @PersonID INT
	DECLARE @PersonName VARCHAR(50)	
	SELECT @PersonID = PersonID FROM inserted
	SELECT @PersonName = PersonName FROM inserted
	if exists (select 1 from PersonInfo where PersonName = @PersonName)
	begin
		print 'Duplicate Entry'
	end
	else
	begin
		insert into PersonInfo
		select * from inserted
	end
end
--6. Create trigger that prevent Age below 18 years.
create trigger tr_age_check
on PersonInfo
instead of insert
as
begin
DECLARE @Age INT
DECLARE @PersonName VARCHAR(50)
SELECT @Age = Age FROM inserted
SELECT @PersonName = PersonName FROM inserted
if @Age < 18
begin
	print 'Age should be greater than 18'
end
else
begin
	insert into PersonInfo
	select * from inserted
end
end
