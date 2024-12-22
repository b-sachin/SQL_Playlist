show databases;

create database sach123;

use sach123;

create table student (sid int, sname varchar(50), age int, course char(20));

desc student;

insert into student values(1,"Ajay",25,"MySQL");
insert into student values(2,"Sayali",24,"Excel");
insert into student values(3,"Annu",26,"Tableau");

select * from student;