-- ============================================================
-- VUA-SEN307 Lab 6: Aggregate Functions, Grouping and Subqueries
-- Name: Chris-Derique Ehizo
-- Matric: VUG/SEN/24/12878
-- ============================================================

USE sen307_12878;

-- Task 1: Count the students enrolled in each course (including courses with 0 students)
SELECT c.course_code, c.course_title, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_code, c.course_title
ORDER BY total_students DESC;
-- Explanation: Uses LEFT JOIN so all courses appear even if they have no matching rows in Enrolment.
-- COUNT(e.student_id) returns 0 rather than 1 for an empty course because COUNT(column) ignores NULL values (whereas COUNT(*) counts the NULL-padded row as 1).

-- Task 2: Courses with more than a given number of students using HAVING (thresholds: 3, 5, and 7)
-- Threshold > 3:
SELECT c.course_code, c.course_title, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_code, c.course_title
HAVING COUNT(e.student_id) > 3
ORDER BY total_students DESC;

-- Threshold > 5:
SELECT c.course_code, c.course_title, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_code, c.course_title
HAVING COUNT(e.student_id) > 5
ORDER BY total_students DESC;

-- Threshold > 7:
SELECT c.course_code, c.course_title, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_code, c.course_title
HAVING COUNT(e.student_id) > 7
ORDER BY total_students DESC;
-- Explanation: HAVING filters grouped results after aggregation; increasing the threshold from 3 to 5 to 7 progressively narrows the output to only the highest-enrolled courses (such as SEN307).

-- Task 3: Average number of courses taken per student (including students with 0 courses)
SELECT ROUND(AVG(course_count), 2) AS avg_courses_per_student
FROM (
    SELECT s.student_id, COUNT(e.course_id) AS course_count
    FROM Student s
    LEFT JOIN Enrolment e ON s.student_id = e.student_id
    GROUP BY s.student_id
) AS per_student;
-- Explanation: The inner query counts enrolments per student using LEFT JOIN (giving 0 for unenrolled students), and the outer query computes the overall rounded average across all 21 students.

-- Task 4 (Non-correlated subquery): Students not enrolled in any course
SELECT student_id, matric_no, full_name
FROM Student
WHERE student_id NOT IN (
    SELECT DISTINCT student_id
    FROM Enrolment
    WHERE student_id IS NOT NULL
)
ORDER BY full_name ASC;
-- Explanation: The inner subquery executes once to collect all enrolled student IDs, and the outer query filters for students excluded from that list.
-- Comparison with Week 7 Task 3: Produces the exact same unenrolled students (Favour Eze and Emmanuel Balogun) as the LEFT JOIN ... WHERE course_title IS NULL query.

-- Task 5 (Correlated subquery): Student(s) with the highest number of enrolments in each department
SELECT d.dept_name, s.full_name,
    (SELECT COUNT(*) FROM Enrolment e WHERE e.student_id = s.student_id) AS courses
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE (SELECT COUNT(*) FROM Enrolment e WHERE e.student_id = s.student_id) >= ALL (
    SELECT COUNT(e2.enrolment_id)
    FROM Student s2
    LEFT JOIN Enrolment e2 ON s2.student_id = e2.student_id
    WHERE s2.dept_id = s.dept_id
    GROUP BY s2.student_id
)
ORDER BY d.dept_name ASC, s.full_name ASC;
-- Explanation: The correlated subquery checks s.dept_id for each outer student row and compares their enrolment count against all students in the same department, returning the top student(s) including ties.