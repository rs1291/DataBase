DROP TABLE IF EXISTS enrollments;
GO
DROP TABLE IF EXISTS courses;
GO
DROP TABLE IF EXISTS students;
GO

CREATE TABLE students (
  student_id INT IDENTITY(1,1) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name  VARCHAR(50) NOT NULL,
  email      VARCHAR(120) UNIQUE NOT NULL,
  grade_level INT NOT NULL CHECK (grade_level BETWEEN 1 AND 12),
  city       VARCHAR(80),
  state      VARCHAR(2),
  gpa        DECIMAL(3,2) CHECK (gpa BETWEEN 0.00 AND 4.00),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
GO

CREATE TABLE courses (
  course_id INT IDENTITY(1,1) PRIMARY KEY,
  course_code VARCHAR(20) UNIQUE NOT NULL,
  course_name VARCHAR(120) NOT NULL,
  department  VARCHAR(60) NOT NULL,
  credits     INT NOT NULL CHECK (credits BETWEEN 1 AND 6),
  start_date  DATE NOT NULL,
  end_date    DATE NOT NULL,
  capacity    INT NOT NULL CHECK (capacity > 0)
);
GO

CREATE TABLE enrollments (
  enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
  student_id INT NOT NULL,
  course_id  INT NOT NULL,
  enrolled_on DATE NOT NULL DEFAULT CURRENT_DATE,
  status VARCHAR(20) NOT NULL CHECK (status IN ('enrolled','dropped','completed')),
  score DECIMAL(5,2) CHECK (score BETWEEN 0 AND 100),
  CONSTRAINT fk_enr_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
  CONSTRAINT fk_enr_course  FOREIGN KEY (course_id)  REFERENCES courses(course_id)  ON DELETE CASCADE,
  CONSTRAINT uq_student_course UNIQUE (student_id, course_id)
);
GO

INSERT INTO students (first_name, last_name, email, grade_level, city, state, gpa) VALUES
('Ava','Patel','ava.patel@school.edu',10,'Austin','TX',3.78),
('Noah','Kim','noah.kim@school.edu',11,'Seattle','WA',3.22),
('Mia','Garcia','mia.garcia@school.edu',9,'Miami','FL',3.91),
('Liam','Nguyen','liam.nguyen@school.edu',12,'San Jose','CA',2.88),
('Sophia','Johnson','sophia.johnson@school.edu',10,'Denver','CO',3.45),
('Ethan','Brown','ethan.brown@school.edu',11,'Boston','MA',3.05),
('Isabella','Davis','isabella.davis@school.edu',9,'Phoenix','AZ',3.60),
('Lucas','Wilson','lucas.wilson@school.edu',12,'Chicago','IL',2.67),
('Amelia','Martinez','amelia.martinez@school.edu',10,'Los Angeles','CA',3.84),
('Oliver','Taylor','oliver.taylor@school.edu',11,'Portland','OR',3.12);
GO

INSERT INTO courses (course_code, course_name, department, credits, start_date, end_date, capacity) VALUES
('SQL101','SQL Fundamentals','Computer Science',3,'2026-01-15','2026-05-15',30),
('DS201','Data Science I','Computer Science',4,'2026-01-15','2026-05-15',25),
('MATH150','Statistics','Mathematics',3,'2026-01-15','2026-05-15',35),
('ENG210','Technical Writing','English',3,'2026-01-15','2026-05-15',40),
('BUS120','Business Analytics','Business',3,'2026-01-15','2026-05-15',28);
GO

INSERT INTO enrollments (student_id, course_id, status, score) VALUES
(1,1,'enrolled',88.50),
(1,3,'enrolled',92.00),
(2,1,'enrolled',76.25),
(2,2,'enrolled',81.00),
(3,1,'enrolled',95.00),
(3,4,'enrolled',89.50),
(4,2,'enrolled',68.00),
(4,3,'enrolled',71.25),
(5,1,'enrolled',84.00),
(5,5,'enrolled',90.00),
(6,3,'enrolled',73.00),
(6,4,'enrolled',79.50),
(7,1,'enrolled',86.75),
(7,2,'enrolled',88.25),
(8,5,'enrolled',65.00),
(8,4,'enrolled',72.50),
(9,1,'enrolled',93.25),
(9,2,'enrolled',91.00),
(10,3,'enrolled',77.00),
(10,5,'enrolled',80.50);
GO

ALTER TABLE students ADD phone VARCHAR(20);
GO

UPDATE students
SET phone = CASE student_id
  WHEN 1 THEN '512-555-0101'
  WHEN 2 THEN '206-555-0102'
  WHEN 3 THEN '305-555-0103'
  WHEN 4 THEN '408-555-0104'
  WHEN 5 THEN '303-555-0105'
  WHEN 6 THEN '617-555-0106'
  WHEN 7 THEN '602-555-0107'
  WHEN 8 THEN '312-555-0108'
  WHEN 9 THEN '213-555-0109'
  WHEN 10 THEN '503-555-0110'
  ELSE NULL
END;

UPDATE students
SET gpa = 3.30, city = 'San Francisco', state = 'CA'
WHERE email = 'liam.nguyen@school.edu';

UPDATE enrollments
SET score = 83.00
WHERE student_id = 2 AND course_id = 2;

DELETE FROM enrollments
WHERE student_id = 8 AND course_id = 4;

INSERT INTO enrollments (student_id, course_id, status, score)
VALUES (8,4,'enrolled',74.00);
GO

SELECT student_id, first_name, last_name, grade_level, city, state, gpa
FROM students;

SELECT student_id, first_name, last_name, gpa
FROM students
WHERE gpa >= 3.50
ORDER BY gpa DESC, last_name ASC;

SELECT student_id, first_name, last_name, state, gpa
FROM students
WHERE state IN ('CA','TX','WA')
ORDER BY state, gpa DESC;

SELECT student_id, first_name, last_name, grade_level, gpa
FROM students
WHERE grade_level BETWEEN 10 AND 12
ORDER BY grade_level, gpa DESC;

SELECT student_id, first_name, last_name, email
FROM students
WHERE email LIKE '%.edu'
ORDER BY last_name, first_name;

SELECT c.department, COUNT(*) AS course_count, AVG(c.credits) AS avg_credits
FROM courses c
GROUP BY c.department
ORDER BY course_count DESC, c.department;

SELECT e.course_id, c.course_code, c.course_name, COUNT(*) AS enrolled_students, AVG(e.score) AS avg_score
FROM enrollments e
JOIN courses c ON c.course_id = e.course_id
WHERE e.status = 'enrolled'
GROUP BY e.course_id, c.course_code, c.course_name
ORDER BY enrolled_students DESC, avg_score DESC;

SELECT s.student_id, s.first_name, s.last_name, COUNT(*) AS courses_taken, AVG(e.score) AS avg_score
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
WHERE e.status = 'enrolled'
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(*) >= 2
ORDER BY avg_score DESC, courses_taken DESC;

SELECT s.student_id, s.first_name, s.last_name, c.course_code, c.course_name, e.score
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses  c ON c.course_id = e.course_id
WHERE c.department = 'Computer Science'
ORDER BY e.score DESC, s.last_name, s.first_name;

SELECT s.student_id, s.first_name, s.last_name
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.student_id
WHERE e.enrollment_id IS NULL
ORDER BY s.last_name, s.first_name;

SELECT c.course_id, c.course_code, c.course_name, COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.course_id AND e.status = 'enrolled'
GROUP BY c.course_id, c.course_code, c.course_name
ORDER BY total_enrollments DESC, c.course_code;

SELECT s.student_id, s.first_name, s.last_name, s.gpa,
       CASE
         WHEN s.gpa >= 3.70 THEN 'Honors'
         WHEN s.gpa >= 3.00 THEN 'Good Standing'
         ELSE 'At Risk'
       END AS academic_status
FROM students s
ORDER BY s.gpa DESC, s.last_name, s.first_name;

WITH course_stats AS (
  SELECT e.course_id, AVG(e.score) AS avg_score, COUNT(*) AS n
  FROM enrollments e
  WHERE e.status = 'enrolled'
  GROUP BY e.course_id
)
SELECT c.course_code, c.course_name, cs.n AS enrolled_students, cs.avg_score
FROM course_stats cs
JOIN courses c ON c.course_id = cs.course_id
WHERE cs.n >= 3
ORDER BY cs.avg_score DESC;
GO

GO

DROP VIEW IF EXISTS v_student_course_scores;
GO

CREATE VIEW v_student_course_scores AS
SELECT s.student_id, s.first_name, s.last_name, s.grade_level, s.state,
       c.course_code, c.course_name, c.department,
       e.status, e.score, e.enrolled_on
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id;

SELECT *
FROM v_student_course_scores
WHERE status = 'enrolled' AND score >= 85
ORDER BY score DESC, last_name, first_name, course_code;

SELECT department, COUNT(*) AS high_scores
FROM v_student_course_scores
WHERE status = 'enrolled' AND score >= 90
GROUP BY department
ORDER BY high_scores DESC, department;
GO

if object_id('student_audit', 'U') is null
CREATE TABLE student_audit (
  audit_id INT IDENTITY(1,1) PRIMARY KEY,
  student_id INT NOT NULL,
  changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  field_name VARCHAR(50) NOT NULL,
  old_value VARCHAR(200),
  new_value VARCHAR(200)
);
GO

INSERT INTO student_audit (student_id, field_name, old_value, new_value)
SELECT s.student_id, 'city', s.city, 'Dallas'
FROM students s
WHERE s.email = 'ava.patel@school.edu';
GO

UPDATE students
SET city = 'Dallas', state = 'TX'
WHERE email = 'ava.patel@school.edu';
GO

SELECT *
FROM student_audit
ORDER BY changed_at DESC, audit_id DESC;

SELECT s.state,
       COUNT(*) AS student_count,
       ROUND(AVG(s.gpa), 2) AS avg_gpa
FROM students s
GROUP BY s.state
ORDER BY avg_gpa DESC, student_count DESC, s.state;

SELECT s.student_id, s.first_name, s.last_name,
       SUM(c.credits) AS total_credits,
       ROUND(AVG(e.score), 2) AS avg_score
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN courses c ON c.course_id = e.course_id
WHERE e.status = 'enrolled'
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY total_credits DESC, avg_score DESC, s.last_name, s.first_name;

SELECT c.course_code, c.course_name, c.capacity,
       COUNT(e.enrollment_id) AS enrolled_count,
       (c.capacity - COUNT(e.enrollment_id)) AS seats_remaining
FROM courses c
LEFT JOIN enrollments e
  ON e.course_id = c.course_id AND e.status = 'enrolled'
GROUP BY c.course_code, c.course_name, c.capacity
ORDER BY seats_remaining ASC, enrolled_count DESC, c.course_code;