-- 01_data_quality_checks.sql
-- Purpose: check the underlying records before trusting analysist

USE arel;

SHOW TABLES;

SELECT * FROM assignments;
SELECT * FROM attendance;
SELECT * FROM cohorts;
SELECT * FROM courses;
SELECT * FROM enrolments;
SELECT * FROM instructors;
SELECT * FROM students;



-- Enrolment per status --How large is Unknown
SELECT status, COUNT(*) AS total_enrolments
FROM enrolments
GROUP BY status
ORDER BY total_enrolments DESC;
-- 31.5% (178) of the enrolment records are unknown

-- what share of student records are missing contact information
SELECT 
	SUM(email = '') missing_email,
    SUM(phone = '') missing_phone
FROM students; 
-- 75% of students have missing contacts details 

-- How many attendance Sessions have no status recorded at all
SELECT status, COUNT(*) AS total_sessions
FROM attendance
GROUP BY status
ORDER BY total_sessions DESC; 

-- Not Recorded sessions as share of the whole attandance table
SELECT
	ROUND(100.0 * SUM(status = 'Not Recorded') / COUNT(*), 2) AS percentage_not_recorded
FROM attendance; 

-- Decision made from these results, applied in every query
-- * Not recorded attendance rows are excluded from attendance
-- (neither counted as attendance nor as absent)   