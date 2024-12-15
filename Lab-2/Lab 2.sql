use CSE_4B_407
--department table

CREATE TABLE DEPARTMENT(
DEPARTMENTID  INT PRIMARY KEY,
DEPARTMENTNAME VARCHAR(100) NOT NULL UNIQUE
)
 ---designation table

 CREATE TABLE DESIGNATION(
DESIGNATIONID INT PRIMARY KEY,
DESIGNATIONNAME VARCHAR(100) NOT NULL UNIQUE
)

--person table

CREATE TABLE Person ( 
PersonID INT PRIMARY KEY IDENTITY(101,1), 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
Salary DECIMAL(8, 2) NOT NULL, 
JoiningDate DATETIME NOT NULL, 
DEPARTMENTID INT NULL, 
DESIGNATIONID INT NULL, 
FOREIGN KEY (DEPARTMENTID) REFERENCES DEPARTMENT(DEPARTMENTID), 
FOREIGN KEY (DESIGNATIONID) REFERENCES DESIGNATION(DESIGNATIONID) 
);

------------------------------------------------------------ inser SP-------------------------------------------------------------------------

--department
CREATE or alter PROCEDURE PR_DEPARTMENT_INSERT
	@DEPARTMENTID INT,
	@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	INSERT INTO DEPARTMENT
	(DEPARTMENTID,DEPARTMENTNAME)
	VALUES
	(@DEPARTMENTID,@DEPARTMENTNAME)
END
EXEC PR_DEPARTMENT_INSERT 11,'JOBBER'
EXEC PR_DEPARTMENT_INSERT 12,'WELDER'
EXEC PR_DEPARTMENT_INSERT 13,'CLERK'
EXEC PR_DEPARTMENT_INSERT 14,'MANAGER'
EXEC PR_DEPARTMENT_INSERT 15,'CEO'

SELECT * FROM DEPARTMENT


--designation
CREATE or alter PROCEDURE PR_DESIGNATION_INSERT
	@DESIGNATIONID INT,
	@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	INSERT INTO DESIGNATION
	(DESIGNATIONID,DESIGNATIONNAME)
	VALUES
	(@DESIGNATIONID,@DESIGNATIONNAME)
END
EXEC PR_DESIGNATION_INSERT 1,'ADMIN'
EXEC PR_DESIGNATION_INSERT 2,'IT'
EXEC PR_DESIGNATION_INSERT 3,'HR'
EXEC PR_DESIGNATION_INSERT 4,'ACCOUNT'

SELECT * FROM DESIGNATION

--person
 CREATE  or  ALTER PROCEDURE PR_Person_INSERT 
    @FirstName VARCHAR(100) , 
	@LastName VARCHAR(100), 
	@Salary DECIMAL(8, 2), 
	@JoiningDate DATETIME, 
	@DEPARTMENTID INT, 
	@DESIGNATIONID INT 
AS
BEGIN
	INSERT INTO Person
	(FirstName,LastName,Salary,JoiningDate,DEPARTMENTID,DESIGNATIONID)
	VALUES
		(@FirstName,@LastName,@Salary,@JoiningDate,@DEPARTMENTID,@DESIGNATIONID)

END
EXEC PR_Person_INSERT 'Rahul','anshu',56000,'1990-01-01',12,1
EXEC PR_Person_INSERT 'Hardik','hinsu',18000,'1990-09-25',11,2
EXEC PR_Person_INSERT 'Bhavin','kamani',25000,'1991-02-20',11,null
EXEC PR_Person_INSERT 'Bhoomi','patel',39000,'2014-02-20',13,1
EXEC PR_Person_INSERT 'Rohit','rajgor',17000,'1990-07-23',15,2
EXEC PR_Person_INSERT 'Priya','mehta',25000,'1990-10-18',null,2
EXEC PR_Person_INSERT 'Neha','trivedi',18000,'2014-02-20',15,3

SELECT * FROM Person
SELECT * FROM DEPARTMENT
SELECT * FROM DESIGNATION
------------------------------------------------------------------------------------------------------------------------------------------------------



------------------------------------------------------update SP--------------------------------------------------------------------------------------


--department
CREATE PROCEDURE PR_DEPARTMENT_UPDATE
	@DEPARTMENTID INT,
	@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	UPDATE DEPARTMENT
	SET DEPARTMENTNAME=@DEPARTMENTNAME
	WHERE DEPARTMENTID=@DEPARTMENTID
	
END


--designation
CREATE PROCEDURE PR_DESIGNATION_UPDATE
	@DESIGNATIONID INT,
	@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	UPDATE DESIGNATION
	SET DESIGNATIONNAME=@DESIGNATIONNAME
	WHERE DESIGNATIONID=@DESIGNATIONID
	
END


--person
create or ALTER PROCEDURE PR_Person_UPDATE 
	@PersonId int,
    @FirstName VARCHAR(100) , 
	@LastName VARCHAR(100), 
	@Salary DECIMAL(8, 2), 
	@JoiningDate DATETIME, 
	@DEPARTMENTID INT, 
	@DESIGNATIONID INT 
AS
BEGIN
	UPDATE Person
	SET FirstName=@FirstName
	WHERE PersonId=@PersonId
