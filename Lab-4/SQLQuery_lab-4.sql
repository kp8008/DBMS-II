use CSE_4B_407

---Lab-4---

--Part-1--

--1. Write a function to print "hello world".
Create or Alter Function F_Hello()
Returns Varchar(50)
as
Begin
	return 'Hello World';
end;

select dbo.F_Hello()

--2. Write a function which returns addition of two numbers.
Create or Alter Function F_Sum( @n2 int , @n3 int)
Returns  int 
as
Begin
	
	return  @n2 +  @n3 ;
end;

select dbo.F_sum(10,20)

--3.Write a function to check whether the given number is ODD or EVEN
CREATE OR ALTER FUNCTION FN_ODD_OR_EVEN(
		@NO INT
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @MSG VARCHAR(50)
	IF @NO%2=0
		SET @MSG='NUMBER IS EVEN'
	ELSE 
		SET @MSG='NUMBER IS ODD'
	RETURN @MSG
END

SELECT dbo.FN_ODD_OR_EVEN(6)

--4. Write a function which returns a table with details of a person whose first name starts with B.

CREATE OR ALTER FUNCTION FN_PERSON_DETAILS()
RETURNS TABLE
AS
	RETURN (SELECT * FROM Person where FirstName like 'B%')

SELECT * FROM dbo.FN_PERSON_DETAILS()
SELECT * FROM Person

--5. Write a function which returns a table with unique first names from the person table. 

CREATE OR ALTER FUNCTION FN_PERSON_unique()
RETURNS TABLE
AS
	RETURN (SELECT DISTINCT FirstName FROM Person)

SELECT * FROM dbo.FN_PERSON_unique()
SELECT * FROM Person

--6. Write a function to print number from 1 to N. (Using while loop) 

CREATE OR ALTER FUNCTION FN_1_to_n(
		@NO INT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @MSG VARCHAR(50),@count int
	SET @MSG=''
	SET @count=1
	while (@count<=@NO)
	begin
		set @MSG=@MSG+' '+CAST(@count AS varchar(100))
		SET @count=@count+1
	end
	RETURN @MSG
END

SELECT dbo.FN_1_to_n(15)

--7. Write a function to find the factorial of a given integer. 

CREATE OR ALTER FUNCTION FN_FACTORIAL(
		@NO INT
)
RETURNS INT
AS
BEGIN
	DECLARE @FAC int
	SET @FAC=1
	while (@NO>1)
	begin
		set @FAC=@FAC*@NO
		SET @NO=@NO-1
	end
	RETURN @FAC
END

SELECT dbo.FN_FACTORIAL(5)

---Part-B----

--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
CREATE OR ALTER FUNCTION FN_COMPARISON(
		@N1 INT,
		@N2 INT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @MSG VARCHAR(100)
	SET @MSG=CASE
				wheN (@N1=@N2) THEN 'BOATH ARE SAME'
				wheN (@N1>@N2) THEN 'N1 IS MAX'
				wheN (@N1<@N2) THEN 'N2 IS MAX'
				ELSE 'INVALID NUMBER'
				END
	RETURN @MSG
END

select dbo.FN_COMPARISON(10,20)

--9. Write a function to print the sum of even numbers between 1 to 20.

Create or Alter Function F_Sum_Even()
Returns  int 
as
Begin
declare @ans int = 0 , @count int = 0
	while @count <= 20
	begin
		if @count%2=0
		set @ans= @ans + @count
		set @count = @count +1
	end
return @ans
end;

select dbo.F_Sum_Even()

--10 Write a function that checks if a given string is a palindrome
Create or Alter Function F_palindrome( @s1 Varchar(50) )
Returns  Varchar(50) 
as
Begin
declare @ans  Varchar(50) = reverse(@s1)
	if @ans = @s1
	return 'palindrome'
Return 'Not palindrome'
end;

select dbo.F_palindrome('NPN')

---Part-C---

-- 11. Write a function to check whether a given number is prime or not.
CREATE FUNCTION IsPrime(@num INT)
RETURNS BIT
AS
BEGIN
    IF @num < 2 RETURN 0; -- Not prime
    DECLARE @i INT = 2;
    WHILE @i <= SQRT(@num)
    BEGIN
        IF @num % @i = 0 RETURN 0; -- Not prime
        SET @i = @i + 1;
    END;
    RETURN 1; -- Prime
END;

