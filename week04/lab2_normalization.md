# VUA-SEN307 Lab 2: Database Design & Normalization

**Name:** Derique  
**Matric Number:** 12878  
**Course:** VUA-SEN307 Database Systems  

---

## 1. Unnormalized Form (UNF)

| matric_no | student_name | student_dept | course_codes | course_titles | lecturers | lecturer_depts | session |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 12878 | Ada Obi | Software Engineering | SEN307, SEN301 | Database Systems, Software Architecture | Dr A. Okafor, Dr M. Bello | Software Eng., Software Eng. | 2026/2027 |
| 20231235 | John Musa | Computer Science | SEN307, COS301 | Database Systems, Operating Systems | Dr A. Okafor, Mrs F. Eze | Software Eng., Computer Sci. | 2026/2027 |
| 20231236 | Grace Okon | Software Engineering | SEN301 | Software Architecture | Dr M. Bello | Software Eng. | 2026/2027 |

---

## 2. First Normal Form (1NF)

**Explanation:** Fixed by expanding all repeating values into individual atomic rows so each cell contains exactly one value, establishing a composite primary key `(matric_no, course_code, lecturer_name)`[cite: 16].

| matric_no | student_name | student_dept | course_code | course_title | lecturer_name | lecturer_dept | session |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 12878 | Ada Obi | Software Engineering | SEN307 | Database Systems | Dr A. Okafor | Software Eng. | 2026/2027 |
| 12878 | Ada Obi | Software Engineering | SEN301 | Software Architecture | Dr M. Bello | Software Eng. | 2026/2027 |
| 20231235 | John Musa | Computer Science | SEN307 | Database Systems | Dr A. Okafor | Software Eng. | 2026/2027 |
| 20231235 | John Musa | Computer Science | COS301 | Operating Systems | Mrs F. Eze | Computer Sci. | 2026/2027 |
| 20231236 | Grace Okon | Software Engineering | SEN301 | Software Architecture | Dr M. Bello | Software Eng. | 2026/2027 |

---

## 3. Second Normal Form (2NF)

**Explanation:** Fixed partial dependencies by separating student, course, and enrolment information into distinct entity tables so attributes depend on the entire primary key[cite: 16].

* **Student Table:** `(matric_no [PK], student_name, student_dept)`
* **Course Table:** `(course_code [PK], course_title)`
* **Lecturer Table:** `(lecturer_id [PK], lecturer_name, lecturer_dept)`
* **Enrolment Table:** `(enrolment_id [PK], matric_no [FK], course_code [FK], session)`
* **Course_Teaching Table:** `(teaching_id [PK], course_code [FK], lecturer_id [FK], session)`

---

## 4. Third Normal Form (3NF)

**Explanation:** Fixed transitive dependencies by moving department details into a dedicated `Department` table to ensure non-key attributes depend only on primary keys[cite: 17].

---

## 5. Final Relational Schema

* **Department** (`dept_id` [PK], `dept_name`)[cite: 17]
* **Student** (`student_id` [PK], `matric_no`, `full_name`, `dept_id` [FK -> Department.dept_id])[cite: 17]
* **Lecturer** (`lecturer_id` [PK], `full_name`, `dept_id` [FK -> Department.dept_id])[cite: 17]
* **Course** (`course_id` [PK], `course_code`, `course_title`)[cite: 17]
* **Course_Assignment** (`assignment_id` [PK], `course_id` [FK -> Course.course_id], `lecturer_id` [FK -> Lecturer.lecturer_id], `session`)[cite: 17]
* **Enrolment** (`enrolment_id` [PK], `student_id` [FK -> Student.student_id], `course_id` [FK -> Course.course_id], `session`)[cite: 17]