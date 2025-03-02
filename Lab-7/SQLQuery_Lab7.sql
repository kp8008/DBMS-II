---Lab-7-----
-- Create the Customers table
CREATE TABLE Customers (
 Customer_id INT PRIMARY KEY,
 Customer_Name VARCHAR(250) NOT NULL,
 Email VARCHAR(50) UNIQUE
);
-- Create the Orders table
CREATE TABLE Orders (
 Order_id INT PRIMARY KEY,
 Customer_id INT,
 Order_date DATE NOT NULL,
 FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);

---Part-A---
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.
BEGIN TRY
    DECLARE @num1 INT = 10, @num2 INT = 0, @result INT;
    SET @result = @num1 / @num2;
END TRY
BEGIN CATCH
    PRINT 'Error occurs that is - Divide by zero error.';
END CATCH;

--2.Try to convert string to integer and handle the error using try…catch block.
BEGIN TRY
    DECLARE @stringValue NVARCHAR(10) = 'prince';
    DECLARE @intValue INT;
    SET @intValue = CAST(@stringValue AS INT);
END TRY
BEGIN CATCH
    PRINT 'Error occurs that is - string to integer Convert error.';
END CATCH;

--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle
--  exception with all error functions if any one enters string value in numbers otherwise print result.
CREATE PROCEDURE SUMOFTWONUMBER 
    @num1 NVARCHAR(50),
    @num2 NVARCHAR(50)
AS
BEGIN
    DECLARE @intNum1 INT, @intNum2 INT;

	BEGIN TRY 
		SET @intNum1 = CAST(@num1 AS INT);
        SET @intNum2 = CAST(@num2 AS INT);
        PRINT 'Sum is: ' + CAST((@intNum1 + @intNum2) AS NVARCHAR);
    END TRY	
	BEGIN CATCH
		PRINT 'Error occurs that is - Invalid input type.';
    END CATCH
END;


--4. Handle a Primary Key Violation while inserting data into customers table and print the error details
--  such as the error message, error number, severity, and state.
BEGIN TRY
    INSERT INTO Customers (Customer_id, Customer_Name)
    VALUES (7, 'Prince KP');
END TRY
BEGIN CATCH
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR);
    PRINT 'State: ' + CAST(ERROR_STATE() AS NVARCHAR);
END CATCH;

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws
-- Error like no Customer_id is available in database.
CREATE PROCEDURE CheckCustomer_id
    @Customer_id INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE Customer_id = @Customer_id)
    BEGIN
        THROW 51000, 'No Customer_id is available in database.', 1;
    END
    ELSE
    BEGIN
        PRINT 'Customer exists in the database.';
    END
END;

--6.. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error message.
BEGIN TRY
    INSERT INTO Orders (Order_id, Customer_id, Order_date)
    VALUES (1, 999, '2025-02-12'); -- Assuming 999 is an invalid CustomerID causing FK violation
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 547 -- Foreign Key violation error number
    BEGIN
        PRINT 'Error: Foreign Key violation. The CustomerID provided does not exist.';
    END
    ELSE
    BEGIN
        PRINT 'An unexpected error occurred.';
    END
END CATCH
