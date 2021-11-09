DROP DATABASE TrainingDB
GO
--CREATE NEW DATABASE
CREATE DATABASE TrainingDB
GO

USE TrainingDB
GO

DROP TABLE dbo.Department
GO

--CREATE NEW DATABASE TABLE NAME DEPARTMENT
CREATE TABLE Department(
Id int PRIMARY KEY,  -- 1.  PRIMARY KEY CONSTRAINT
Name varchar(200) NOT NULL, --2. NOT NULL CONSTRAINT
Location varchar(200) CHECK (Location IN ('Bangalore', 'Chennai' , 'Hyderabad')), --3. CHECK CONSTRAINT
CreatedDate datetime DEFAULT GETDATE()) --4. DEFAULT CONSTRAINT
GO

--retrieve all the Data from Department table
SELECT * FROM Department
GO

--Insert sample data into department table
INSERT INTO Department(Id, Name, Location) VALUES(101, 'Sales', 'Chennai')
INSERT INTO Department VALUES(102, 'Testing', 'Hyderabad', '2021-11-01')
INSERT INTO Department VALUES(103, 'Development', 'Bangalore', DEFAULT)
INSERT INTO Department VALUES(104, 'Admin', 'Chennai', DEFAULT)
INSERT INTO Department(Id, Location, Name) VALUES(105, 'Chennai', 'Advertisement')
GO

--Update Specific record
UPDATE Department 
SET Location='Hyderabad'
WHERE Id=104
GO

--Update all the records
UPDATE Department 
SET CreatedDate=GETDATE()

--Update more than one column
UPDATE Department 
SET Location='Hyderabad', CreatedDate=GETDATE()
WHERE Id=104
GO

--Delete specific record
DELETE FROM Department 
WHERE Location='Chennai'
GO

--Delete all the records
DELETE FROM Department 
GO
----------------------------
SELECT * FROM Department
GO
----------------------------------------------------

--Create new table Employee under TrainingDB database
CREATE TABLE Employee(
Id INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(200) NOT NULL,
Email VARCHAR(200) UNIQUE,
Salary FLOAT CHECK (SALARY > 5000),
CreatedDate DATETIME DEFAULT GETDATE(),
DeptId INT FOREIGN KEY REFERENCES Department(Id)
)
GO


--truncate table employee
--Insert sample data into Employee table
INSERT INTO Employee VALUES('Kartik Sharma', 'kartik@gmail.com', 12000, DEFAULT, 101)
INSERT INTO Employee VALUES('King Kochhar', 'king@gmail.com', 25000, DEFAULT, 102)
INSERT INTO Employee VALUES('Shreya Goshal', 'shreya@gmail.com', 12000, DEFAULT, 101)
INSERT INTO Employee VALUES('Sujatha Batra', 'sujatha@gmail.com', 15000, DEFAULT, 102)
INSERT INTO Employee VALUES('Venky Deva', 'venky@gmail.com', 55000, DEFAULT, 103)
INSERT INTO Employee VALUES('Sarah Bowling', 'sarah@gmail.com', 17000, DEFAULT, 104)
INSERT INTO Employee VALUES('Gautam Bhalla', 'gautam@gmail.com', 28000, DEFAULT, 103)
INSERT INTO Employee VALUES('John Smith', 'john@gmail.com', 10000, DEFAULT, 104)
INSERT INTO Employee VALUES('Roger Lee', 'roger@gmail.com', 23000, DEFAULT, NULL)
GO

--Retrieve all the data from Employee Table
SELECT * FROM Department
SELECT * FROM Employee
GO

-- Projection: Restricting Columns
	SELECT Id, Name, Salary
	FROM Employee

-- Selection: Restricting Rows
	SELECT * 
	FROM Employee
	WHERE Salary > 15000

-- Projection and Restriction: Restricting Columns and Rows
	SELECT Id, Name, Salary ---- Projection
	FROM Employee
	WHERE Salary > 15000 ---- Restriction

