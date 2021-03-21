-- Create empty GradeRecords table to receive data.
CREATE TABLE GradeRecords 
(	StudentID INT,
	FirstName VARCHAR(11),
    LastName VARCHAR(15),
    MidtermExam FLOAT(4),
	FinalExam FLOAT(4),
	Assignment1 FLOAT(4),
	Assignment2 FLOAT(4),
	TotalPoints INT,
	StudentAverage FLOAT(4),
	Grade VARCHAR(5)
)


-- Import thousands of grade records data from the CSV file into
-- the GradeRecords table.
BULK INSERT
	GradeRecords
FROM
	'C:\Downloads\gradeRecordModuleV.csv'
WITH 
(	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)


-- Show if there are any duplicate records in the GradeRecords table.
SELECT
	StudentID
FROM
	GradeRecords
GROUP BY
	StudentID
HAVING 
	COUNT(StudentID) > 1
ORDER BY
	StudentID


-- Where there are duplicate student IDs in the GradeRecords table, assign a new 
-- student ID to the duplicate student IDs.
SELECT MAX(StudentID)
AS 
	HighestStudentID
FROM
	GradeRecords


UPDATE
	GradeRecords 
SET 
	StudentID = 99866 
WHERE
	StudentID = 35932 AND FirstName = 'Tallulah'
UPDATE
	GradeRecords 
SET 
	StudentID = 99867 
WHERE
	StudentID = 47058 AND FirstName = 'Jaye'
UPDATE
	GradeRecords 
SET 
	StudentID = 99868 
WHERE
	StudentID = 64698 AND FirstName = 'Claudian'


-- Show if any field's values have mixed data types.
SELECT
	 COUNT(*) StudentID
FROM
	GradeRecords
WHERE
	StudentID > 9999 AND ISNUMERIC(StudentID) = 1 

SELECT
	COUNT(*) FirstName
FROM
	GradeRecords
WHERE
	FirstName <> '' AND FirstName IS NOT NULL AND LEN (FirstName) > 1 AND FirstName <> '%,%' AND FirstName <> '% %'

SELECT
	COUNT(*) LastName
FROM
	GradeRecords
WHERE
	LastName <> '' AND LastName IS NOT NULL AND LEN (LastName) > 1 AND LastName <> '%,%'

SELECT
	 COUNT(*) MidtermExam
FROM
	GradeRecords
WHERE
	MidtermExam BETWEEN -.01 AND 1.01

SELECT
	 COUNT(*) FinalExam
FROM
	GradeRecords
WHERE
	FinalExam BETWEEN -.01 AND 1.01

SELECT
	 COUNT(*) Assignment1
FROM
	GradeRecords
WHERE
	Assignment1 BETWEEN -.01 AND 1.01

SELECT
	 COUNT(*) Assignment2
FROM
	GradeRecords
WHERE
	Assignment2 BETWEEN -.01 AND 1.01

SELECT
	 COUNT(*) TotalPoints
FROM
	GradeRecords
WHERE
	TotalPoints > 0 AND ISNUMERIC(TotalPoints) = 1

SELECT
	COUNT(*) Grade
FROM
	GradeRecords
WHERE
	Grade <> '' AND Grade IS NOT NULL AND LEN (Grade) > 0 AND Grade <> '%,%' AND Grade <> '% %'


-- Assign a primary key to the StudentID field.
ALTER TABLE 
	GradeRecords
ALTER COLUMN 
	StudentID INT NOT NULL
ALTER TABLE 
	GradeRecords
ADD PRIMARY KEY
	(StudentID) 


-- Drop the StudentAverage field.
ALTER TABLE
	GradeRecords
DROP COLUMN
	StudentAverage


-- Using SELECT INTO create the destination table Grades and copy the 7 grade columns
-- of the source table GradeRecords to the new destination table Grades.
SELECT    
    StudentID,
	MidtermExam,
	FinalExam,
	Assignment1,
	Assignment2,
	TotalPoints,
	Grade
INTO 
    Grades
FROM    
    GradeRecords


-- Drop the grades fields from the GradeRecords table.
ALTER TABLE
	GradeRecords
DROP COLUMN
	MidtermExam,
	FinalExam,
	Assignment1,
	Assignment2,
	TotalPoints,
	Grade


-- JOIN the two tables to retrieve their rows simultaneously.
SELECT
    *
FROM
    GradeRecords
JOIN Grades
    ON GradeRecords.StudentID = Grades.StudentID;