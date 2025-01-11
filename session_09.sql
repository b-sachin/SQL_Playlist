use sach123;

## Triggers in MySQL
/* A Trigger in MySQL is a special type of stored procedure that automatically 
executes when a specified event occurs on a table (such as INSERT, UPDATE, or DELETE).

🔹 Why Use Triggers?
✅ Automate actions before or after data modifications
✅ Enforce business rules (e.g., preventing negative stock values)
✅ Maintain audit logs (track changes in tables)
✅ Ensure data consistency

🔹 Types of Triggers in MySQL
MySQL supports six types of triggers:

Trigger Type	Event
BEFORE INSERT	Executes before inserting a record
AFTER INSERT	Executes after inserting a record
BEFORE UPDATE	Executes before updating a record
AFTER UPDATE	Executes after updating a record
BEFORE DELETE	Executes before deleting a record
AFTER DELETE	Executes after deleting a record

🔹 Syntax of a Trigger

CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW
BEGIN
    -- Trigger logic here
END;

*/

## 🔹 Example 1: Trigger for Audit Log (AFTER INSERT)

-- Create Audit Table
create table employee_log(
	log_id int auto_increment primary key,
    employee_id int,
    actions varchar(255),
    log_time timestamp default current_timestamp);
    
    drop table employee_log;
    
-- Create Trigger
delimiter //
create trigger emp_log_entry
after insert on myemp
for each row
begin
	insert into employee_log(employee_id, actions)
    values (new.emp_id,"New Employee Added");
end //
delimiter ;

select * from employee_log;

select * from myemp;

insert into myemp values(207,"Salman", "Khan", "Sallu", "1997-10-01", "AC_ACCOUNT", 9500.00, 0.00,	205, 110);

select * from employee_log;

-- -----------------------------------------------------------------

## 🔹 Example 2: Prevent Negative Stock (BEFORE UPDATE)

delimiter //
create trigger negative_stock_check
before update on products
for each row
begin
	if new.qtyInStock < 0  then
		set new.qtyInStock = 0;
	end if;
end //
delimiter ;

###################

update products set qtyInStock = -100 where pcode = 'S32_3522';

-- -----------------------------------------------------------------

## Subquery in MySQL
/* 
A subquery (also called an inner query or nested query) is a SQL query inside another query. 
It is used to fetch data that will be used in the main query (outer query).

🔹 Why Use Subqueries?
✅ Filter data dynamically based on another query
✅ Perform calculations inside queries
✅ Replace complex joins in some cases
✅ Use results of one query inside another

🔹 Types of Subqueries in MySQL
Type	Description
Single-row subquery	Returns one value
Multi-row subquery	Returns multiple values
Correlated subquery	Uses the outer query’s data
Nested subquery	Subquery inside another subquery

🔹 Syntax of a Subquery
SELECT column_name 
FROM table_name
WHERE column_name OPERATOR (SELECT column_name FROM another_table WHERE condition);

🔹 Subquery is enclosed in parentheses ()
🔹 Used in WHERE, SELECT, FROM, or HAVING clauses
*/

## Example 1: Subquery in WHERE Clause

# Find employees with a salary greater than the average salary.

select * from myemp;

select avg(salary) from myemp;

select emp_id, first_name, salary
from myemp
where salary > (select avg(salary) from myemp);

##########################################################

## Example 2: Subquery in SELECT Clause

# Find each employee's department name (without using a JOIN).

-- creating the departments .

create table department (
	id int primary key auto_increment,
    dept_name varchar(100) not null
    );
    
-- creating the employee table

create table employees(
	id int primary key auto_increment,
    emp_name varchar(100) not null,
    dept_id int,
    foreign key (dept_id) references department(id) on delete cascade
    );
    
insert into department (dept_name) values
	("HR"),
    ("Finance"),
    ("Engineering");
    
insert into employees (emp_name, dept_id) values
("Alice",1),
("Bob",2),
("Charlie",3),
("Devid",2);

-- Find each employee's department name (without using a JOIN).

