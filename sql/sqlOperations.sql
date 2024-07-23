-- Create Database
CREATE DATABASE School3;
USE School3;

-- Create Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    EnrollmentDate DATE,
    Email VARCHAR(100)
);

-- Create Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Enrollments Table
CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create Teachers Table
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

-- Insert Data into Students Table
INSERT INTO Students (StudentID, FirstName, LastName, Age, EnrollmentDate, Email)
VALUES 
    (1, 'John', 'Doe', 20, '2023-01-01', 'johndoe@example.com'),
    (2, 'Jane', 'Smith', 22, '2023-02-01', 'janesmith@example.com'),
    (3, 'Alice', 'Johnson', 21, '2023-03-01', 'alicejohnson@example.com'),
    (4, 'Bob', 'Brown', 23, '2023-04-01', 'bobbrown@example.com');

-- Insert Data into Courses Table
INSERT INTO Courses (CourseID, CourseName)
VALUES 
    (1, 'Mathematics'),
    (2, 'Science'),
    (3, 'History'),
    (4, 'Literature');

-- Insert Data into Enrollments Table
INSERT INTO Enrollments (StudentID, CourseID)
VALUES 
    (1, 1), 
    (1, 2), 
    (2, 1), 
    (3, 3), 
    (4, 4); 

-- Insert Data into Teachers Table
INSERT INTO Teachers (TeacherID, FirstName, LastName, HireDate, Salary)
VALUES 
    (1, 'Michael', 'Brown', '2020-05-15', 50000.00),
    (2, 'Linda', 'Davis', '2018-08-22', 55000.00);


	--CRUD OP
	-- Add a new student
INSERT INTO Students (StudentID, FirstName, LastName, Age, EnrollmentDate, Email)
VALUES (5, 'Emily', 'Clark', 24, '2023-05-01', 'emilyclark@example.com');

-- Update student's age
UPDATE Students
SET Age = 25
WHERE StudentID = 5;

-- Delete a student
DELETE FROM Students WHERE StudentID = 5;

-- all students
SELECT * FROM Students;

-- student by ID
SELECT * FROM Students WHERE StudentID = 1;


-- Retrieve distinct ages of students
SELECT DISTINCT Age FROM Students;

--AND
SELECT * FROM Students
WHERE Age > 20 AND LastName = 'Doe';

--OR
SELECT * FROM Students
WHERE Age > 20 OR LastName = 'Smith';

--NOT
SELECT * FROM Students
WHERE NOT Age > 20;


-- descending order
SELECT * FROM Students
ORDER BY Age DESC;

--NULL
SELECT * FROM Students
WHERE Email IS NULL;--OR NOT NULL


-- top 2 students by age
SELECT TOP 2 * FROM Students
ORDER BY Age DESC;


-- Minimum and maximum 
SELECT MIN(Age) AS MinAge, MAX(Age) AS MaxAge FROM Students;

-- Count, average, and sum 
SELECT COUNT(*) AS TotalStudents, AVG(Age) AS AverageAge, SUM(Age) AS TotalAge FROM Students;


-- LIKE
SELECT * FROM Students
WHERE FirstName LIKE 'J%';

-- IN
SELECT * FROM Students
WHERE Age IN (20, 21, 22);

-- BRTWEEN
SELECT * FROM Students
WHERE Age BETWEEN 20 AND 25;





-- Inner Join
SELECT Students.FirstName, Courses.CourseName
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- Left Join
SELECT Students.FirstName, Courses.CourseName
FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
LEFT JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- Right Join
SELECT Students.FirstName, Courses.CourseName
FROM Students
RIGHT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
RIGHT JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- Full Join
SELECT Students.FirstName, Courses.CourseName
FROM Students
FULL JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
FULL JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- Self Join
SELECT A.FirstName AS 'Student', B.FirstName AS 'Friend'
FROM Students A
INNER JOIN Enrollments EA ON A.StudentID = EA.StudentID
INNER JOIN Enrollments EB ON EA.CourseID = EB.CourseID
INNER JOIN Students B ON EB.StudentID = B.StudentID
WHERE A.StudentID <> B.StudentID;



-- Union of student first names and last names
SELECT FirstName FROM Students
UNION
SELECT LastName FROM Students;

-- Number of students by age
SELECT Age, COUNT(*) AS NumberOfStudents
FROM Students
GROUP BY Age
HAVING COUNT(*) > 1; --####

-- Retrieve students who are enrolled in at least one course
SELECT * FROM Students
WHERE EXISTS (
    SELECT 1 FROM Enrollments
    WHERE Students.StudentID = Enrollments.StudentID
);

-- Add a NOT NULL constraint to the Email column
ALTER TABLE Students
ALTER COLUMN Email VARCHAR(100) NOT NULL;

-- Add a UNIQUE constraint to the Email column
ALTER TABLE Students
ADD CONSTRAINT UC_Email UNIQUE (Email);


-- Get all student details
CREATE PROCEDURE spGetStudentDetails
AS
BEGIN
    SELECT * FROM Students;
END;
--drop proc GetStudentByID
-- Get student by ID
CREATE PROCEDURE spGetStudentByID
    @StudentID INT
AS
BEGIN
    SELECT * FROM Students
    WHERE StudentID = @StudentID;
END;

-- Execute stored procedures
EXEC spGetStudentDetails;
EXEC spGetStudentByID  2;

--ALTER PROC WITH OUPUT PARAMETERS 

alter PROCEDURE spGetStudentname
 @id int,
    @StudentName varchar(20) out
AS
BEGIN
    SELECT @StudentName=FirstName  FROM Students where StudentID=@id
END;

declare @name varchar(20)
execute  spGetStudentname 1 , @name out
print @name



--Get All Students Enrolled in 'Mathematics':

SELECT Students.FirstName, Students.LastName
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.CourseName = 'Mathematics';

--Get the Number of Students Enrolled in Each Course:

SELECT Courses.CourseName, COUNT(Enrollments.StudentID) AS NumberOfStudents
FROM Courses
LEFT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY Courses.CourseName;

--Get the Average Age of Students Enrolled in 'Science':

SELECT AVG(Students.Age) AS AverageAge
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.CourseName = 'Science';































