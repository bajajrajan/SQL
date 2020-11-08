/*
- case -> when -> then
*/

select emp_no, first_name, last_name,
	case gender
		when 'M' then 'Male'
        else 'Female'
	end as gender
from employees;

# if statements
select emp_no, first_name, last_name,
	if(gender = 'M', 'Male', 'Female') as gender
from employees;

--
select dm.emp_no, e.first_name, e.last_name, 
max(s.salary) - min(s.salary) as salary_difference,
case 
	when max(s.salary) - min(s.salary) > 30000 then 'Salary increased > 30000'
    when max(s.salary) - min(s.salary) between 20000 and 30000 then 'Salary increased 20000 > 30000'
    else 'Salary raised less than 20000'
end as salary_increase
from dept_manager dm
	join
    employees e on e.emp_no = dm.emp_no
    join
    salaries s on s.emp_no = dm.emp_no
group by s.emp_no;

--
select * from dept_manager;
select e.emp_no, e.first_name, e.last_name,
	case
		when e.emp_no = d.emp_no then 'Manager'
        else 'Employee'
	end as designation
from employees e 
left join dept_manager d on e.emp_no = d.emp_no
where e.emp_no > 109990;

select e.emp_no, e.first_name, e.last_name, 
	max(s.salary) - min(s.salary) as salary_difference,
	case 
		when max(s.salary) - min(s.salary) > 30000 then 'Raised > 3000'
        else 'Less than 30000'
	end as comment
from employees e 
left join salaries s on e.emp_no = s.emp_no
group by e.emp_no;

select * from dept_emp;

select e.emp_no, e.first_name, e.last_name,
	case 
		when d.to_date != '9999-01-01' then 'Still Employed'
        else 'Not an employee anymore!'
	end as current_employee
from employees e left join dept_emp d on e.emp_no = d.emp_no
group by e.emp_no;

select e.emp_no, e.first_name, e.last_name,
	if(d.to_date != '9999-01-01', 'Still Employed', 'Not an employee anymore!')
from employees e left join dept_emp d on e.emp_no = d.emp_no
group by e.emp_no;




