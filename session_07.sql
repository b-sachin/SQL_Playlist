/*
Index - It will improve the performance of the select query.

Types of Index-
	1. Based on Structure that index creates in backend
		1.1 BTree  (IMP)
        1.2 Hash
	2. Based on Data
		2.1 Unique Index   (IMP)
        2.2 Special Text
        2.3
        
	BTree:
		1. It uses Binary Search methodology to search your record
        2. Knowingly and unknowingly we have created btree
        3. It can be created on any number of columns in a table.
*/

use sach123;

create table students_05(sid int primary key, sname varchar(50), age int);

create table students_06(sid int unique key, sname varchar(50), age int);

desc students_05;

desc students_06;


show indexes from students_05;

show indexes from students_06;


select * from myemp;

show indexes from myemp;

alter table myemp add primary key(emp_id);

show indexes from myemp;

create index dep on myemp(dep_id);

show indexes from myemp;

drop index dep on myemp;

show indexes from myemp;

create index sal on myemp(dep_id,salary);

show indexes from myemp;


#########################################################

## Unique index

create table student(sid tinyint primary key, sname varchar(50), phone_no char(10));

insert into student values (1,"Ramesh", "9876598765"), 
						   (2,"Ramesh", "9876543210"), 
                           (3,"Ramesh", "9999988888"), 
                           (4,"Sunita", "9876598765"), 
                           (5,"Sunita", "9876598765");

create unique index stu on student(sname,phone_no); # Error Code: 1062. Duplicate entry 'Sunita-9876598765' for key 'student.stu'

delete from student where sid = 5;

select * from student;

create unique index stu on student(sname,phone_no);

show indexes from student;

################################################################

## Stored Procedures
/*
1. Stored procedures are used to hold our select queries which we would need to execute repeatedly.
2. We can write & execute multiple-line queries (Procedural Language).
*/

# Below sach123 -> 1. Table  2. Views  3. Stored Procedures  4. Functions  -> Right click on Stored Procedures -> Create Stored Procedured
/*
CREATE PROCEDURE `new_procedure` ()
BEGIN
select emp_id, first_name, last_name, salary, salary*0.1 as bonus from myemp limit 10;
END
*/
call new_procedure();

/*

CREATE PROCEDURE `new_proc`()
BEGIN
declare x int;
set x=20;
select x as result;
END

*/

call new_proc();


/*
CREATE PROCEDURE `new_proc2`()
BEGIN
declare x int;
set x = 2;
select * from authors where authorid = x;
END
*/
call new_proc2();

/*
CREATE PROCEDURE `new_proc3`(x int)
BEGIN
select * from authors where authorid = x;
END
*/
call new_proc3(1);
call new_proc3(2);
call new_proc3(3);
call new_proc3(4);
call new_proc3(5);

## Store Procedure Concepts
/*
1. Conditional Expression
2. Loops
3. Exception Handling
*/

## 1. Conditional Expression

/*
CREATE PROCEDURE `proc_if`()
BEGIN
declare num int default 0;
set num = 20;

if num > 0 then
	select "The Number is Positive" as result;
elseif num < 0 then
	select "The Number is Negative" as result;
else
	select "The Number is Zero" as result;
end if;
END
*/


## if-else
/*
CREATE PROCEDURE `proc_if`()
BEGIN
declare num int default 0;
set num = 20;

if num > 0 then
	select "The Number is Positive" as result;
elseif num < 0 then
	select "The Number is Negative" as result;
else
	select "The Number is Zero" as result;
end if;
END
*/
call proc_if();


/*
CREATE PROCEDURE `proc_if2`(num int)
BEGIN
if num > 0 then
	select "The Number is Positive" as result;
elseif num < 0 then
	select "The Number is Negative" as result;
else
	select "The Number is Zero" as result;
end if;
END
*/
call proc_if2(5);

call proc_if2(-66);

call proc_if2(0);



