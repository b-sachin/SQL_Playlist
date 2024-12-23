# Single Line Comment

/*
DDL Commands
1. create
2. alter
3. rename
4. drop
5. truncate
*/

select * from student;

# alter command
alter table student add marks int;

desc student;

# drop column

alter table student drop age;

desc student;

alter table student modify sid tinyint;

desc student;

alter table student rename myclass;

desc myclass;

rename table myclass to students;

desc students;

###########################################################################
# Another Usecase of select statement

select 3+9;

# if you want custom column name

select 3+9 as Result;

# Arithmetic Operators

select 3+9 as Result;
select 18-7 as Result;
select 11*22 as Result;
select 154/14 as Result;
select 23%2 as Result;
select 23%3 as Result;

# Comparison Operator
select 13>8 as Result;
select 13<9 as Result;
select 33=33 as Result;
select 21 != 33 as Result;
select 12>=9 as Result;

select 41 = null as Result; # wrong statement

select 41 is null as Result; # Correct Statement

select 41 is not null as Result; # Correct Statement

###########################################################################################

/* DML Commands
1. insert
2. update
3. delete
*/

select * from students;

# Insert Command

#implecit mentod
insert into students values (4, "Ananya","PowerBI",88);
insert into students values (5, "Ramesh",null,88); # if you dont know value upfront then can put null

#Explicit Method (# if you dont know value upfront then use can use this)
insert into students (sid, sname, marks) values (6,"Sachin", 90);

# Insert Multiple rows at a time
insert into students (sid, sname, marks) values (7,"Sidd",23), (8,"Rahul",64), (9,"Nitin",12);

###################################################################################

set sql_safe_updates = 0;

update students set course = "PowerBI" where sid = 6;

update students set sname = "Sachin" where course = "PowerBI";

# now there are 2 sachin with course PowerBI the one who got 88 marks should change it to Excel
# but marks = 88 condition change course of Ramesh also to Excel from null
# In this case combination of 2 column must create unique key column

select *, concat(sname,marks) as unique_column from students;

# create new table for this operation from above statement

create table students_01 select *, concat(sname,marks) as unique_column from students;

select * from students_01;

# now updte sachin with 88 marks to Excel from PowerBI

update students_01 set course = "Excel" where unique_column = "Sachin88";

# Update where null

update students_01 set marks = 0  where marks = null; #Wrong statement
select * from students_01;
update students_01 set marks = 0  where marks is null; #Correct statement
select * from students_01;