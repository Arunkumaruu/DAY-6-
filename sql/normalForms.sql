USE signup
--scenario with students, courses, and instructors.

--1. Normalized to 1NF:-Objective: Ensure all columns contain atomic values.


CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE StudentCourses (
    StudentID INT,
    Course VARCHAR(50),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Insert data
INSERT INTO Students (StudentID, Name)
VALUES 
    (1, 'Alice'),
    (2, 'Bob');

INSERT INTO StudentCourses (StudentID, Course)
VALUES
    (1, 'Math'),
    (1, 'Science'),
    (2, 'Math'),
    (2, 'English'),
    (2, 'History');

SELECT * FROM Students 
SELECT * FROM StudentCourses

--2. Second Normal Form (2NF)
--Objective: Remove partial dependencies; ensure non-key attributes are fully functionally dependent on the entire primary key.

CREATE TABLE StudentCourses1 (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID)
);

CREATE TABLE Courses1 (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

-- Insert data
INSERT INTO StudentCourses1 (StudentID, CourseID)
VALUES
    (1, 101),
    (1, 102),
    (2, 101);

INSERT INTO Courses1 (CourseID, CourseName)
VALUES
    (101, 'Math'),
    (102, 'Science');

SELECT * FROM StudentCourses1
SELECT * FROM Courses1

--3. Third Normal Form (3NF) & 4. Boyce-Codd Normal Form (BCNF)
--3.Objective: Remove transitive dependencies; ensure all non-key attributes are dependent only on the primary key.
--4.Objective: Ensure that every determinant is a superkey.


CREATE TABLE Students2 (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE StudentCourses3 (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (CourseID) REFERENCES Courses3(CourseID)
);

CREATE TABLE Courses3 (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    InstructorID INT
);

CREATE TABLE Instructors3 (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert data
INSERT INTO Students2 (StudentID, Name)
VALUES 
    (1, 'Alice'),
    (2, 'Bob');

INSERT INTO StudentCourses3 (StudentID, CourseID)
VALUES
    (1, 101),
    (1, 102),
    (2, 101);

INSERT INTO Courses3 (CourseID, CourseName, InstructorID)
VALUES
    (101, 'Math', 1),
    (102, 'Science', 2);

INSERT INTO Instructors3 (InstructorID, InstructorName, Department)
VALUES
    (1, 'Dr. Smith', 'Math Dept'),
    (2, 'Dr. Johnson', 'Science Dept');

SELECT * FROM Students2
SELECT * FROM StudentCourses3
SELECT * FROM Courses3
SELECT * FROM Instructors3



--4. Fourth Normal Form (4NF)
--Objective: Remove multi-valued dependencies.


CREATE TABLE Students4 (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE StudentCourses4 (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (CourseID) REFERENCES Courses4(CourseID)
);

CREATE TABLE Courses4 (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors4(InstructorID)
);

CREATE TABLE Instructors4 (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(50),
    Department VARCHAR(50)
);

CREATE TABLE StudentHobbies4 (
    StudentID INT,
    Hobby VARCHAR(50),
    PRIMARY KEY (StudentID, Hobby),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Insert data
INSERT INTO Students4 (StudentID, Name)
VALUES 
    (1, 'Alice'),
    (2, 'Bob');

INSERT INTO StudentCourses4 (StudentID, CourseID)
VALUES
    (1, 101),
    (1, 102),
    (2, 101);

INSERT INTO Courses4 (CourseID, CourseName, InstructorID)
VALUES
    (101, 'Math', 1),
    (102, 'Science', 2);

INSERT INTO Instructors4 (InstructorID, InstructorName, Department)
VALUES
    (1, 'Dr. Smith', 'Math Dept'),
    (2, 'Dr. Johnson', 'Science Dept');

INSERT INTO StudentHobbies4 (StudentID, Hobby)
VALUES
    (1, 'Reading'),
    (1, 'Hiking'),
    (2, 'Swimming'),
    (2, 'Cycling');

SELECT * FROM Students4
SELECT * FROM StudentCourses4
SELECT * FROM Courses4
SELECT * FROM Instructors4
SELECT * FROM StudentHobbies4

--5. Fifth Normal Form (5NF)
--Objective: Remove join dependencies; ensure that the data is decomposed to avoid any loss of information during joins.
CREATE TABLE StudentsCoursesSemesters (
    StudentID INT,
    CourseID INT,
    Semester VARCHAR(50),
    PRIMARY KEY (StudentID, CourseID, Semester),
    FOREIGN KEY (StudentID) REFERENCES Students4(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses4(CourseID)
);

-- Insert data
INSERT INTO StudentsCoursesSemesters (StudentID, CourseID, Semester)
VALUES
    (1, 101, 'Fall'),
    (1, 102, 'Spring'),
    (2, 101, 'Fall');

SELECT * FROM StudentsCoursesSemesters

--6. Sixth Normal Form (6NF)-job positions
--Objective: Handle temporal data.


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE EmployeeJobs (
    EmployeeID INT,
    JobTitle VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (EmployeeID, JobTitle, StartDate),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert data
INSERT INTO Employees (EmployeeID, Name)
VALUES 
    (1, 'John'),
    (2, 'Jane');

INSERT INTO EmployeeJobs (EmployeeID, JobTitle, StartDate, EndDate)
VALUES
    (1, 'Developer', '2022-01-01', '2023-06-30'),
    (1, 'Lead Developer', '2023-07-01', '2024-06-30'),
    (2, 'Designer', '2022-02-01', '2023-03-31');

SELECT * FROM Employees
SELECT * FROM EmployeeJobs