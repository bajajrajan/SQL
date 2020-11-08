select * from dept_manager;

select * from dept_manager
where emp_no in (
select emp_no from employees
where hire_date between '1990-01-01' and '1995-01-01');

-- where exists
select * from employees e 
where exists (
select * from titles t
where e.emp_no = t.emp_no and t.title = 'Assistant Engineer');

select * from employees;
select * from dept_manager;
select * from dept_emp where emp_no = '10001';
select emp_no, count(emp_no) from dept_emp group by emp_no order by count(emp_no) desc;

select A.* from (
select e.emp_no as employee_ID, min(de.dept_no) as department_code, 
	( select emp_no from dept_manager where emp_no = '110022') as manager_ID
    from employees e 
    join dept_emp de on e.emp_no = de.emp_no
    where
		e.emp_no <= 10020
	group by e.emp_no
	order by employee_ID
) as A
UNION
select B.* from (
select e.emp_no as employee_ID, min(de.dept_no) as department_code, 
	( select emp_no from dept_manager where emp_no = '110039') as manager_ID
    from employees e 
    join dept_emp de on e.emp_no = de.emp_no
    where
		e.emp_no between 10020 and 10039
	group by e.emp_no
	order by employee_ID
) as B;

# If working with the aggregate functions add the primary field to the group by to see all results
select e.emp_no, min(de.dept_no) from employees e join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no <= 10020
group by e.emp_no
order by de.emp_no;

create table emp_manager (
	emp_no integer(11) not null,
    dept_no char(4) null,
    manager_no integer(11) not null
);
insert into emp_manager(
select U.* from 
(select A.* from (
select e.emp_no as employee_ID, min(de.dept_no) as department_code, 
	( select emp_no from dept_manager where emp_no = '110022') as manager_ID
    from employees e 
    join dept_emp de on e.emp_no = de.emp_no
    where
		e.emp_no <= 10020
	group by e.emp_no
	order by employee_ID
) as A
UNION
select B.* from (
select e.emp_no as employee_ID, min(de.dept_no) as department_code, 
	( select emp_no from dept_manager where emp_no = '110039') as manager_ID
    from employees e 
    join dept_emp de on e.emp_no = de.emp_no
    where
		e.emp_no between 10020 and 10039
	group by e.emp_no
	order by employee_ID
) as B
UNION
select C.* from (
select e.emp_no as employee_ID, min(de.dept_no) as department_code,
	( select emp_no from dept_manager where emp_no = '110039') as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no = 110022
    group by e.emp_no
    order by employee_ID
) as C
UNION
select D.* from (
select e.emp_no as employee_ID, min(de.dept_no) as department_code,
	( select emp_no from dept_manager where emp_no = '110022') as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no = 110039
    group by e.emp_no
    order by employee_ID
) as D
) as U);

select * from emp_manager;


select distinct e1.* from 
emp_manager e1 join emp_manager e2 on e1.emp_no = e2.manager_no;


