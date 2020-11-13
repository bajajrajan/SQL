insert into cars values ('Honda');
insert into cars values ('Honda');
insert into cars values ('Honda');
insert into cars values ('Toyota');
insert into cars values ('Toyota');
insert into cars values ('NISSAAN');

select * from cars;
select * from cars group by make;

select make, count(*) 
from cars
group by make;

insert into cars values (NULL);
insert into cars values (NULL);
insert into cars values (NULL);
insert into cars values (NULL);

select * from cars;

select department, sum(salary)
from employees
where region_id in (4,5,6,7)
group by department


select department, count(employee_id)
from employees
group by department
order by count(employee_id) desc;


select department, count(employee_id), round(avg(salary),2), min(salary), max(salary)
from employees
where salary > 70000
group by department
order by count(employee_id) desc;


-- Multiple columnms in group by divides the data into another hierarchy of the second column and so on
select department, gender, count(*)
from employees
group by department, gender
order by department;

select department, count(*)
from employees
group by department 
having count(*) < 35
order by count(*);


-- can't use the distinct keyword in group by as it perform the same thing of removing duplicates
select first_name, count(*) as cnt from employees
group by first_name
order by cnt desc;

--
select substring(email, position('@' in email) + 1) as domain_name, count(*) as cnt
from employees
where email is not null
group by domain_name
order by cnt desc;

--
select gender, region_id, min(salary), max(salary), round(avg(salary))
from employees
group by gender, region_id
order by gender, region_id;

-- assignment 4

select * from fruit_imports;

select state
from fruit_imports
where 1=1
group by state, supply
having supply = MAX(supply); 

select state, sum(supply) as supply
from fruit_imports
group by state
order by supply desc
limit 1;

--2
select season, max(cost_per_unit) as cost_per_unit
from fruit_imports
group by season
order by cost_per_unit;

--
select state, name
from fruit_imports
group by state, name
having count(name) > 1;

select state, name from fruit_imports 
order by state;

select season, count(name)
from fruit_imports
group by season
having count(name) between 3 and 4;

select state, sum(supply*cost_per_unit) as total_cost
from fruit_imports
group by state
order by total_cost desc
limit 1;

--6
CREATE table fruits (fruit_name varchar(10));
INSERT INTO fruits VALUES ('Orange');
INSERT INTO fruits VALUES ('Apple');
INSERT INTO fruits VALUES (NULL);
INSERT INTO fruits VALUES (NULL);

select * from fruits
select count(coalesce(fruit_name, 'None')) from fruits;






