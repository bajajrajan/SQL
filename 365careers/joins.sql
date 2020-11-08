-- Inner joins
select * from dept_manager_dup m
inner join
departments_dup d 
on 
m.dept_no = d.dept_no;

--
select 
	e.emp_no, e.first_name, e.last_name, e.hire_date, m.dept_no 
from employees e
inner join 
dept_manager m 
on
e.emp_no = m.emp_no;

-- left joins
select * from employees e
left join dept_manager m
on
e.emp_no = m.emp_no
where e.last_name  = 'Markovitch'
order by dept_no desc, e.emp_no asc;

-- left joins
select * from employees e
right join dept_manager m
on
e.emp_no = m.emp_no
where e.last_name  = 'Markovitch'
order by dept_no desc, e.emp_no asc;

-- old syntx for join
select *  from employees e, dept_manager m
where e.emp_no = m.emp_no;

-- joins and where
select * from dept_emp;
select * from titles;

select e.emp_no, e.first_name, e.last_name, t.from_date, t.title from employees e
left join 
titles t
on 
e.emp_no = t.emp_no
where e.first_name = 'Margareta' and e.last_name = 'Markovitch';

-- Cross joins
select * from departments;
select * from dept_manager m 
cross join 
departments d
where m.dept_no = 'd009';

select * from departments;
select * from employees;
select * from dept_emp;

select * from employees e
cross join 
dept_emp d
where e.emp_no <> d.emp_no
limit 10;

-- aggregate with joins
select e.gender, avg(s.salary) as avg_salary
from employees e
join 
salaries s on e.emp_no = s.emp_no
group by gender;

-- multiple table jons
select e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
from employees e
join 
dept_manager m on e.emp_no = m.emp_no
join 
departments d on m.dept_no = d.dept_no;

--
select * from titles;
select * from dept_manager;
select * from departments;


select e.emp_no, e.first_name, e.last_name, e.hire_date, t.title, m.from_date, d.dept_name
from employees e 
join 
dept_manager m on e.emp_no = m.emp_no
join 
titles t on m.emp_no = t.emp_no
join 
departments d on m.dept_no = d.dept_no
where t.title = 'Manager';

select gender, count(t.emp_no) as manager_count from employees e
join titles t on e.emp_no = t.emp_no
where t.title = 'Manager'
group by gender;
