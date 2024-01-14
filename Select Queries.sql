-- ######################## SELECTION QUERIES DATA ######################################## --


-- 11. Get summary statistics - the number of teachers and/or students of each gender who fall into a given age group.--
SELECT
    'Teacher' AS Category,
    Gender,
    CASE
        WHEN strftime('%Y', 'now') - strftime('%Y', DateOfBirth) BETWEEN 20 AND 30 THEN '20-30'
        WHEN strftime('%Y', 'now') - strftime('%Y', DateOfBirth) BETWEEN 31 AND 40 THEN '31-40'
        WHEN strftime('%Y', 'now') - strftime('%Y', DateOfBirth) BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51+' END AS AgeGroup,
    COUNT(*) AS Count
FROM Teachers
GROUP BY Category, Gender, AgeGroup

UNION ALL

SELECT
    'Student' AS Category,
    Gender,
    CASE
        WHEN strftime('%Y', 'now') - strftime('%Y', DateOfBirth) BETWEEN 20 AND 30 THEN '20-30'
        WHEN strftime('%Y', 'now') - strftime('%Y', DateOfBirth) BETWEEN 31 AND 40 THEN '31-40'
        WHEN strftime('%Y', 'now') - strftime('%Y', DateOfBirth) BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51+' END AS AgeGroup,
    COUNT(*) AS Count
FROM Students
GROUP BY Category, Gender, AgeGroup
ORDER BY Category, Gender, AgeGroup;


-- 12. Get a list of teachers and students whose birthdays fall within a given time period.
SELECT 'Teacher' AS Role, FullName, DateOfBirth
FROM Teachers
WHERE DateOfBirth BETWEEN '1980-01-01' AND '1985-12-31'
UNION ALL
SELECT 'Student' AS Role, FullName, DateOfBirth
FROM Students
WHERE DateOfBirth BETWEEN '1999-01-01' AND '2005-12-31';


-- 13. Get a list of teachers teaching classes for each individual group during a given period of time.
SELECT t.FullName AS TeacherName, g.GroupNumber, i.Time, d.DisciplineName
FROM Teachers t
JOIN Items i ON t.TeacherID = i.TeacherID
JOIN Groups g ON i.GroupID = g.GroupID
JOIN Disciplines d ON i.DisciplineId = d.DisciplineID
WHERE i.Time = '2022-Fall';


-- 14. Get a list of students enrolled during a specified period of time.
SELECT s.FullName AS StudentName, g.GroupNumber, a.AdmissionTime
FROM Students s
JOIN Activity a ON s.StudentID = a.StudentID
JOIN Groups g ON a.GroupID = g.GroupID
WHERE a.AdmissionTime BETWEEN '2022-01-01' AND '2023-01-01';


-- Get a list of students expelled
SELECT s.FullName AS StudentName,  s.SpecializationName, g.GroupNumber, a.AdmissionTime, a.ExpulsionTime
FROM Students s
JOIN Activity a ON s.StudentID = a.StudentID
JOIN Groups g ON a.GroupID = g.GroupID
JOIN Specializations s ON g.SpecializationID = s.SpecializationID
WHERE a.ExpulsionTime IS NOT NULL


-- 15.	Get a list of groups in which the specified student studied (with reference to time).
SELECT
	Students.FullName,
	Specializations.SpecializationName,
    Groups.GroupNumber,
    Groups.Course,
    Activity.AdmissionTime AS AdmissionTime,
    Activity.ExpulsionTime AS ExpulsionTime
FROM
    Groups
JOIN
    Activity ON Groups.GroupID = Activity.GroupID
JOIN
    Specializations ON Groups.SpecializationID = Specializations.SpecializationID
	
JOIN
    Students ON Activity.StudentID  = Students.StudentID 
WHERE
    Activity.StudentID = 1;


--16.	Save the results of tests/exams with reference to a specific subject.
-- Insert data into TestResults
SELECT
    Students.FullName AS StudentName,
    Disciplines.DisciplineName,
    TestResults.AssessmentType,
    TestResults.Score,
    TestResults.DateOfAssessment
FROM
    TestResults
JOIN
    Students ON TestResults.StudentID = Students.StudentID
JOIN
    Disciplines ON TestResults.DisciplineID = Disciplines.DisciplineID
WHERE
    TestResults.DisciplineID = 1;

-- 18.	Get summary statistics (average score) of the group in the specified discipline.
SELECT
    Groups.GroupID,
    Disciplines.DisciplineName,
    AVG(Grades.Grade) AS AverageScore
FROM
    Groups
JOIN
    Items ON Groups.GroupID = Items.GroupID
JOIN
    Disciplines ON Items.DisciplineID = Disciplines.DisciplineID
LEFT JOIN
    Grades ON Items.ItemID = Grades.ItemID
WHERE
    Groups.GroupID = 1 AND
    Disciplines.DisciplineID = 2
GROUP BY
    Groups.GroupID, Disciplines.DisciplineName;