select emp_name, (select dept_name from department where department.id = employees.dept_id) as departments
from employees;


-- Find each employee's department name (with JOIN).
select emp_name, dept_name
from employees
join department
on employees.dept_id = department.id;

##############################################################

## Example 3: Subquery in FROM Clause (Derived Table)

# Find top 3 highest-paid employees.
select * from myemp;


select emp_id, first_name, salary
from (select * from myemp order by salary desc limit 3) as top_salaries;


select emp_id, first_name, salary
from myemp
order by SALARY desc
limit 3;

##############################################################

## Example 4: Subquery in FROM Clause (Derived Table)

# Find top 3 highest-paid employees.

alter table department add column location varchar(100);
update department set location = "mumbai" where id = 2;
update department set location = "banglore" where id = 1;
update department set location = "delhi" where id = 3;

select emp_name from employees
where dept_id in (select id from department where location = "Mumbai");

##############################################################

## Example 5: Correlated Subquery

# Find employees earning above the average salary of their own department.

ALTER TABLE employees ADD COLUMN salary DECIMAL(10,2) NOT NULL DEFAULT 0;

update employees set salary = 
	case
		when emp_name = "Alice" then 50000
        when emp_name = "Bob" then 60000
        when emp_name = "Charlie" then 70000
        when emp_name = "Devid" then 55000
	end;
    

# Find employees earning above the average salary of their own department.

select emp_name, salary, dept_id
from employees e1
where salary > (select avg(salary) from employees e2 where e1.dept_id = e2.dept_id);

-- ----------------------------------------------------------------------------------------

## COALESCE() Function in MySQL
/* 
The COALESCE() function in MySQL is used to return the first non-NULL value from a list of expressions. 
If all values are NULL, it returns NULL.

🔹 Syntax

COALESCE(expression1, expression2, ..., expressionN)

✅ Returns the first non-NULL value in the given list.
✅ If all arguments are NULL, it returns NULL.
*/


## Example 1: Handling NULL Values in SELECT

select first_name, coalesce(movieid,"No Movie Assigned") as movie
from members;

### If movieid is NULL, it will return 'No Movie Assigned' instead of NULL.

##########################################

## Example 2: Using COALESCE() for movieid Default Value

desc employees;
alter table employees modify salary decimal(10,2) null;
update employees set salary = null where id = 3;

SELECT emp_name, COALESCE(salary, 30000) AS salary
FROM employees;

### If an employee's salary is NULL, it will default to 30,000.

##########################################

## Example 3: Using COALESCE() with NULL Data

SELECT COALESCE(NULL, NULL, 'Hello', 'World') AS result;

# ✅ Output: 'Hello'
# 💡 The first non-NULL value is 'Hello', so it is returned.

-- ----------------------------------------------------------------------------------------------

## ENUM Data Type in MySQL
/* 
The ENUM data type in MySQL is used to store a predefined set of string values. 
It allows only one value from the specified list, making it useful for columns with 
limited options, like gender, status, or categories.

🔹 Syntax

CREATE TABLE table_name (
    column_name ENUM('value1', 'value2', 'value3', ...) 
);

✅ Stores predefined values
✅ Takes less storage compared to VARCHAR
✅ Allows only valid values from the list
*/

# 🔹 Example 1: Creating a Table with ENUM
create table staff (
	id int primary key auto_increment,
    sname varchar(100),
    gender enum('Male','Female','Other') default 'Other'
    );
    
    # 💡 Only 'Male', 'Female', or 'Other' can be stored in the gender column.
    
# 🔹 Example 2: Inserting Data

insert into staff (sname, gender) values
				  ('Alice','Female'),
                  ('Bob', 'Male'),
                  ('Charlie','Other');

# Example 3: Checking ENUM Values

show columns from staff like 'gender';

# 🔹 Example 4: Sorting ENUM Values

select * from staff order by gender;
	
    # 💡 Sorts as: 'Male' → 'Female' → 'Other' (based on the order in the ENUM definition).
    
# 🔹 Example 5: Using ENUM in WHERE Clause

select * from staff where gender = 'Male';