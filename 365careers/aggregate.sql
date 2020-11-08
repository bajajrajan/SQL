select * from dept_emp;
select count(distinct dept_no) from dept_emp;

select * from salaries;
select sum(salary) from salaries where from_date > '1997-01-01';

select max(salary) from salaries;
select min(salary) from salaries;

select min(emp_no) from employees;
select max(emp_no) from employees;

/* All non null values */
select avg(salary) from salaries;
select avg(salary) from salaries where from_date > '1997-01-01';

/* round(#, decimal places) */
select round(avg(salary), 2) as salary from salaries;
select round(avg(salary), 2) as salary from salaries where from_date > '1997-01-01';

/* ifnull, coalesce */
alter table department_dup
modify dept_no varchar(255) null;
insert into department_dup (dept_no, dept_name) values (null, null);

select * from department_dup;

select dept_no, ifnull(dept_name, 'Department name not provided') as dept_name
from department_dup;

select dept_no, coalesce(dept_name, dept_no, 'Department name not provided') as dept_name
from department_dup;

update department_dup 
set dept_no = null where dept_no = 'd010';
select dept_no, dept_name, coalesce(dept_no, dept_name, 'N/A') as dept_info from department_dup;

select ifnull(dept_no, 'N/A') as dept_no, ifnull(dept_name, 'Department name not provided') as dept_name,
coalesce(dept_no, dept_name) as dept_info
from department_dup;

