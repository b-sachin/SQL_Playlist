use sach123;

## Loops in MySQL (Stored Procedures) - In Detail
/* In MySQL, loops are used inside stored procedures to execute a block of SQL statements 
multiple times. 
MySQL supports three types of loops:

1. LOOP
2. WHILE
3. REPEAT
Each of these loops has its own use case, and we can control them 
using LEAVE (to exit) and ITERATE (to skip the current iteration).

*/


####################################

## 1. Loop

/*
The LOOP construct runs indefinitely unless explicitly terminated using LEAVE.
Useful when we don't have a predefined stopping condition.
*/


/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loop`()
BEGIN
	declare counter int default 1;
	
    my_loop: LOOP
		select concat("Number: ",counter);
        set counter = counter + 1;

        if counter >5 then
			LEAVE my_loop;
		end if;
	end LOOP;
END
*/
call proc_loop();


####################################

## practice

/*
CREATE PROCEDURE `proc_loop2`()
BEGIN

declare x int default 1;

myloop2: loop
	select x;
    set x = x+1;
    
    if x>10 then
		leave myloop2;
    end if;
end loop;

END
*/
call proc_loop2();


####################################

## Loop with LEAVE (Just like Break stmt) and ITERATE(just like continue stmt)

/*
CREATE PROCEDURE `proc_loop_leave_iterate`()
BEGIN
	declare x int default 0;
    
    myloop3: loop
		set x = x+1;
        
        if	x>10 then
			leave myloop3;
		end if;
        
        if x%2 = 0 then
			iterate myloop3;
		end if;
        
        select x;
	end loop;
END
*/


####################################

## 2. While

/*
The WHILE loop runs as long as the specified condition remains TRUE.
It is entry-controlled, meaning the condition is checked before entering the loop.
*/

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_while`()
BEGIN
	declare counter int default 1;
    
    while counter <=5 do
		select concat("Iteration: ",counter);
        set counter = counter+1;
	end while;
END
*/
call proc_while();


