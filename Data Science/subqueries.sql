-- subqueries should have an alias name to execute
select *
from (select * from employees where salary > 15000) a;


select a.employee_name, a.yearly_salary
from (select first_name employee_name, salary yearly_salary
	from employees where salary > 150000) a;

select * 
from employees
where department in (select department from departments);

select * 
from (select department from departments) a

-- subquery in select statement
select first_name, last_name, salary, (select first_name from employees limit 1) as first_n
from employees;

--Assign
select * from departments; --electronics
select * from employees
where department in (select department from departments 
						where division = 'Electronics');
						
select first_name, department, (select max(salary) from employees) - salary
from employees

-- any/all clause - runs if any of the subqueries values is true; all - 
select * from employees
where region_id > any (select region_id from regions where country = 'United States');

select * from employees
where region_id > all (select region_id from regions where country = 'United States');

select * from departments;

select * from employees
where region_id = ANY (
select region_id from departments where division = 'Kids')
and
hire_date > ALL (select hire_date from employees where department = 'Maintenance')

create table dupes(
	id int,
	name varchar(10)
)

insert into dupes values (1, 'FRANK');
insert into dupes values (2, 'FRANK');
insert into dupes values (3, 'ROBERT');
insert into dupes values (4, 'ROBERT');
insert into dupes values (5, 'SAM');
insert into dupes values (6, 'FRANK');
insert into dupes values (7, 'PETER');

select  * from dupes;

select distinct(name), id from dupes; -- doesn't work

select * from dupes where id in (
select min(id)
from dupes
group by name
)

select round(avg(salary)) from employees
where salary not in ((select min(salary) from employees), 
					(select max(salary) from employees));
					
select * from students;
select * from courses;
select * from student_enrollment;


-- Assign 5
--1
select * from students
where student_no in (
	select student_no from student_enrollment where course_no in 
		(select course_no from courses where course_title in('Physics', 'US History')));

--2
select * from student_enrollment;
select course_no, student_no, count(*) from student_enrollment
group by course_no, student_no

select student_name from students where student_no in (
select student_no from student_enrollment
group by student_no
order by count(*) desc
limit 1);

--3
select * from students;
select student_name from students where age in (
	select max(age) from students)
 