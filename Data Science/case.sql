select category, count(*) from 
(select 
case
	when salary < 100000 then 'UNDER PAID'
	when salary > 100000 and salary < 160000 then 'PAID WELL'
	when salary > 160000 then 'EXECUTIVE'
	else 'UNPAID'
end as category
from employees) a
group by category
order by count(*) desc;

--
select sum(case when salary < 100000 then 1 else 0 end) as under_paid,
sum(case when salary between 100000 and 160000 then 1 else 0 end) as well_paid,
sum(case when salary > 160000 then 1 else 0 end) as executives
from employees

-- Transposing using case statement
select department, count(*)
from employees
where department in ('Sports', 'Tools', 'Clothing', 'Computers')
group by department

select sum(case when department = 'Tools' then 1 else 0 end) as tools_department,
sum(case when department = 'Sports' then 1 else 0 end) as sports_department,
sum(case when department = 'Clothing' then 1 else 0 end) as clothing_department,
sum(case when department = 'Computers' then 1 else 0 end) as computers_department
from employees

select * from regions

select first_name,
(case when region_id = 1 then (select country from regions where region_id = 1) else null end) as region_1,
(case when region_id = 2 then (select country from regions where region_id = 2) else null end) as region_2,
(case when region_id = 3 then (select country from regions where region_id = 3) else null end) as region_3,
(case when region_id = 4 then (select country from regions where region_id = 4) else null end) as region_4,
(case when region_id = 5 then (select country from regions where region_id = 5) else null end) as region_5,
(case when region_id = 6 then (select country from regions where region_id = 6) else null end) as region_6,
(case when region_id = 7 then (select country from regions where region_id = 7) else null end) as region_7
from employees;

select * from employees;
select * from regions;

select
(case when country = 'United States' then (select count(employee_id) from employees where region_id in (select region_id from regions where country = 'United States')) end) as United_States
from regions;