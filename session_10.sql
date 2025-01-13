use sach123;

## Windows Functions in MySQL
/* Window functions in MySQL perform calculations across a set of table rows that are
 related to the current row. 
 Unlike aggregate functions (which return a single value for a group), 
 window functions retain individual row details while also computing results across 
 a window (a defined set of rows).
 
🔹 Types of Window Functions

Ranking Functions
RANK(), DENSE_RANK(), ROW_NUMBER()

Aggregate Window Functions
SUM(), AVG(), COUNT(), MAX(), MIN()

Value Functions
LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE()

Cumulative Distribution Functions
NTILE(), PERCENT_RANK(), CUME_DIST()


📝 Syntax

SELECT column_name, 
       function_name() OVER (PARTITION BY column_name ORDER BY column_name) AS alias
FROM table_name;


PARTITION BY: Divides the result into groups (like GROUP BY, but does not merge rows).
ORDER BY: Defines the order of rows within each partition.

*/

# 🔹 Example Table: Workers

create table Workers(
	id int primary key auto_increment,
    wname varchar(50),
    dept varchar(50),
    salary decimal(10,2)
);

insert into Workers (wname, dept, salary) values
					('Alice', 'HR', 50000),
					('Bob', 'HR', 60000),
					('Charlie', 'Finance', 70000),
					('David', 'Finance', 55000),
					('Eve', 'Finance', 80000),
					('Frank', 'HR', 40000);
                    
# 🔹 1. Using RANK() (Rank Based on Salary in Each Department)

select wname, dept, salary,
	   rank() over (partition by dept order by salary desc) as rank_position
from Workers;

# 🔹 2. Using ROW_NUMBER() (Unique Row Numbers per Department)

select wname, dept, salary,
	   row_number() over (partition by dept order by salary desc) as row_num
from Workers;

# 🔹 3. Using DENSE_RANK() (No Rank Gaps)

select wname, dept, salary,
	   dense_rank() over (partition by dept order by salary desc) as dense_rank_position
from Workers;


# 🔹 4. Using SUM() as a Window Function

select wname, dept, salary,
	sum(salary) over (partition by dept) as total_dept_salary
from Workers;

# 🔹 5. Using LEAD() & LAG() (Comparing Salary to Next & Previous Employee)

select wname, dept, salary,
	lag(salary) over(partition by dept order by salary) as prev_Salary,
    lead(salary) over( partition by dept order by salary) as next_Salary
from Workers;


# 🔹 6. Using NTILE() (Dividing Employees into 2 Salary Groups per Department)

select wname, dept, salary,
		ntile(2) over (partition by dept order by salary desc) as salary_group
from workers;

# 🔹 7. FIRST_VALUE() – Get First Employee by Salary in Each Department

select wname, dept, salary,
 first_value(wname) over (partition by dept order by salary asc) as lowest_Sal_emp
from Workers;

# 🔹 8. PERCENT_RANK() – Find the Relative Rank of Each Employee’s Salary

select wname, dept, salary,
	percent_rank() over (partition by dept order by salary) as per_rank
from Workers;

# 🔹 9. CUME_DIST() – Find the Cumulative Distribution of Salaries

select wname, dept, salary,
	cume_dist() over (partition by dept order by salary) as cumuetive_dist
from workers;

-- ----------------------------------------------------------------------------


# 🔹 Common Table Expressions (CTE) in MySQL

/*
A Common Table Expression (CTE) in MySQL allows you to create a temporary result set 
that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement.

📌 CTEs help improve readability and maintainability of complex queries.


🔹 Common Table Expressions (CTE) in MySQL
A Common Table Expression (CTE) in MySQL allows you to create a temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement.

📌 CTEs help improve readability and maintainability of complex queries.

📝 Syntax

WITH cte_name AS (
    SELECT column1, column2 
    FROM table_name 
    WHERE condition
)
SELECT * FROM cte_name;



WITH: Defines the CTE.
cte_name: The name of the temporary result set.
SELECT inside WITH: Generates the CTE data.
SELECT * FROM cte_name: Uses the CTE.
*/

## 🔹 Example 1: Using CTE to Simplify a Query

## Problem: Find employees with a salary greater than the department’s average.

select * from Workers;

with dept_avg_sal as (
	select dept, avg(salary) as avg_salary
    from Workers
    group by dept
    )
select w.wname, w.dept, w.salary, d.avg_salary
from Workers w
join dept_avg_sal d
on w.dept = d.dept
where w.salary > d.avg_salary;


## 🔹 Example 2: Recursive CTE (Hierarchical Data)
## Problem: Retrieve an organizational hierarchy from an employee table.

with recursive emp_hierarchy as (
	select emp_id, first_name,mgr_id, 1 as level
	from myemp
    where mgr_id = 0
    
	union all
    
    select e.emp_id, e.first_name, e.mgr_id, h.level + 1
    from myemp e
    join emp_hierarchy h 
    on e.mgr_id = h.emp_id
)
select * from emp_hierarchy;


## 🔹 Example 3: Using CTE in an UPDATE Statement

with high_salary as (
	select id, salary
    from Workers
    where salary > 70000
)

update Workers
set salary = salary * 1.1
where id in (select id from high_salary);

-- -------------------------------------------------------------------------------

# 🔹 CASE Statement in MySQL

/*
📌 CASE is a conditional expression in MySQL that works like an IF-ELSE statement.
📌 It evaluates conditions and returns values based on the first condition that is met.

📝 Syntax
CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
*/

## 🔹 Example 1: Salary Categories Using CASE

select wname, salary,
	case 
		when salary > 60000 then 'High Salary'
        when salary between 50000 and 60000 then 'Medium Salary'
        else 'Low Salary'
	end as salary_category
from Workers;

## 🔹 Example 3: Using CASE in ORDER BY

select * from Workers
order by
	case
		when dept = 'HR' then 1
        when dept = 'Finance' then 2
        else 3
	end;