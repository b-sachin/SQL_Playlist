select * from students;
select * from students_01;

# Delete Row

# delete with where clause (Single Record)
delete from students_01 where unique_column = "Ramesh88";
select * from students_01;

select * from students;

#delete all Records;

delete from student02;
select * from student02;


select * from students_01;


#delete multiple records

delete from students_01 where sid in (2,3,9);

############################################

truncate table students_01;

select * from students_01;
###############################################
drop table students_01;

select * from students_01;