END
----------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------delete SP------------------------------------------------------------------------------

--department
CREATE PROCEDURE PR_DEPARTMENT_DELETE
	@DEPARTMENTID INT,
	@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	DELETE  FROM DEPARTMENT
	WHERE DEPARTMENTID=@DEPARTMENTID
	
END

--designation
CREATE PROCEDURE PR_DESIGNATION_DELETE
	@DESIGNATIONID INT,
	@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	DELETE  FROM DESIGNATION
	WHERE DESIGNATIONID=@DESIGNATIONID
	
END

--person
CREATE PROCEDURE PR_Person_DELETE
	@PersonId int,
    @FirstName VARCHAR(100) , 
	@LastName VARCHAR(100), 
	@Salary DECIMAL(8, 2), 
	@JoiningDate DATETIME, 
	@DEPARTMENTID INT, 
	@DESIGNATIONID INT 
AS
BEGIN
	DELETE  FROM Person
	WHERE PersonId=@PersonId
	
End
------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY 
CREATE OR ALTER PROCEDURE PR_Person_INSERT 
	@PersonId int,
	@FirstName varchar(100)=Null,
	@LastName VARCHAR(100)=Null, 
	@Salary DECIMAL(8, 2), 
	@JoiningDate DATETIME, 
	@DEPARTMENTID INT, 
	@DESIGNATIONID INT
AS
BEGIN
		INSERT INTO Person 
		values(@PersonId,@FirstName,@LastName,@Salary,@JoiningDate,@DESIGNATIONID,@DEPARTMENTID)
end

exec PR_Person_INSERT  15000,'1990-02-05',11,1


--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take columns on select list)
 
create or alter proc pr_PersonDetails
as
begin
	select * from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
end


--4. Create a Procedure that shows details of the first 3 persons. 

create or alter proc pr_Person
as
begin
		select top 3 * from Person
end

--Part – B 
--5. Create a Procedure that takes the department name as input and returns a table with all workers  working in that department.
 
create or alter proc pr_PersonDetails
		@DEPARTMENTNAME VARCHAR(100)
as
begin
	select * from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	where DEPARTMENTNAME=@DEPARTMENTNAME
end


--6. Create Procedure that takes department name & designation name as input and returns a table with worker’s first name, salary, joining date & department name. 

create or alter proc pr_PersonDetails
		@DEPARTMENTNAME VARCHAR(100),
		@DESIGNATIONNAME varchar(100)
as
begin
	select Person.FirstName,Person.Salary,Person.JoiningDate from 
	Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	where DEPARTMENTNAME=@DEPARTMENTNAME and
		  DESIGNATIONNAME=@DESIGNATIONNAME
end

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.
 
create or alter proc pr_PersonDetails
		@FirstName VARCHAR(100)
as
begin
	select * from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	where FirstName=@FirstName
end

--8. Create Procedure which displays department wise maximum, minimum & total salaries.

create or alter proc pr_PersonDetails
as
begin
	select DEPARTMENT.DEPARTMENTNAME,max(Person.Salary),min(Person.Salary),sum(Person.Salary)
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	group by DEPARTMENT.DEPARTMENTNAME
end

--9. Create Procedure which displays designation wise average & total salaries. 

create or alter proc pr_PersonDetails
as
begin
	select DESIGNATION.DESIGNATIONNAME,avg(Person.Salary),sum(Person.Salary)
	from Person join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	group by DESIGNATION.DESIGNATIONNAME
end

--Part – C 
--10. Create Procedure that Accepts Department Name and Returns Person Count.

create or alter proc pr_PersonDetails
	@DEPARTMENTNAME VARCHAR(100)
as
begin
	select COUNT(Person.PersonID)
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	where DEPARTMENTNAME=@DEPARTMENTNAME
end

--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details.
 
create or alter proc pr_PersonDetails
	@Salary decimal(8,2)
as
begin
	select *
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	where Salary>@Salary
end

--12. Create a procedure to find the department(s) with the highest total salary among all departments.

create or alter proc pr_PersonDetails
	@DEPARTMENTNAME VARCHAR(100)
as
begin
	select sum(Person.Salary)
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	where DEPARTMENTNAME=@DEPARTMENTNAME
end

--13. Create a procedure that takes a designation name as input and returns a list of all workers under that designation who joined within the last 10 years, along with their department. 

create or alter proc pr_PersonDetails
	@DESIGNATIONNAME VARCHAR(100)
as
begin
	select Person.JoiningDate,DEPARTMENT.DEPARTMENTNAME
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	where DESIGNATIONNAME=@DESIGNATIONNAME and Person.JoiningDate>'2014'
end

--14. Create a procedure to list the number of workers in each department who do not have a designation assigned. 

create or alter proc pr_PersonDetails
as
begin
	select COUNT(Person.PersonID)
	from Person join DESIGNATION
	on Person.DEPARTMENTID=DESIGNATION.DESIGNATIONID
	where DESIGNATIONNAME != null
end

--15. Create a procedure to retrieve the details of workers in departments where the average salary is above 12000.
 

 create or alter proc pr_PersonDetails
as
begin
	select avg(Person.Salary)
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	where avg(Person.Salary)>12000
end
