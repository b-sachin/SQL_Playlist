/*
TCL Commands
	1. commit
    2. rollback
    3. savepoint
*/


use sach123;

select * from students;

set sql_safe_updates = 0;
delete from students where course is null or marks is null;

# Commit and rollback

# inserting new record into database
select * from students;

insert into students values(1,"Rahul","Tableau",56);

select * from students;

# doing rollback

rollback;

select * from students;

/*
# rollback didn't work and newly inserted data still their because system uses auto commit
# to make it work we need to start a transaction which will crate buffer memory and store the manupulation in it and 
once commited records will be added to database and buffer deleted and if rollback then along with manupulation work buffer will be deleted

*/

## 1. rollback

# start transaction is the command for making that buffer

start transaction;

insert into students values(2,"Sumit","Excel",47);

select * from students;

# now this rollback will work and previously inserted transaction rolled back.
rollback;

select * from students;

# tring rollback with updation

start transaction;

update students set course = "Alteryx" where sid = 6;

select * from students;

rollback;

select * from students;

## 2. commit
# using commit in start transaction instead of rollback

start transaction;

insert into students values(2,"guddu","Excel",34);

select * from students;

commit;

select * from students;

rollback;

select * from students;

## 3. savepoint

select * from students;

start transaction;

insert into students values (11, "Ashish", "MySQL", 58), (12, "Tushar", "Excel", 83);

select * from students;

savepoint x;

insert into students values (13, "Pravin", "Tableau", 55), (14, "Trisha", "Excel", 63);

savepoint y;

select * from students;

insert into students value (15, "Prerana", "PowerBI", 60);

select * from students;

rollback to y;

select * from students;

rollback to x;

select * from students;

commit;

select * from students;

################################################
drop table student02;
drop table student5;

######################################################

## Sequence Object (auto increment)

create table students_01 (sid int auto_increment, sname varchar(50), age int);
# Error Code: 1075. Incorrect table definition; there can be only one auto column and it must be defined as a key

create table students_02 (sid int primary key auto_increment, sname varchar(50), age int);
# working on primary key

create table students_03 (sid int unique auto_increment, sname varchar(50), age int);
# working on unique

create table students_04 (sid int unique key auto_increment, sname varchar(50), age int);
# can write unique or unique key


#############################################
# Inserting a values

insert into students_02 (sname,age) values ("Ashish",24), ("Tushar", 26), ("Pratik",25);

select * from students_02;

insert into students_03 (sname,age) values ("Ashish",24), ("Tushar", 26), ("Pratik",25);

select * from students_03;

#################################################

# Suppose you want your auto_increment to start from 101

alter table students_02 auto_increment = 101;

insert into students_02 (sname,age) values ("Ramesn",22),("Rajesh",19),("Ram",20);

select * from students_02;

####################################################################

# difference in working of delete and truncate

## delete
delete from students_02;
select * from students_02;
insert into students_02 (sname,age) values ("Ramesn",22),("Rajesh",19),("Ram",20);
select * from students_02;

## truncate
truncate table students_02;
select * from students_02;
insert into students_02 (sname,age) values ("Ramesn",22),("Rajesh",19),("Ram",20);
select * from students_02;

################################################################################

## Views


/*
Views are virutal tables and not actual tables

Views holds the select query output

Views allows you to access your sql query easily which you might have to use again and again repeatately.

views allows restricted access to your database.

we can hide our select query

we can hide our source file name

View doesnot hold any data on its own. It just accessing the actual table based on your select query. It provide you a window to access the data.

Types:
	1. Simple View - View using single table
    2. Complex View -  View using two or more tables
*/

## 1. Simple View
select * from myemp limit 5;

create view emp_bonus as select emp_id, first_name, last_name, salary, salary * 0.1 as bonus from myemp;

select * from emp_bonus;

show tables; # you can see views in show table query coz it is virtual table.

create view dep_80 as select * from myemp where dep_id = 80;

select * from dep_80;

## 2. Complex View

select * from movies;
select * from members;

create view rentals as
select id, title, first_name, last_name
from movies
join members
on id = movieid;

select * from rentals;

##################################

create view aview as
select * from authors where authorid <20;

select * from aview;

insert into aview values (1,"J K Rawling");

select * from authors;

# -> data added in main table

################################################

insert into aview values (21,"George R. R. Martin");

select * from aview;  ## Cannot see in aview as aview has condition authorid < 20

select * from authors; ## can see in authors table

################################################

# If you want to restrict to enter autherid beyond its limit

drop view aview;

create view aview2 as
select * from authors where authorid <20 with check option;

select * from aview2;

insert into aview2 values (31, "Ashneer Grover");
## Error Code: 1369. CHECK OPTION failed 'sach123.aview2'

#################################################################################################################

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



