show databases;

create database sach123;

use sach123;

create table student (sid int, sname varchar(50), age int, course char(20));

desc student;

insert into student values(1,"Ajay",25,"MySQL");
insert into student values(2,"Sayali",24,"Excel");
insert into student values(3,"Annu",26,"Tableau");

select * from student;

create table patient (pid tinyint, pname varchar(50), insurance_id char(9), dob date, toa timestamp);

desc patient;

insert into patient values(1,"Amit","xmls12345","1981-10-13","2023-11-25 15:30:43");

insert into patient values(2,"Ajay","xmls65743","1989-08-23","2023-11-24 03:25:15");

select * from patient;