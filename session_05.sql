use sach123;

### Primary Key , Foreign Key, on update cascade, on delete cascade


CREATE TABLE Authors(AuthorId INTEGER primary key, 
                                Name VARCHAR(70));

insert into Authors values(1,'J K Rowling');
insert into Authors values(2,'Thomas Hardy');
insert into Authors values(3,'Oscar Wilde');
insert into Authors values(4,'Sidney Sheldon');
insert into Authors values(5,'Alistair MacLean');
insert into Authors values(6,'Jane Austen');
insert into Authors values(7,'Chetan Bhagat');
insert into Authors values(8,'Oscar Wilde');


create table Books(
			 BookId int primary key,
             Title varchar(50),
             AuthorId int,
             foreign key (AuthorID) references Authors(AuthorId) on delete cascade on update cascade);

insert into Books values(1,'Harry Potter and the Philosopher\'s Stone',1);
insert into Books values(2,'Harry Potter and the Chamber of Secrets',1);
insert into Books values(3,'Harry Potter and the Half-Blood Prince',1);
insert into Books values(4,'Harry Potter and the Goblet of Fire',1);

insert into Books values(5,'Night Without End',5);
insert into Books values(6,'Fear is the Key',5);
insert into Books values(7,'Where Eagles Dare',5);

insert into Books values(8,'Sense and Sensibility',6);
insert into Books values(9,'Pride and Prejudice',6);
insert into Books values(10,'Emma',6);
insert into Books values(11,'Five Point Someone',7);
insert into Books values(12,'Two States',7);
insert into Books values(13,'Salome',8);
insert into Books values(14,'The Happy Prince',8);

############################################################

# Join

/*
1. Inner Join
2. Left Outer Join
3. Right Outer Join
4. Full Outer Join
5. Cross Join
6. Self Join
*/

select * from movies;
select * from members;

## 1. Inner Join

select *
from movies
inner join members
on movies.id = members.movieid;


select id, title, first_name, last_name
from movies
inner join members
on movies.id = members.movieid;

## 2. left outer join

select id, title, first_name, last_name
from movies
left join members
on movies.id = members.movieid;

select id, title, first_name, last_name
from movies
left outer join members
on movies.id = members.movieid;

## 3. right join

select id, title, first_name, last_name
from movies 
right join members
on movies.id = members.movieid;

### if null

select id, title, ifnull(first_name,"-") as first_name, ifnull(last_name,"-") as last_name
from movies
left join members
on movies.id =members.movieid;

select   ifnull(id,"-") as id, ifnull(title,"-") as title, first_name, last_name
from movies
right join members
on movies.id =members.movieid;

## 4. full outer join

## 5. cross join (cartesion product)

select * from meals;
select * from drinks;

select  *
from meals
cross join drinks;

select drinkname, mealname, rate
from drinks
cross join meals;

select drinkname, mealname, drinks.rate as drinks_rate, meals.rate as meals_rate 
from drinks
cross join meals;

select drinkname, mealname, (drinks.rate + meals.rate) as total_rate
from drinks
cross join meals;

### alias

select d.drinkname, m.mealname, (d.rate + m.rate) as total_rate
from drinks as d
cross join meals as m;

## 6. self join

select * from myemp;

select e.emp_id as emp_id, e.first_name, e.last_name, m.emp_id as mgr_id, m.first_name, m.last_name
from myemp as e
inner join myemp as m
on e.mgr_id = m.emp_id
order by e.emp_id
