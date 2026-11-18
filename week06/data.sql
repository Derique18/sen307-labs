-- VUA-SEN307 Week 6 Practical Lab
-- Lab 4: Data Manipulation Language (DML)
-- Name: Chris-Derique Ehizo | Matric: VUG/SEN/24/12878

USE sen307_12878;

-- ==========================================
-- PART 1: Departments and Courses (Exact)
-- ==========================================
INSERT INTO Department (dept_name) VALUES
('Software Engineering'),
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity');

INSERT INTO Course (course_code, course_title, credit_units, description, dept_id) VALUES
('SEN307', 'Database Systems', 3,
 'Relational database design, SQL queries, normalization, transactions and indexing using MySQL.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('SEN301', 'Software Architecture', 3,
 'Architectural styles, design patterns, microservices and how to structure large software systems.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('COS301', 'Operating Systems', 3,
 'Processes, threads, CPU scheduling, memory management and file systems.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('COS305', 'Computer Networks', 3,
 'TCP/IP, routing, switching, LAN and WAN design and network protocols.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('AIN301', 'Introduction to Artificial Intelligence', 3,
 'Intelligent agents, search algorithms, knowledge representation and reasoning.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN305', 'Machine Learning', 3,
 'Supervised and unsupervised learning, neural networks, deep learning and model evaluation.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN307', 'Natural Language Processing', 3,
 'Text processing, word embeddings, language models, sentiment analysis and chatbots.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('DTS301', 'Data Visualization and Analytics', 2,
 'Exploratory data analysis, charts, dashboards and telling stories with data.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('DTS305', 'Big Data Technologies', 3,
 'Distributed storage and processing of very large datasets with Hadoop and Spark.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('CYB301', 'Network Security', 3,
 'Firewalls, cryptography, intrusion detection and protecting networks from attacks.',
 (SELECT dept_id FROM Department WHERE dept_name = 'Cybersecurity'));

-- ==========================================
-- PART 2: Lecturers (10), Students (20), Enrolments (40), Allocations (11)
-- ==========================================
INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor', 'a.okafor@vua.edu.ng', 1),
('VUA/ST/102', 'Dr Musa Bello', 'm.bello@vua.edu.ng', 1),
('VUA/ST/103', 'Prof Chinedu Eze', 'c.eze@vua.edu.ng', 2),
('VUA/ST/104', 'Dr Fatima Danjuma', 'f.danjuma@vua.edu.ng', 2),
('VUA/ST/105', 'Dr Tunde Adeyemi', 't.adeyemi@vua.edu.ng', 3),
('VUA/ST/106', 'Mrs Ngozi Nwosu', 'n.nwosu@vua.edu.ng', 3),
('VUA/ST/107', 'Dr Ibrahim Suleiman', 'i.suleiman@vua.edu.ng', 4),
('VUA/ST/108', 'Mr Emeka Obi', 'e.obi@vua.edu.ng', 4),
('VUA/ST/109', 'Dr Zainab Abubakar', 'z.abubakar@vua.edu.ng', 5),
('VUA/ST/110', 'Mr David Bassey', 'd.bassey@vua.edu.ng', 5);

INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('VUG/SEN/24/12878', 'Chris-Derique Ehizo', 'M', '2005-06-15', 1),
('VUG/SEN/24/11201', 'Esmond Oise-amu', 'M', '2004-09-20', 1),
('VUG/SEN/24/12003', 'Adaeze Okafor', 'F', '2004-05-14', 1),
('VUG/SEN/24/12004', 'Chidinma Nwachukwu', 'F', '2005-08-22', 1),
('VUG/CSC/24/12005', 'John Musa', 'M', '2004-11-02', 2),
('VUG/CSC/24/12006', 'Aisha Abdullahi', 'F', '2005-02-18', 2),
('VUG/CSC/24/12007', 'Samuel Uduokhai', 'M', '2003-12-10', 2),
('VUG/CSC/24/12008', 'Blessing Okonkwo', 'F', '2006-01-30', 2),
('VUG/AIN/24/12009', 'Zainab Yusuf', 'F', '2004-07-19', 3),
('VUG/AIN/24/12010', 'Halima Lawal', 'F', '2005-10-11', 3),
('VUG/AIN/24/12011', 'Joseph Terver', 'M', '2004-04-25', 3),
('VUG/AIN/24/12012', 'Daniel Marquis', 'M', '2006-03-08', 3),
('VUG/DTS/24/12013', 'Grace Akpan', 'F', '2005-09-12', 4),
('VUG/DTS/24/12014', 'Victor Osei', 'M', '2003-08-17', 4),
('VUG/DTS/24/12015', 'Maryam Sani', 'F', '2004-12-05', 4),
('VUG/DTS/24/12016', 'Peter Onuoha', 'M', '2007-01-14', 4),
('VUG/CYB/24/12017', 'Deborah Peters', 'F', '2005-04-03', 5),
('VUG/CYB/24/12018', 'Kelechi Ibe', 'M', '2004-02-28', 5),
('VUG/SEN/24/12019', 'Favour Eze', 'F', '2006-07-09', 1),
('VUG/CSC/24/12020', 'Emmanuel Balogun', 'M', '2005-11-21', 2);

-- 40 Enrolments (Students 19 & 20 intentionally left with 0 enrolments for Lab 5)
INSERT INTO Enrolment (student_id, course_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 3), (2, 4),
(3, 1), (3, 2), (3, 5),
(4, 1), (4, 5), (4, 6),
(5, 1), (5, 7),
(6, 1), (6, 8),
(7, 1), (7, 9),
(8, 2), (8, 10),
(9, 3), (9, 4),
(10, 5), (10, 6),
(11, 7), (11, 8),
(12, 9), (12, 10),
(13, 2), (13, 4),
(14, 3), (14, 6),
(15, 5), (15, 8),
(16, 7), (16, 9),
(17, 4), (17, 10),
(18, 2), (18, 6);

-- 11 Course Allocations (Course 1 has two lecturers)
INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1, 1), (1, 2),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- ==========================================
-- PART 3: UPDATE a Record
-- ==========================================
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = 'VUG/CSC/24/12005';
UPDATE Student SET dept_id = 1 WHERE matric_no = 'VUG/CSC/24/12005';
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = 'VUG/CSC/24/12005';

-- ==========================================
-- PART 4: Referential Integrity Exercise
-- ==========================================
INSERT INTO Department (dept_name) VALUES ('Library and Information Science');
INSERT INTO Student (matric_no, full_name, dept_id)
VALUES ('20239999', 'Transfer Student',
(SELECT dept_id FROM Department WHERE dept_name = 'Library and Information Science'));

-- Step 2: Run this line ALONE and screenshot Error 1451
DELETE FROM Department WHERE dept_name = 'Library and Information Science';

-- Step 3: Reassign student and delete department cleanly
UPDATE Student
SET dept_id = (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')
WHERE matric_no = '20239999';

DELETE FROM Department WHERE dept_name = 'Library and Information Science';

-- ==========================================
-- FINAL CHECK (Screenshot this result)
-- ==========================================
SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;