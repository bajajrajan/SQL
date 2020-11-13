-- build on the concept of grouping
-- over clause deattach the column from the rest of the query 
-- no longer have to use group by

(select first_name, department,
(select count(*) from employees e2 where e.department = e1.department)
from employees e1
order by department
)
except
select first_name, department,
count(*) over()
from employees e2 -- count has all the rows of the table ie.e 1000

(select first_name, department,
(select count(*) from employees e2 where e2.department = e1.department)
from employees e1
order by department
)
except
select first_name, department,
count(*) over(partition by department) as total_emp_in_that_dept 
from employees e2

select first_name, department,
sum(salary) over(partition by department) as total_emp_in_that_dept 
from employees e2

-- can partition over multiple options/columns
select first_name, department,
count(*) over(partition by department) as total_emp_in_that_dept,
region_id,
count(*) over(partition by region_id ) as total_emp_in_that_region
from employees

-- over, windows funciton runs towards the end after the where clause

select first_name, department, 
count(*) over () -- last the select, that's why it's less time consuming
from employees -- 1st thing to execute -> joins (source of data)
where region_id = 3 -- after the source of data

select first_name, department, 
count(*) over (partition by department) -- last the select, that's why it's less time consuming
from employees -- 1st thing to execute -> joins (source of data)
where region_id = 3 -- after the source of data

-- order by on partition; getting a running total, range not requried(default)
select first_name, hire_date, 
salary,
sum(salary) over (order by hire_date range between unbounded preceding and current row) 
as running_total_of_salaries
from employees;

select department,
max(salary) over (partition by department) 
as running_total_of_salaries
from employees;

-- 1 preceding current and one before row
select first_name, hire_date, department, salary,
sum(salary) over (order by hire_date rows between 1 preceding and current row)
from employees;

-- 3 preceding current row
select first_name, hire_date, department, salary,
sum(salary) over (order by hire_date rows between 3 preceding and current row)
from employees;


-- rank function

select * from 
(select first_name, email, department, salary,
rank() over(partition by department order by salary desc) as rank_over_salary_dept
from employees) a
where rank_over_salary_dept = 2

-- NTILE create groups and process them together
select first_name, email, department, salary,
ntile(5) over(partition by department order by salary desc) as rank_over_salary_dept
from employees

--first value - takes the first value of the salary and prints the same in the group partition

select first_name, email, department, salary,
first_value(salary) over(partition by department order by salary desc) as rank_over_salary_dept
from employees

--advantage - can order by any other column

select first_name, email, department, salary,
first_value(salary) over(partition by department order by first_name desc) as rank_over_salary_dept
from employees

--similar to 
select first_name, email, department, salary,
max(salary) over(partition by department order by salary desc) as rank_over_salary_dept
from employees


-- nth value
--advantage - can order by any other column
select first_name, email, department, salary,
nth_value(salary, 5) over(partition by department order by first_name asc) as rank_over_salary_dept
from employees







