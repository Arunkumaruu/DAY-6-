CREATE DATABASE School1;
USE School1;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    EnrollmentDate DATE, 
    Email VARCHAR(50)  
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);


CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);


INSERT INTO Students (StudentID, FirstName, LastName, Age, EnrollmentDate, Email)
VALUES 
    (1, 'John', 'Doe', 20, '2023-01-01', 'johndoe@example.com'),
    (2, 'Jane', 'Smith', 22, '2023-02-01', 'janesmith@example.com'),
    (3, 'Alice', 'Johnson', 21, '2023-03-01', 'alicejohnson@example.com');



	INSERT INTO Courses (CourseID, CourseName)
VALUES 
    (1, 'Mathematics'),
    (2, 'Science'),
    (3, 'History');


	INSERT INTO Enrollments (StudentID, CourseID)
VALUES 
    (1, 1),  
    (1, 2),  
    (2, 1),  
    (3, 3);  



	INSERT INTO Teachers (TeacherID, FirstName, LastName, HireDate, Salary)
VALUES 
    (1, 'Michael', 'Brown', '2020-05-15', 50000.00),
    (2, 'Linda', 'Davis', '2018-08-22', 55000.00);

	-- Adding a new student
INSERT INTO Students (StudentID, FirstName, LastName, Age, EnrollmentDate, Email)
VALUES (4, 'Emily', 'Clark', 23, '2023-04-01', 'emilyclark@example.com');


-- Retrieve all students
SELECT * FROM Students;

-- Retrieve specific student by ID
SELECT * FROM Students WHERE StudentID = 1;

-- Update student's last name
UPDATE Students
SET LastName = 'Williams'
WHERE StudentID = 4;


-- Delete a student
DELETE FROM Students WHERE StudentID = 4;


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


SELECT FirstName FROM Students
UNION
SELECT LastName FROM Students;


-- Number of students by age
SELECT Age, COUNT(*) AS NumberOfStudents
FROM Students
GROUP BY Age
HAVING COUNT(*) > 1;

-- Average age of students enrolled in 'Science'
SELECT AVG(Students.Age) AS AverageAge
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.CourseName = 'Science';


CREATE PROCEDURE GetStudentDetails
AS
BEGIN
    SELECT * FROM Students;
END;


CREATE PROCEDURE GetStudentByID
    @StudentID INT
AS
BEGIN
    SELECT * FROM Students
    WHERE StudentID = @StudentID;
END;


-- Execute to get all students
EXEC GetStudentDetails;

-- Execute to get a specific student
EXEC GetStudentByID @StudentID = 2;


--case study

SELECT Students.FirstName, Students.LastName
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.CourseName = 'Mathematics';



SELECT Courses.CourseName, COUNT(Enrollments.StudentID) AS NumberOfStudents
FROM Courses
LEFT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY Courses.CourseName;


