-- Arithmetic Operators (+, -, *, /)
	SELECT Id, Name, Salary as 'Month Salary', Salary*12 'Annual Salary'
	FROM Employee
	WHERE Salary > 15000 

-- Logical Operators (AND, OR, NOT)
	SELECT Id, Name, Salary as 'Month Salary'
	FROM Employee
	WHERE Salary >= 10000 AND Salary <= 20000
	--OR
	SELECT Id, Name, Salary as 'Month Salary'
	FROM Employee
	WHERE Salary BETWEEN  10000 AND  20000

	SELECT Id, Name, Salary as 'Month Salary'
	FROM Employee
	WHERE Name = 'Kartik Sharma' AND Salary = 12000

	SELECT Id, Name, Salary
	FROM Employee
	WHERE Name = 'Kartik Sharma' OR Name = 'Venky Deva' OR Name = 'Gautam Bhalla' OR Name = 'Rajesh'

	SELECT Id, Name, Salary as 'Month Salary'
	FROM Employee
	WHERE Name = 'Kartik Sharma' AND NOT Salary = 20000

	SELECT Id, Name, Salary
	FROM Employee
	WHERE Name IN( 'Kartik Sharma','Venky Deva', 'Gautam Bhalla','Rajesh')

	SELECT Id, Name, Salary
	FROM Employee
	WHERE Name NOT IN( 'Kartik Sharma','Venky Deva', 'Gautam Bhalla','Rajesh')

	SELECT Id, Name, Salary as 'Month Salary'
	FROM Employee
	WHERE Name LIKE 'S%'

	SELECT Id, Name, Salary as 'Month Salary'
	FROM Employee
	WHERE Name LIKE '%A'

	SELECT Id, Name, Salary as 'Month Salary'
	FROM Employee
	WHERE Name LIKE '%SH%'

		SELECT Id, Name, Salary as 'Month Salary'
	FROM Employee
	WHERE Name LIKE '_A%'; --- get all records which has 2nd character as A

	SELECT Id, Name, salary
	FROM Employee
	WHERE DeptId IS NULL

	SELECT Id, Name, salary
	FROM Employee
	WHERE DeptId IS NOT NULL

--JOIN: Retrieving Data from more than one table
SELECT * FROM Department
SELECT * FROM Employee
GO

-- Retrieve Employee Name and their respective Department Names

	SELECT Emp.Name as 'Employee Name', Emp.Salary, Dept.Name as 'Department Name', Dept.Location
	FROM Employee Emp JOIN Department Dept
	ON Emp.DeptId = Dept.Id
	--WHERE

	SELECT E.Name as 'Employee Name', E.Salary, D.Name as 'Department Name', D.Location
	FROM Employee E JOIN Department D
	ON E.DeptId = D.Id
	AND  E.Salary > 15000	
	
	SELECT E.Name as 'Employee Name', E.Salary, D.Name as 'Department Name', D.Location
	FROM Employee E JOIN Department D
	ON E.DeptId = D.Id
	WHERE  E.Salary > 15000

--LEFT OUTER JOIN - Retrieves all records from left table and only matched records from right table

	SELECT E.Name as 'Employee Name', E.Salary, D.Name as 'Department Name', D.Location
	FROM Employee E LEFT OUTER JOIN Department D
	ON E.DeptId = D.Id

--RIGHT OUTER JOIN - Retrieves all records from right table and only matched records from left table

	SELECT E.Name as 'Employee Name', E.Salary, D.Name as 'Department Name', D.Location
	FROM Employee E RIGHT OUTER JOIN Department D
	ON E.DeptId = D.Id

--FULL OUTER JOIN - Retrieves all matched and non-matched records from left and right table

	SELECT E.Name as 'Employee Name', E.Salary, D.Name as 'Department Name', D.Location
	FROM Employee E FULL OUTER JOIN Department D
	ON E.DeptId = D.Id