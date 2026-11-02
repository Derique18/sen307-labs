# VUA-SEN307 Lab 3: Data Definition Language (DDL) & Constraint Testing

**Name:** Chris-Derique Ehizo

**Matric Number:** VUG/SEN/24/12878

**Course:** VUA-SEN307 Database Systems

**Database Schema:** sen307_12878

## 1. Schema Overview

The database schema `sen307_12878` consists of 6 tables implementing primary key, foreign key, non-null, unique, default, check, and enumeration constraints:

1. `Department` (Parent entity for academic departments)

2. `Lecturer` (Staff records linked to Department)

3. `Student` (Student records linked to Department)

4. `Course` (Academic courses linked to Department)

5. `Enrolment` (Junction table for Student-Course registration)

6. `CourseAllocation` (Junction table for Course-Lecturer assignments)

## 2. Table Structures & Attributes

* **Department:** `dept_id` (PK, AUTO_INCREMENT), `dept_name` (VARCHAR(100), UNIQUE, NOT NULL)

* **Lecturer:** `lecturer_id` (PK, AUTO_INCREMENT), `staff_no` (VARCHAR(20), UNIQUE, NOT NULL), `full_name` (VARCHAR(100), NOT NULL), `email` (VARCHAR(100), UNIQUE), `dept_id` (FK -> Department.dept_id, NOT NULL)

* **Student:** `student_id` (PK, AUTO_INCREMENT), `matric_no` (VARCHAR(20), UNIQUE, NOT NULL), `full_name` (VARCHAR(100), NOT NULL), `phone` (VARCHAR(15)), `gender` (ENUM('M','F')), `date_of_birth` (DATE), `dept_id` (FK -> Department.dept_id)

* **Course:** `course_id` (PK, AUTO_INCREMENT), `course_code` (VARCHAR(10), UNIQUE, NOT NULL), `course_title` (VARCHAR(150), NOT NULL), `credit_units` (TINYINT, DEFAULT 3, CHECK 1..6), `description` (TEXT), `dept_id` (FK -> Department.dept_id)

* **Enrolment:** `enrolment_id` (PK, AUTO_INCREMENT), `student_id` (FK -> Student.student_id, NOT NULL), `course_id` (FK -> Course.course_id, NOT NULL), `academic_session` (VARCHAR(9), DEFAULT '2026/2027'), `semester` (ENUM('First','Second'), DEFAULT 'First'), `enrolled_on` (DATE, DEFAULT CURRENT_DATE), UNIQUE(`student_id`, `course_id`, `academic_session`)

* **CourseAllocation:** `allocation_id` (PK, AUTO_INCREMENT), `course_id` (FK -> Course.course_id, NOT NULL), `lecturer_id` (FK -> Lecturer.lecturer_id, NOT NULL), `academic_session` (VARCHAR(9), DEFAULT '2026/2027'), UNIQUE(`course_id`, `lecturer_id`, `academic_session`)

## 3. Constraint Verification & Error Test Log

### Test 1: NOT NULL Constraint Check

* **SQL Query:**

  ```
  INSERT INTO Department (dept_name) VALUES (NULL);
  
  ```

* **Observed MySQL Error Message:**
  `Error Code: 1048. Column 'dept_name' cannot be null`

* **Status:** PASSED (NOT NULL constraint successfully blocked NULL insertion).

### Test 2: CHECK Constraint Check

* **SQL Query:**

  ```
  INSERT INTO Course (course_code, course_title, credit_units) VALUES ('TST101', 'Test', 9);
  
  ```

* **Observed MySQL Error Message:**
  `Error Code: 3819. Check constraint 'chk_credit_units' is violated.`

* **Status:** PASSED (CHECK constraint restricted credit units outside 1–6 range).

### Test 3: FOREIGN KEY Constraint Check

* **SQL Query:**

  ```
  INSERT INTO Student (matric_no, full_name, dept_id) VALUES ('TEST001', 'Test Student', 999);
  
  ```

* **Observed MySQL Error Message:**
  `Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails`

* **Status:** PASSED (Foreign key constraint prevented referencing a non-existent `dept_id`).

### Test 4: ENUM Constraint Check

* **SQL Query:**

  ```
  INSERT INTO Student (matric_no, full_name, gender) VALUES ('TEST002', 'Test Student', 'X');
  
  ```

* **Observed MySQL Error Message:**
  `Error Code: 1265. Data truncated for column 'gender' at row 1`

* **Status:** PASSED (ENUM constraint rejected values other than 'M' or 'F').

### Test 5: Custom UNIQUE Constraint Check

* **SQL Query:**

  ```
  INSERT INTO Department (dept_name) VALUES ('Software Engineering');
  INSERT INTO Department (dept_name) VALUES ('Software Engineering'); -- Second run
  
  ```

* **Observed MySQL Error Message:**
  `Error Code: 1062. Duplicate entry 'Software Engineering' for key 'department.dept_name'`

* **Status:** PASSED (UNIQUE constraint prevented duplicate department names).

## 4. Verification Evidence

Screenshots saved in repository:

* `describe_department.png`

* `describe_lecturer.png`

* `describe_student.png`

* `describe_course.png`

* `describe_enrolment.png`

* `describe_courseallocation.png`

* `lab3_erd.png`