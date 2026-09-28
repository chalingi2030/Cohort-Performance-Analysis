-- 05_schedule_comparison.sql
-- 
USE arel;

-- Question:
-- Does the number of trainings days per week affect attendance ?
--
-- Cohorts 2 to 5 used a three day week (MWF), while cohort 6
-- used a five day week (MTWF).


SELECT 
	c.schedule,
    ROUND(100 * SUM(a.status IN ('Present', 'Late')) / COUNT(*)
    ) AS attendnce_rate,
    COUNT(*) AS n
    
FROM attendance a 
JOIN enrolments e ON a.enrolment_id = e.enrolment_id
JOIN cohorts c ON e.cohort_id = c.cohort_id

WHERE a.status <> 'Not Recorded'
GROUP BY c.schedule; 
-- Results
-- Attendance is almost the same under both schedule:
-- 58.0% for the five day week and 58.9% for the three day week
-- that difference is less than one percentate point, suggesting
-- that the change in weekly schudule had little diffrence in
-- attendance based on the available data.


