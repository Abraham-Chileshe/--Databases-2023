-- Table Teachers
CREATE TABLE Teachers (
    TeacherID INTEGER PRIMARY KEY AUTOINCREMENT,
    FullName VARCHAR(255) NOT NULL,
    Gender VARCHAR(10),
    DateOfBirth DATE,
    AcademicDegree VARCHAR(50)
);

-- Table Students
CREATE TABLE Students (
    StudentID INTEGER PRIMARY KEY AUTOINCREMENT,
    FullName VARCHAR(255) NOT NULL,
    Gender VARCHAR(10),
    DateOfBirth DATE,
    CertificateNumber VARCHAR(20)
);

-- Table Specializations
CREATE TABLE Specializations (
    SpecializationID INTEGER PRIMARY KEY AUTOINCREMENT,
    SpecializationName VARCHAR(50) NOT NULL
);

-- Table Groups
CREATE TABLE Groups (
    GroupID INTEGER PRIMARY KEY AUTOINCREMENT,
    SpecializationID INTEGER REFERENCES Specializations(SpecializationID),
    GroupNumber VAR(50),
    Course VARCHAR(50),
    UNIQUE(SpecializationID, GroupNumber) -- Ensure each group number is unique within a specialization
);

-- Table Activity
CREATE TABLE Activity (
    ActivityID INTEGER PRIMARY KEY AUTOINCREMENT,
    StudentID INTEGER REFERENCES Students(StudentID),
    GroupID INTEGER REFERENCES Groups(GroupID),
    AdmissionTime DATE,
    ExpulsionTime DATE,
    CHECK (ExpulsionTime IS NULL OR ExpulsionTime >= AdmissionTime) -- Expulsion should be later than admission
);

-- Table Disciplines
CREATE TABLE Disciplines (
    DisciplineID INTEGER PRIMARY KEY AUTOINCREMENT,
    DisciplineName VARCHAR(50) NOT NULL
);

