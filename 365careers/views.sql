create or replace view v_dept_emp_lastest_date as
select emp_no, max(from_date) as from_date, MAX(to_date) as to_date
from dept_emp
group by emp_no;

select * from v_dept_emp_lastest_date;

select * from salaries;
select * from dept_manager;

create or replace view v_manager_avg_sal as
select m.emp_no, round(avg(s.salary),2) from dept_manager m 
join salaries s on m.emp_no = s.emp_no 
group by m.emp_no;

select * from v_manager_avg_sal;
