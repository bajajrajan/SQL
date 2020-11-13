select department, count(*) cnt from employees 
group by department
order by cnt desc;

-- max
select department, max(salary) as max_s from employees
group by department 
order by max_s desc;

--avg
select round(avg(salary),2)
from employees

-- count - doesnt count null values
select count(employee_id)
from employees;

select count(email)
from employees;

select count(*) from employees;

-- sum
select department, sum(salary)
from employees
group by department;

select sum(salary) from employees
where department = 'Toys'

-- Assignment 3
select * from professors;

--1
select last_name || ' works in the ' || department || ' department' as text
from professors;

--2
select
case 
	when salary > 95000 then 'It is true that professor ' || last_name || ' is highly paid'
	else 'It is false that professor ' || last_name || ' is highly paid'
end as highly_paid
from professors;

--3
select last_name, substring(department, 1, 3), salary, hire_date
from professors;

--4
select max(salary), min(salary) from
professors where last_name != 'Wilson'

--5
select * from professors;
select * from professors
--group by hire_date
having hire_date = min(hire_date)

select min(hire_date) from professors;