## practice
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_while2`()
BEGIN
	declare x int default 1;
    
    while x<=10 do
		select x;
        set x = x+1;
	end while;
END
*/
call proc_while2();


####################################

## 3. Repeat

/*
The REPEAT loop is exit-controlled, meaning the statements execute at least once 
before checking the condition.
It continues executing until the specified condition becomes TRUE.
*/

delimiter //
create procedure proc_repeat()
begin
	declare counter int default 1;
    
    repeat
		select concat("Counter: ",counter);
        set counter = counter+1;
	until counter > 5
    end repeat;
end 
// delimiter ;

call proc_repeat();


####################################

### Practice Problems

/*
Try writing stored procedures for the following:

1. Use LOOP to print numbers from 10 to 1.
2. Use WHILE to sum numbers from 1 to 100.
3. Use REPEAT to print "Hello World" 5 times.
*/

## Practice Problem 1. : Use LOOP to print numbers from 10 to 1.

/*
CREATE PROCEDURE `practice1`()
BEGIN
	declare x int default 10;
    
    myloop11:loop
		if x<=0 then
			leave myloop11;
		end if;
		
        select x;
        
        set x = x-1;
	end loop;
END
*/
call practice1();


####################################

## Practice Problem 2. : Use WHILE to sum numbers from 1 to 100.

delimiter //
create procedure practice2()
begin
	declare x int default 1;
    declare total int default 0;
    
    while x <=100 do
		set total = total + x;
        set x = x+1;
    end while;
    
    select total;
		
end
// delimiter ;

call practice2();


####################################

## Practice Problem 3. : Use REPEAT to print "Hello World" 5 times.

delimiter //
create procedure practice3()
begin
	declare x int;
    set x = 1;
    
    repeat
		select "Hello World";
        set x = x+1;
	until x>5 end repeat;
end
// delimiter ;

drop procedure practice3;

call practice3();

#############################################################################

# Exception Handling in MySQL (Stored Procedures)

/*
MySQL provides exception handling in stored procedures using the DECLARE ... HANDLER statement. 
Exception handling is essential for handling errors gracefully, 
such as division by zero, duplicate key violations, or missing records.

MySQL supports two types of handlers:

CONTINUE → Execution continues after handling the error.
EXIT → The procedure stops execution when an error occurs.


Syntax:

DECLARE handler_type HANDLER FOR condition_value
BEGIN
    -- Error handling statements
END;


📌 handler_type:

CONTINUE → Skips the error and continues execution.
EXIT → Stops execution when an error occurs.


📌 condition_value:

SQLEXCEPTION → Handles all SQL errors.
SQLWARNING → Handles warnings.
NOT FOUND → Handles cases when no records are found.
Specific MySQL error codes (e.g., 1062 for duplicate entry).
*/


####################################

## Example 1: Handling Division by Zero

Delimiter //
create procedure divide_numbers(in num1 int, in num2 int)
begin
	declare continue handler for sqlexception
    begin
		select "Error: Divide by zero!";
    end;
    
    select num1 / num2 as result;
end //

delimiter ;

call divide_numbers(10,0);


####################################
		
## Example 2: Handling NOT FOUND (Cursor Handling)

delimiter //

create procedure fetch_student()
begin
	declare done int default False;
    declare student_name varchar(255);
    
    declare cur cursor for select sname from students;
    declare continue handler for not found set done = true;
    
    open cur;
    
    read_loop:loop
		fetch cur into student_name;
        if done then
			leave read_loop;
		end if;
        select student_name;
	end loop;
    
    close cur;
end //
delimiter ;

call fetch_student();


####################################

## Example 3: Handling Duplicate Key Error (1062)

delimiter //
create procedure insert_student(in s_id int, in s_name varchar(255), in s_phone char(10))
begin
	declare continue handler for 1062
    begin
		select "Error: Duplicate Entry!" as Err_Msg;
    end;
    
    insert into student values (s_id,s_name,s_phone);
end //
delimiter ;

drop procedure insert_Student;

call insert_student(1,'John',9876543210);


####################################

## Example 3: Handling Duplicate Key Error (1062)
## Comparison of EXIT vs CONTINUE Handlers

delimiter //
create procedure multi_handler_example()
begin
	declare continue handler for 1062
    begin
		select "Duplicate Entry Error!" as Err_Msg;
    end;
    
    declare exit handler for sqlexception
    begin
		select "SQL Exception Occured";
    end;
    
    
    # comment out of following two lines to see respective output
    insert into student values(1,"Sam",9876543210);
    insert into student_wrong_table values(2,"Andy",1234567890);
end //
delimiter ;

drop procedure multi_handler_example;

call multi_handler_example();


###############################################################################

# Cursors in MySQL (Stored Procedures)

/*
A cursor in MySQL is used to retrieve, loop through, and manipulate rows of data 
one by one from a result set. 
It is commonly used inside stored procedures when processing multiple rows of 
data sequentially.

# Cursor Lifecycle
A cursor in MySQL follows four major steps:

DECLARE – Define the cursor with a SELECT statement.
OPEN – Start fetching rows from the cursor.
FETCH – Retrieve data one row at a time from the cursor.
CLOSE – Release memory once all rows are processed.



# Basic Syntax

DECLARE cursor_name CURSOR FOR select_query;
OPEN cursor_name;
FETCH cursor_name INTO variable_list;
CLOSE cursor_name;

*/

####################################

## Cursor Example 1: Basic Cursor in a Stored Procedure

delimiter //
create procedure fetch_student2()
begin
	declare done bool default False;
    declare student_name varchar(255);
    
    declare cur cursor for select sname from students;
    declare continue handler for not found set done = true;
    
    open cur;
    
    read_loop:loop
		fetch cur into student_name;
        if done then
			leave read_loop;
		end if;
        select student_name;
	end loop;
    
    close cur;
end //
delimiter ;

call fetch_student2();

####################################

## Cursor Example 2: Fetching Student Names and Marks with a Condition

delimiter //
create procedure fetch_top_students()
begin
	declare done bool default false;
    declare student_name varchar(255);
    declare student_marks int;
    
    declare cur cursor for
		select sname, marks from students where marks > 80;
        
	declare continue handler for not found set done = True;
    
    open cur;
    
    read_loop:loop
		fetch cur into student_name, student_marks;
        
        if done then
			leave read_loop;
		end if;
        
        select concat(student_name,' scored ',student_marks,' marks') as result;
	end loop;
    
    close cur;
end //
delimiter ;

call fetch_top_students();


####################################

## Cursor Example 3: Updating Records Using a Cursor

delimiter //
create procedure update_low_marks()
begin
	declare done bool default false;
    declare id int;
    
    declare cur cursor for 
		select sid from students where marks < 60;
        
	declare continue handler for sqlexception
    begin
		select "Error Occurred!" as Err_Msg;
    end;
        
	declare continue handler for not found set done = True;
    
    open cur;
    
    read_loop:loop
		fetch cur into id;
        
        if done then
			leave read_loop;
		end if;
        
        update students set marks = 60 where sid = id;
	end loop;
    
    close cur;
end //
delimiter ;

set sql_safe_updates = false;

call update_low_marks();

#############################################################################

# User-Defined Functions (UDFs) in MySQL

/*
A User-Defined Function (UDF) in MySQL is a custom function that users can 
create to perform specific tasks and return a single value. 
These functions allow you to reuse logic and simplify SQL queries.

🔹 IMP
✅ Reusable logic across multiple queries
✅ Simplifies complex calculations
✅ Can be used in SELECT, WHERE, ORDER BY clauses
✅ Improves query readability
✅ UDFs can be slower than stored procedures for bulk operations

🔹 Syntax of MySQL UDF

CREATE FUNCTION function_name(parameter_name DATATYPE)
RETURNS return_type
DETERMINISTIC
BEGIN
    -- Function logic
    RETURN value;
END;

*/

####################################

## Example 1: Simple UDF to Calculate Square

delimiter //
create function square(num int)
returns int
deterministic
begin
	return num * num;
end //
delimiter ;

###########

select square(5);

####################################

## Example 2: UDF for Employee Bonus Calculation

delimiter //
create function cal_bonus(sal decimal(10,2))
returns decimal(10,2)
deterministic
begin
	return sal * 0.10;
end //
delimiter ;
#############

select emp_id, salary, cal_bonus(salary) as bonus from myemp;

####################################

## Example 3: UDF to Count Words in a String

delimiter //
create function word_count(txt varchar(255))
returns int
deterministic
begin
	return length(replace(txt," ",""));
end //
delimiter ;
###############

select word_count("MYSQL is powerful");

####################################

## Example 4: UDF for Age Calculation

delimiter //
create function cal_age(dob date)
returns int
deterministic
begin
	return timestampdiff(year, dob, curdate());
end //
delimiter ;
#################

alter table patient add age int;
update patient set age = cal_age(dob);
