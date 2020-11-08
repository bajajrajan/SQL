select first_name, count(first_name) as cnt from employees group by first_name order by cnt desc limit 10;

select distinct first_name from employees;

select salary, count(salary) as emps_with_same_salary from salaries where salary > 80000
group by salary order by emps_with_same_salary desc;

select * from salaries group by emp_no having avg(salary) > 120000;

select *, avg(salary) from salaries where salary > 120000;

select *, avg(salary) as avrg from salaries
group by emp_no 
having avg(salary) > 120000;


select *, count(first_name) from employees
where 
hire_date > '1999-01-01'
group by first_name
having count(first_name) < 200;

select * from dept_emp;

SELECT
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;
