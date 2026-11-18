-- ============================================================
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: Chris-Derique Ehizo
-- Matric: VUG/SEN/24/12878
-- ============================================================

USE sen307_12878;

-- Task 1: Students in one department, sorted A-Z
SELECT s.matric_no, s.full_name, s.gender, d.dept_name
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;
-- Explanation: Joins Student with Department on dept_id, filters for Software Engineering students, and sorts alphabetically by full_name.

-- Task 2: Courses with their lecturers (INNER JOIN)
SELECT c.course_code, c.course_title, l.full_name AS lecturer_name
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_code ASC;
-- Explanation: Uses two INNER JOINs through the CourseAllocation junction table to pair every course with its assigned lecturer(s); SEN307 appears twice because two lecturers teach it.

-- Task 3a: All students and their courses (LEFT JOIN)
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name ASC;
-- Explanation: Returns all students from the left table alongside their enrolled courses, displaying NULL for students with no enrolments.

-- Task 3b: Students with NO enrolments
SELECT s.matric_no, s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name ASC;
-- Explanation: Filters the LEFT JOIN output where course_title IS NULL to isolate the two students (Favour Eze and Emmanuel Balogun) who have zero enrolments.

-- Task 4: Filtering with AND, OR, IN, and BETWEEN
SELECT s.matric_no, s.full_name, s.gender, s.date_of_birth, s.dept_id
FROM Student s
WHERE (s.gender = 'F' OR s.gender = 'M')
  AND s.dept_id IN (1, 3)
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.date_of_birth ASC;
-- Explanation: Combines OR, AND, IN, and BETWEEN with parentheses to retrieve students in Software Engineering (1) or Artificial Intelligence (3) born between 2004 and 2005.

-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- Page 1 (rows 1-10)
SELECT e.enrolment_id, s.full_name, c.course_code, e.academic_session
FROM Enrolment e
INNER JOIN Student s ON e.student_id = s.student_id
INNER JOIN Course c ON e.course_id = c.course_id
ORDER BY e.enrolment_id ASC
LIMIT 10 OFFSET 0;

-- Page 2 (rows 11-20)
SELECT e.enrolment_id, s.full_name, c.course_code, e.academic_session
FROM Enrolment e
INNER JOIN Student s ON e.student_id = s.student_id
INNER JOIN Course c ON e.course_id = c.course_id
ORDER BY e.enrolment_id ASC
LIMIT 10 OFFSET 10;
-- Explanation: Retrieves enrolments in pages of 10 using LIMIT and OFFSET. ORDER BY is mandatory with LIMIT so row ordering is deterministic and pages never skip or duplicate records.

-- Challenge (Optional): Task 3 rewritten using RIGHT JOIN
SELECT s.full_name, c.course_title
FROM Course c
RIGHT JOIN Enrolment e ON c.course_id = e.course_id
RIGHT JOIN Student s ON e.student_id = s.student_id
ORDER BY s.full_name ASC;
-- Explanation: Reverses the join direction using RIGHT JOIN to preserve all rows from Student. The LEFT JOIN version is much easier to read because queries naturally flow from the primary entity (Student) to its optional relationships.