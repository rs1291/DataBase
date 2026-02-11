-- Create Database
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- Create Departments Table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- Create Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Insert Sample Departments
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert Sample Employees
INSERT INTO Employees (employee_id, employee_name, salary, department_id) VALUES
(101, 'John', 50000, 1),
(102, 'Emma', 60000, 2),
(103, 'Michael', 75000, 2),
(104, 'Sophia', 65000, 3),
(105, 'Daniel', 55000, 4),
(106, 'Olivia', 80000, 3);

------------------------------------------------------------
-- 1️⃣ Total Sum of All Salaries
SELECT SUM(salary) AS Total_Salary
FROM Employees;

------------------------------------------------------------
-- 2️⃣ Average Salary
SELECT AVG(salary) AS Average_Salary
FROM Employees;

------------------------------------------------------------
-- 3️⃣ Count of All Departments
SELECT COUNT(*) AS Total_Departments
FROM Departments;

------------------------------------------------------------
-- 4️⃣ Minimum Salary
SELECT MIN(salary) AS Minimum_Salary
FROM Employees;

------------------------------------------------------------
-- 5️⃣ Maximum Salary
SELECT MAX(salary) AS Maximum_Salary
FROM Employees;

------------------------------------------------------------
-- 6️⃣ All Details in One Query (Optional)
SELECT 
    SUM(salary) AS Total_Salary,
    AVG(salary) AS Average_Salary,
    MIN(salary) AS Minimum_Salary,
    MAX(salary) AS Maximum_Salary,
    (SELECT COUNT(*) FROM Departments) AS Total_Departments
FROM Employees;