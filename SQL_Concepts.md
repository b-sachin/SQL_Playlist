# SQL Concepts with Practical Examples

## **Step 1: Creating an Example Database**
```sql
CREATE DATABASE CompanyDB;
USE CompanyDB;
```

---

## **1. Basic SQL Commands**
### **Creating Tables**
```sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE
);
```
### **Inserting Data**
```sql
INSERT INTO Employees (first_name, last_name, hire_date)
VALUES ('Alice', 'Johnson', '2019-06-01'),
       ('Bob', 'Smith', '2020-07-15'),
       ('Charlie', 'Brown', '2018-08-10');
```
### **Retrieving Data**
```sql
SELECT * FROM Employees;
```
---

## **2. DDL & DML Commands**
### **ALTER Table**
```sql
ALTER TABLE Employees ADD COLUMN salary DECIMAL(10,2);
ALTER TABLE Employees MODIFY salary INT;
ALTER TABLE Employees DROP COLUMN salary;
```
### **DELETE & TRUNCATE**
```sql
DELETE FROM Employees WHERE emp_id = 2;
TRUNCATE TABLE Employees;
```
### **UPDATE**
```sql
UPDATE Employees SET last_name = 'Williams' WHERE first_name = 'Alice';
```
---

## **3. DELETE & TRUNCATE Operations**
### **Deleting Records**
```sql
DELETE FROM Employees WHERE first_name = 'Charlie';
```
### **Truncating a Table**
```sql
TRUNCATE TABLE Employees;
```
---

## **4. SELECT, DISTINCT, ORDER BY, Pattern Matching**
### **DISTINCT**
```sql
SELECT DISTINCT last_name FROM Employees;
```
### **ORDER BY**
```sql
SELECT * FROM Employees ORDER BY hire_date DESC;
```
### **LIKE Operator (Pattern Matching)**
```sql
SELECT * FROM Employees WHERE first_name LIKE 'A%';
SELECT * FROM Employees WHERE first_name LIKE '%s';
```
---

## **5. Constraints, Aggregation, and Grouping**
### **PRIMARY KEY, FOREIGN KEY, NOT NULL**
```sql
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL
);
ALTER TABLE Employees ADD COLUMN dept_id INT;
ALTER TABLE Employees ADD FOREIGN KEY (dept_id) REFERENCES Departments(dept_id);
```
### **Aggregate Functions**
```sql
SELECT COUNT(*) FROM Employees;
SELECT AVG(salary) FROM Employees;
SELECT SUM(salary) FROM Employees;
```
### **GROUP BY & HAVING**
```sql
SELECT dept_id, COUNT(*) FROM Employees GROUP BY dept_id;
SELECT dept_id, AVG(salary) FROM Employees GROUP BY dept_id HAVING AVG(salary) > 50000;
```
---

## **6. Transaction Control (TCL), Views, Indexing**
### **Transactions: COMMIT, ROLLBACK, SAVEPOINT**
```sql
START TRANSACTION;
UPDATE Employees SET salary = salary + 1000 WHERE dept_id = 1;
SAVEPOINT sp1;
UPDATE Employees SET salary = salary - 500 WHERE dept_id = 2;
ROLLBACK TO sp1;
COMMIT;
```
### **Views**
```sql
CREATE VIEW EmployeeSummary AS
SELECT first_name, last_name, hire_date FROM Employees;
SELECT * FROM EmployeeSummary;
```
### **Indexing**
```sql
CREATE INDEX idx_emp_name ON Employees(first_name);
SHOW INDEX FROM Employees;
```
---

## **7. Stored Procedures and User-Defined Functions (UDFs)**
### **Stored Procedure**
```sql
DELIMITER //
CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT * FROM Employees;
END //
DELIMITER ;
CALL GetEmployees();
```
### **User-Defined Function**
```sql
DELIMITER //
CREATE FUNCTION CalculateBonus(salary DECIMAL) RETURNS DECIMAL DETERMINISTIC
BEGIN
    RETURN salary * 0.10;
END //
DELIMITER ;
SELECT first_name, salary, CalculateBonus(salary) AS Bonus FROM Employees;
```
---

## **8. Loops, Exception Handling, Cursors**
### **Loops in Stored Procedures**
```sql
DELIMITER //
CREATE PROCEDURE PrintNumbers()
BEGIN
    DECLARE counter INT DEFAULT 1;
    myloop: LOOP
        IF counter > 5 THEN
            LEAVE myloop;
        END IF;
        SELECT counter;
        SET counter = counter + 1;
    END LOOP;
END //
DELIMITER ;
CALL PrintNumbers();
```
---

## **9. Triggers, Subqueries, and ENUM Data Type**
### **Triggers**
```sql
CREATE TABLE Employee_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    action VARCHAR(50),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER BeforeEmployeeDelete
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit (emp_id, action) VALUES (OLD.emp_id, 'Deleted');
END //
DELIMITER ;
```
### **Subquery Example**
```sql
SELECT first_name, salary FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);
```
### **ENUM Data Type**
```sql
CREATE TABLE Staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    role ENUM('Manager', 'Engineer', 'Analyst') DEFAULT 'Engineer'
);
```
---

## **10. Window Functions, CTEs, and CASE Statements**
### **Window Functions**
```sql
SELECT first_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS SalaryRank
FROM Employees;
```
### **Common Table Expressions (CTEs)**
```sql
WITH HighSalaryEmployees AS (
    SELECT * FROM Employees WHERE salary > 70000
)
SELECT * FROM HighSalaryEmployees;
```
### **CASE Statements**
```sql
SELECT first_name, salary,
       CASE
           WHEN salary > 60000 THEN 'High Salary'
           WHEN salary BETWEEN 40000 AND 60000 THEN 'Medium Salary'
           ELSE 'Low Salary'
       END AS SalaryCategory
FROM Employees;
```
---

# **Summary**
This guide covers all SQL concepts with practical examples, using a `CompanyDB` database. You now have a strong foundation in:
- Basic SQL operations  
- Data Definition & Manipulation  
- Aggregations & Grouping  
- Transactions, Views, and Indexing  
- Stored Procedures & Functions  
- Triggers & Subqueries  
- Window Functions, CTEs & CASE Statements  

Would you like more custom exercises or additional SQL concepts? 😊

