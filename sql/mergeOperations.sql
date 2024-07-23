use company

Create table StudentSource
(
 ID int primary key,
 Name nvarchar(20)
)

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')

Create table StudentTarget
(
 ID int primary key,
 Name nvarchar(20)
)

Insert into StudentTarget values (1, 'Mike M')
Insert into StudentTarget values (3, 'John')


--INSERT, UPDATE, DELETE OPERATIONS

  MERGE INTO StudentTarget AS T
  USING StudentSource AS S
  ON T.ID = S.ID
  WHEN MATCHED THEN
    UPDATE SET T.NAME = S.NAME
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ID, NAME) VALUES(S.ID, S.NAME)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

 SELECT * FROM StudentTarget
 SELECT * FROM StudentSource

  --WITHOUT DELETE
  Truncate table StudentSource
Truncate table StudentTarget

MERGE INTO StudentTarget AS T
USING StudentSource AS S
ON T.ID = S.ID
WHEN MATCHED THEN
   UPDATE SET T.NAME = S.NAME
WHEN NOT MATCHED BY TARGET THEN
   INSERT (ID, NAME) VALUES(S.ID, S.NAME);



--2ND EXAMPLE

-- Create a sample database (if not already created)
CREATE DATABASE SampleDB;
USE SampleDB;

-- target table
CREATE TABLE EmployeesT (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    HireDate DATE
);

INSERT INTO EmployeesT (EmployeeID, FirstName, LastName, Department, HireDate)
VALUES
(1, 'John', 'Doe', 'Sales', '2022-01-15'),
(2, 'Jane', 'Smith', 'Marketing', '2021-06-23'),
(3, 'Emily', 'Johnson', 'Sales', '2023-03-11');


-- source table
CREATE TABLE EmployeeUpdatesS (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    HireDate DATE
);

INSERT INTO EmployeeUpdatesS (EmployeeID, FirstName, LastName, Department, HireDate)
VALUES
(2, 'Jane', 'Smith', 'HR', '2021-06-23'),  -- Marketing to HR
(3, 'Emily', 'Johnson', 'Sales', '2023-03-11'), 
(4, 'Michael', 'Brown', 'IT', '2022-09-30');  

-- MERGE operation
MERGE EmployeesT AS Target
USING EmployeeUpdatesS AS Source
ON Target.EmployeeID = Source.EmployeeID
WHEN MATCHED THEN
    UPDATE SET
        Target.FirstName = Source.FirstName,
        Target.LastName = Source.LastName,
        Target.Department = Source.Department,
        Target.HireDate = Source.HireDate
WHEN NOT MATCHED THEN
    INSERT (EmployeeID, FirstName, LastName, Department, HireDate)
    VALUES (Source.EmployeeID, Source.FirstName, Source.LastName, Source.Department, Source.HireDate);


SELECT * FROM EmployeesT;