-- Table Items - Composite Key
CREATE TABLE Items (
    ItemID INTEGER PRIMARY KEY AUTOINCREMENT,
    GroupID INTEGER,
    DisciplineID INTEGER,
    Time VARCHAR(20),
    AssessmentType VARCHAR(50),
    TeacherID INTEGER,
    UNIQUE(GroupID, DisciplineID), -- Ensure each discipline is taught only once in a group
    FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
    FOREIGN KEY (DisciplineID) REFERENCES Disciplines(DisciplineID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

-- Table Grades - Composite Key
CREATE TABLE Grades (
    GradeID INTEGER PRIMARY KEY AUTOINCREMENT,
    ItemID INTEGER,
    StudentID INTEGER,
    Grade FLOAT,
    AssessmentTime DATE,
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CHECK (AssessmentTime <= CURRENT_DATE) -- Ratings cannot be in advance
);

CREATE TABLE TestResults (
    ResultID INTEGER PRIMARY KEY AUTOINCREMENT,
    StudentID INTEGER REFERENCES Students(StudentID),
    DisciplineID INTEGER REFERENCES Disciplines(DisciplineID),
    AssessmentType VARCHAR(50),
    Score FLOAT,
    DateOfAssessment DATE,
    CONSTRAINT FK_StudentTestResult FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_DisciplineTestResult FOREIGN KEY (DisciplineID) REFERENCES Disciplines(DisciplineID)
);



--######################## INSERT DATA #########################################--

-- Insert data into Teachers
DELETE FROM Teachers;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Teachers';
INSERT INTO Teachers (FullName, Gender, DateOfBirth, AcademicDegree)
VALUES
    ('John Doe', 'Male', '1980-05-15', 'Ph.D.'),
    ('Jane Smith', 'Female', '1985-08-22', 'M.A.'),
	('Ben Carson', 'Male', '1980-02-12', 'M.A.'),
	('Joseph Adams', 'Male', '1990-03-02', 'Ph.D.'),
	('Marry Jones', 'Female', '1995-01-07', 'M.A.'),
    ('Jennifer White', 'Female', '1982-09-14', 'Ph.D.'),
    ('Michael Turner', 'Male', '1978-11-28', 'M.A.'),
    ('Emily Harris', 'Female', '1985-06-03', 'Ph.D.'),
    ('David Walker', 'Male', '1988-04-10', 'M.A.'),
    ('Jessica Miller', 'Female', '1977-12-18', 'Ph.D.');
   


-- Insert data into Students
DELETE FROM Students;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Students';
INSERT INTO Students (FullName, Gender, DateOfBirth, CertificateNumber)
VALUES
     ('Eva Williams', 'Female', '2001-03-18', '54321'),
    ('Alex Turner', 'Male', '1998-11-25', '87654'),
    ('Sophie Davis', 'Female', '2000-06-09', '98765'),
    ('Maxwell White', 'Male', '1997-09-12', '23456'),
    ('Olivia Johnson', 'Female', '1999-04-27', '87689'),
    ('Daniel Smith', 'Male', '2002-02-14', '34567'),
    ('Emma Wilson', 'Female', '1998-08-01', '90876'),
    ('Samuel Brown', 'Male', '2000-12-05', '76543'),
    ('Ava Taylor', 'Female', '1997-05-23', '23456'),
    ('Liam Miller', 'Male', '2001-10-08', '87678');


-- Insert fake data into Specializations
DELETE FROM Specializations;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Specialization';
INSERT INTO Specializations (SpecializationName)
VALUES
    ('Computer Science'),
    ('Biology'),
    ('Physics'),
    ('Medicine'),
    ('Mathematics'),
    ('History'),
    ('Languages'),
    ('Economics');


-- Insert fake data into Groups
DELETE FROM Groups;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Groups';
INSERT INTO Groups (SpecializationID, GroupNumber, Course)
VALUES
    (1, 'Б922.02.03.01сцт', 1),
    (2, 'В824.06.01.02сцт', 2),
    (3, 'П721.08.02.03сцт', 2),
    (4, 'М620.04.07.02сцт', 3),
    (5, 'И521.05.02.01сцт', 4),
    (1, 'Б923.02.03.03сцт', 1),
    (7, 'Е323.03.06.02сцт', 4)
  
;

-- Insert fake data into Activity
DELETE FROM Activity;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Activity';
INSERT INTO Activity (StudentID, GroupID, AdmissionTime, ExpulsionTime)
VALUES
    (1, 1, '2022-09-01', NULL),  -- Student  admitted to Group 1
    (2, 2, '2021-02-11', NULL),
    (3, 3, '2022-01-01', NULL),
    (4, 1, '2022-04-3', NULL),
    (5, 2, '2019-12-07', NULL),
    (6, 4, '2022-04-04', NULL),
    (7, 5, '2020-06-04', NULL),
    (8, 2, '2022-09-01', '2023-06-30'),  -- Student  admitted and later expelled from Group 1
     (9, 2, '2020-09-01', '2023-01-02'),  -- Student  admitted and later expelled from Group 1
    (1,2 , '2020-09-01', '2023-01-02')

;

-- Insert fake data into Disciplines
DELETE FROM Disciplines;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Disciplines';
INSERT INTO Disciplines (DisciplineName)
VALUES
    ('Programming Fundamentals'),
    ('Cell Biology'),
    ('Classical Mechanics'),
    ('Organic Chemistry'),
    ('Calculus I');


-- Insert fake data into Items
DELETE FROM Items;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Items';
INSERT INTO Items (GroupID, DisciplineID, Time, AssessmentType, TeacherID)
VALUES
    (1, 1, '2022-Fall', 'Exam', 1),
    (1, 2, '2022-Fall', 'Assignment', 2),
    (2, 1, '2022-Spring', 'Quiz', 3),
    (2, 2, '2022-Spring', 'Exam', 1),
    (3, 3, '2022-Fall', 'Exam', 4);

-- Insert fake data into Grades
DELETE FROM Grades;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Grades';
INSERT INTO Grades (ItemID, StudentID, Grade)
VALUES
    (1, 1, 85),
    (2, 1, 95),
    (3, 1, 60),
    (4, 1, 35),
    (1, 2, 92),
    (3, 2, 92),
    (4, 2, 92),
    (2, 3, 78),
    (2, 4, 88),
    (3, 5, 95);

DELETE FROM TestResults ;
UPDATE sqlite_sequence SET seq = 0 WHERE name = 'TestResults';
INSERT INTO TestResults (StudentID, DisciplineID, AssessmentType, Score, DateOfAssessment)
VALUES
    (1, 1, 'Exam', 85, '2022-01-15'),
    (2, 1, 'Test', 92, '2022-02-01'),
    (3, 2, 'Exam', 78, '2022-03-10'),
    (4, 2, 'Test', 88, '2022-04-05')
    ;


-- Triggers for additional constraints
-- Trigger to automatically expel a student from the old group when added to a new group
CREATE TRIGGER AutoExpelStudent
AFTER INSERT ON Activity
BEGIN
    UPDATE Activity
    SET ExpulsionTime = NEW.AdmissionTime
    WHERE StudentID = NEW.StudentID AND GroupID != NEW.GroupID AND ExpulsionTime IS NULL;
END;

-- Trigger to enforce that a student cannot be enrolled in different groups at the same time
CREATE TRIGGER EnforceSingleEnrollment
BEFORE INSERT ON Activity
FOR EACH ROW
WHEN NEW.ExpulsionTime IS NULL
BEGIN
    SELECT RAISE(ABORT, 'Student is already enrolled in another group.')
    FROM Activity
    WHERE StudentID = NEW.StudentID AND ExpulsionTime IS NULL;
END;

-- Trigger to automatically delete all groups associated with a specialization when deleting a group
CREATE TRIGGER AutoDeleteGroups
BEFORE DELETE ON Groups
BEGIN
    DELETE FROM Groups WHERE SpecializationID = OLD.SpecializationID;
END;

-- Trigger to enforce that different teachers cannot simultaneously teach the same discipline in the same group
CREATE TRIGGER EnforceSingleTeacherDiscipline
BEFORE INSERT ON Items
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Another teacher is already teaching this discipline in the same group.')
    FROM Items
    WHERE GroupID = NEW.GroupID AND DisciplineID = NEW.DisciplineID;
END;
