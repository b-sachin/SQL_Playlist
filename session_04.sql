use sach123;
select * from myemp;

#limit'
select * from myemp limit 5;

# selected column instread of all
select emp_id,first_name, last_name, salary from myemp;

select emp_id,first_name, last_name, salary from myemp limit 5;

#distinct clause

select * from myemp;
select distinct dep_id from myemp;

#total number of departments
select count(distinct dep_id) from myemp;

select distinct job_id from myemp;
select count(distinct job_id) from myemp;

select distinct mgr_id from myemp;
select count(distinct mgr_id) from myemp;

select distinct dep_id,mgr_id from myemp;
select count(distinct dep_id,mgr_id) from myemp;

select distinct dep_id,job_id from myemp;
select count(distinct dep_id,job_id) from myemp;

# order by clause

select distinct dep_id,mgr_id from myemp;
select distinct dep_id,mgr_id from myemp order by dep_id;
select distinct dep_id,mgr_id from myemp order by dep_id desc;
select distinct dep_id,mgr_id from myemp order by dep_id desc, mgr_id asc;

desc myemp; # it is different


############################################################################
 
 # Derived Column 
 
 select * from myemp;
 
 select emp_id, first_name, last_name, salary, salary*0.1 as bonus from myemp limit 5;
 
  select emp_id, first_name, last_name, salary + salary*0.1 as total_salary from myemp limit 5;
  
  #################################################################################################
  
  # Comparison Operator
  
  select * from myemp where dep_id = 80;
  
  select * from myemp where dep_id != 50;
  
	select * from myemp where dep_id != 50 order by dep_id;
    
select * from myemp where salary >10000;

select * from myemp where salary >10000 order by salary;

select * from myemp;

select *, year(hire_date),month(hire_date),day(hire_date) from myemp;

# Extract emp details who are hire after year 2000

select * from myemp where year(hire_date) >2000;

# Extract emp details who are hire after 1-jan-2000

select * from myemp where hire_date > "2000-01-01";

select * from myemp where hire_date > "2000-01-01" order by hire_date;

select * from myemp where hire_date > "2000-07-24" order by hire_date;

##############################################################################

# Logical Operator (and, or, not)

select * from myemp where dep_id = 30 or dep_id = 90;

select * from myemp where dep_id = 80 and salary > 10000;

select * from myemp where dep_id = 30 or dep_id = 60 or dep_id = 90; 

select * from myemp where dep_id in (30,60,90); # good alternative to previous statement

# if we ant data except dep_id 20,40 and 60

select * from myemp where dep_id not in (20,40,60);

select * from myemp where dep_id between 20 and 60;

select * from myemp where salary between 20000 and 30000;

# Pattern matching

/*
pattern matching is done over charactor datatype

% - It acts as a multiple character placeholder
_ - It acts as a sinlge character placeholder
*/


select * from myemp;

select * from myemp where first_name like "a%"; # first_name starts with 'a'

select * from myemp where first_name like "%a"; # first_name ends with 'a'

select * from myemp where first_name like "%a%"; # first_name that has 'a' letter in between.

select * from myemp where emp_id like "1%"; # starts with '1'

select * from myemp where emp_id like "%1"; # ends with '1'


select * from myemp where first_name like "J___";

select * from myemp where first_name like "____a";

select * from myemp where job_id like "%clerk";


########################################################################

# Aggregate function

/*
sum(), avg(), min(), max(), count()
# Only 1 output for a complete tableor complete column
*/

select * from myemp;

select sum(salary) as total_salary from myemp;

select avg(Salary) as avg_salary from myemp;

select round(avg(Salary),4) as avg_salary from myemp;

select round(avg(Salary),2) as avg_salary from myemp;

select round(avg(Salary)) as avg_salary from myemp;

select max(Salary) as max_salary from myemp;

select min(Salary) as min_salary from myemp;

select count(*) as total_records from myemp;

######################################################

# Group by clause

select dep_id, sum(salary) as total_salary from myemp group by dep_id;

select dep_id, sum(salary) as total_salary from myemp group by dep_id order by dep_id;

select dep_id, avg(salary) as total_salary from myemp group by dep_id order by dep_id;

select dep_id, round(avg(salary)) as avg_salary from myemp group by dep_id order by dep_id;

select dep_id, max(salary) as max_salary from myemp group by dep_id order by dep_id;

select dep_id, min(salary) as min_salary from myemp group by dep_id order by dep_id;

select dep_id, count(*) as total_records from myemp group by dep_id order by dep_id;

####################################################################################

# having clause

select dep_id, max(salary) as max_salary from myemp group by dep_id order by dep_id;

select dep_id, max(salary) as max_salary from myemp group by dep_id having dep_id = 50 order by dep_id;

select dep_id, max(salary) as max_salary from myemp group by dep_id having dep_id in (30,60,70,80) order by dep_id;

select dep_id, max(salary) as max_salary from myemp group by dep_id having dep_id in (30,60,70,80) order by max_Salary;

select dep_id, max(salary) as max_Salary from myemp where dep_id = 50;
select dep_id, max(salary) as max_Salary from myemp where dep_id in (30,60,70,80) group by dep_id;
select dep_id, max(salary) as max_Salary from myemp where dep_id in (30,60,70,80) group by dep_id order by max_Salary;


##############################################################################

# Constraints

/*
Rules and guidelines we need to follow so as to get the maximum benefit of RDBMS
	1. Domain Constraints
		a. Unique
		b. Not Null
		c. Check
		d. Default
	2. Key Constraints
    3. Referential Key authorsauthorsIntegrity Constraints
*/

create table student5(sid int unique, sname varchar(50) not null, age int check(age>18), course varchar(20) default "MYSQL");

insert into student5 (sid, sname, age) values(1,"Amit", 26); # Default Value "MYSQL" will be added for "Course" column
				
insert into student5 (sid, sname, age) values(1,"Suhana", 25); # Error Code: 1062. Duplicate entry '1' for key 'student5.sid'
			
insert into student5 (sid, sname, age) values(2,"Suhana", 17); # Error Code: 3819. Check constraint 'student5_chk_1' is violated.
			
insert into student5 (sid, sname, age) values(3,null, 17); # Error Code: 1048. Column 'sname' cannot be null

insert into student5 values(4, "Ananya", 23, "Tableau"); # "Tableau" will be taken instead of default value "MYSQL"
