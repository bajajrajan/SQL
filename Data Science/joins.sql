select first_name, email, division,d.department,  country
from employees e, departments d, regions r
where e.department = d.department
and e.region_id = r.region_id
and email is not null
select * from departments;

select first_name, country
from employees e
inner join regions r
on e.region_id = r.region_id

select first_name, email, division
from employees inner join departments
on employees.department = departments.department
where email is not null


-- second inner join works after the first inner join - i.e. sequence
select first_name, email, division, country
from employees inner join departments
on employees.department = departments.department
inner join
regions 
on regions.region_id = employees.region_id
inner join sales
on 
where email is not null

-- outer joins

select distinct e.department, d.department
from employees e
left join
departments d
on 
e.department = d.department
--27

select distinct e.department, d.department
from employees e
right join
departments d
on 
e.department = d.department
-- 24 all records of right table departments + joining of employees e


select distinct e.department, d.department
from employees e
left join
departments d
on 
e.department = d.department
where d.department is null

-- full outer join


select distinct e.department, d.department
from employees e
full outer join
departments d
on 
e.department = d.department

--where d.department is null

-- UNION - removes duplicates

select department from employees e
union
select department from departments d

-- Union all - keeps duplicate, order by always at the end

select distinct department from employees e
union all
select department from departments d
order by department


-- EXCEPT - works as minus takes the 1st result set and removes from it which are found in second result set

select distinct department from employees
except
select department from departments


select distinct department from departments
except
select department from employees

-- Ex - adding total at the end of the count for all counted rows
select department, count(*)
from employees
group by department
union all 
select 'total', count(*)
from employees


-- Cartesian product, cross join - every row matched with every record of second data source
select * from employees a
cross join departments b

-- Ex
select first_name, department, hire_date, r.country 
from employees e
inner join 
regions r
on
e.region_id = r.region_id
where hire_date in ((select min(hire_date) from employees limit 1)),
				   (select max(hire_date) from employees limit 1))
select * from regions;


-- Date arithemetic
select first_name, hire_date, hire_date - 90
from employees
where hire_date between hire_date and hire_date - 90


-- Moving avg, sum, count etc.
select hire_date, salary,
(select sum(salary) from employees e2 where 
e2.hire_date between e.hire_date -365 and e.hire_date) as spending_pattern
from employees e
order by hire_date


-- views
create view v_employee_info as
(select first_name, email, e.department, salary, division, r.region, country
from employees e, departments d, regions r
where e.department = d.department
and e.region_id = r.region_id
)

select * from v_employee_info


-- Assignment
--1 -- No
select * from student_enrollment;
select * from professors;
select * from students;
select * from teach;
select * from courses;

--2
select s.student_name, se.course_no, t.last_name
from students s inner join 
student_enrollment se on
s.student_no = se.student_no
inner join
teach t on
se.course_no = t.course_no;

-- 3 because there are multiple professors for the same course numbers

--4
select s.student_name, se.course_no, t.last_name
from students s, student_enrollment se, teach t 
where s.student_no = se.student_no and
se.course_no in (select course_no from teach group by course_no)
order by s.student_name

select student_name, course_no, min(last_name) from
(select s.student_name, se.course_no, t.last_name
from students s
inner join student_enrollment se on
s.student_no = se.student_no
inner join teach t on 
se.course_no = t.course_no) a
group by student_name, course_no
order by student_name

--6
SELECT first_name
   FROM employees outer_emp
   WHERE salary > (
     SELECT AVG(salary)
       FROM employees
       WHERE department = outer_emp.department);
	   
-- 7
select s.student_no, student_name, course_no 
from students s left join student_enrollment se
on s.student_no = se.student_no
