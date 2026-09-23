-- =====================================================================
-- Employee Management System - Database Script
-- Database: employee_management
-- =====================================================================

DROP DATABASE IF EXISTS employee_management;
CREATE DATABASE employee_management;
USE employee_management;

-- ---------------------------------------------------------------------
-- Table: admin
-- ---------------------------------------------------------------------
CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

-- Default admin login -> username: admin | password: admin123
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- ---------------------------------------------------------------------
-- Table: departments
-- ---------------------------------------------------------------------
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

INSERT INTO departments (department_name, description) VALUES
('Human Resources', 'Handles recruitment and employee welfare'),
('Information Technology', 'Handles software and IT infrastructure'),
('Finance', 'Handles accounts and payroll'),
('Sales', 'Handles client relations and sales targets');

-- ---------------------------------------------------------------------
-- Table: employees
-- ---------------------------------------------------------------------
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    gender VARCHAR(10),
    dob DATE,
    department_id INT,
    designation VARCHAR(100),
    joining_date DATE,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

INSERT INTO employees (employee_name, email, phone, gender, dob, department_id, designation, joining_date, salary) VALUES
('Arun Kumar', 'arun.kumar@example.com', '9876543210', 'Male', '1995-06-12', 2, 'Software Engineer', '2022-01-10', 45000.00),
('Divya Sree', 'divya.sree@example.com', '9876543211', 'Female', '1996-03-25', 1, 'HR Executive', '2021-07-01', 35000.00),
('Karthik Raja', 'karthik.raja@example.com', '9876543212', 'Male', '1994-11-05', 3, 'Accountant', '2020-05-15', 40000.00);

-- ---------------------------------------------------------------------
-- Table: attendance
-- ---------------------------------------------------------------------
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL, -- Present / Absent / Leave
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

INSERT INTO attendance (employee_id, attendance_date, status) VALUES
(1, CURDATE(), 'Present'),
(2, CURDATE(), 'Present'),
(3, CURDATE(), 'Absent');

-- ---------------------------------------------------------------------
-- Table: salary
-- ---------------------------------------------------------------------
CREATE TABLE salary (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    basic_salary DECIMAL(10,2) NOT NULL,
    allowance DECIMAL(10,2) DEFAULT 0,
    deduction DECIMAL(10,2) DEFAULT 0,
    net_salary DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

INSERT INTO salary (employee_id, basic_salary, allowance, deduction, net_salary, payment_date) VALUES
(1, 40000.00, 8000.00, 2000.00, 46000.00, '2024-08-01'),
(2, 30000.00, 5000.00, 1000.00, 34000.00, '2024-08-01'),
(3, 35000.00, 6000.00, 1500.00, 39500.00, '2024-08-01');
