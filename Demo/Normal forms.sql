

--1st Normal Form (1NF) - Eliminate Repeating Groups
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Subjects VARCHAR(255)  -- Stores multiple values (BAD DESIGN)
);

INSERT INTO Students VALUES (1, 'John', 'Math, Science');
INSERT INTO Students VALUES (2, 'Mike', 'English, Math');


-----------------------------------------------------------------------


CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE StudentSubjects (
    StudentID INT,
    Subject VARCHAR(100),
    PRIMARY KEY (StudentID, Subject),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

INSERT INTO Students VALUES (1, 'John');
INSERT INTO Students VALUES (2, 'Mike');

INSERT INTO StudentSubjects VALUES (1, 'Math'), (1, 'Science');
INSERT INTO StudentSubjects VALUES (2, 'English'), (2, 'Math');


-------------------------------------------------------------------------------------
--2nd Normal Form (2NF) - Remove Partial Dependency

CREATE TABLE StudentCourses (
    StudentID INT,
    CourseID INT,
    StudentName VARCHAR(100),  -- Depends only on StudentID (BAD DESIGN)
    CourseName VARCHAR(100),  -- Depends only on CourseID (BAD DESIGN)
    PRIMARY KEY (StudentID, CourseID)
);


--------------------------------------------------------------------------------------


CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Students VALUES (1, 'John');
INSERT INTO Courses VALUES (101, 'Math');
INSERT INTO Enrollments VALUES (1, 101);


----------------------------------------------------------------------------------
--3rd Normal Form (3NF) - Remove Transitive Dependency


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    DepartmentName VARCHAR(100)  -- Depends on DepartmentID (BAD DESIGN)
);

------------------------------------------------------------------------------------

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Departments VALUES (101, 'HR');
INSERT INTO Employees VALUES (1, 'Alice', 101);
