/*
WINDOWS ANALYTICS functions
- the are used to calculate aggregate values based on a group of rows
- the groups of rows is called window
- the window determines the range of rows used to perform the calculations from the current row
- they perform on the results of the sql query
- they make analysing data easier
- they are used in calculating cummulative or running totals
- they acan be used in ranking e.g. find top earners or sales person
- they are not affected by group by, having, where 
- operate on a set of rows and return a single value fro each from underlying query
- describes the set of rows on which the function operates
- uses values from the rows in windows to calculate the returned values
*/

/*
- breaks up data into chunks or partitions
- separated by a partition boundary
- functions are performed within the partitions
- functions restarts when the partition boundary is crossed
- similar to group by clause used in aggregate functions
- also called query partition clause
*/


select * from employees;

with cte as (
select department_id,
	(sum(salary) over (partition by department_id)) cumm_salary
	from employees
	order by department_id
)
select * from cte group by department_id, cumm_salary
order by department_id;

/*
- used ot filter or sort incoming data in order
- is required by some analytics functions
*/

with cte as (
select department_id, last_name, salary,
	dense_rank() over (partition by department_id order by salary) ranking
	from employees
order by department_id)
select * from cte where ranking = 1;

/*
- MAX() function with windows functions
*/
with cte as (
select department_id, salary, 
	max(salary) over (partition by department_id ) maximum
	from employees
	order by department_id)
select * from cte group by 1,2,3 order by 1;

/*
- SUM() sums up all the numeric values
*/
with cte as (
select department_id, 
	sum(salary) over (partition by department_id) summing
	from employees
	order by department_id)
select * from cte group by 1,2;

select month(hire_date)::int from employees;

with cte as (
	select department_id, (hire_date),
		sum(salary) over (partition by (hire_date)) as monthly
	from employees
)
select * from cte;


/*
row_number() - creates increaing numbering to rows beginning with 1
with partition by or order yb clause
- resets when crossign partition boundary
*/
select e.*, row_number() over (order by last_name) as row_number
from employees e;


select e.*,
	row_number() over (partition by e.salary order by last_name) as row_number
	from employees e
	order by e.salary, e.last_name;
	
select department_id, salary,
	row_number() over (partition by department_id order by department_id) as row_number
from employees

/*
- RANK functions - 847-890-9420(suman) - +91 891-970-9901(Lakshman) 
- calculates the rank of a value in a group of values rows with equal values share the same rank
- No argument are required withing the rank () - order by is required, partition by is not required.
*/
with cte as (
	select department_id, last_name, salary, 
	rank() over (partition by department_id order by salary) as ranking
	from employees
)
select * from cte where ranking = 2;

/*
- Dense rank function - returns the rank in rows calculated from a group of rows in a consecutive
number order starting with 1
- ranks are not skipped
- calculates the rank of a row in an ordered group of rows
- order by is required partition by is not requried
*/

select department_id, 
	last_name,
	salary,
	dense_rank() over (order by salary) ranking
from employees
order by salary;

/*
LEAD() - used to access more than one row from the same table at the same time.
- used to look forward a number of rows
- access to the column and data of the rows you accessed
- subsitutes self join
- lead(column_name, nr-tolead-default-value) over()
*/

select hire_date, last_name,
	lead(hire_date, 1, null) over (order by hire_date)
	as "Next person hired"
from employees
order by hire_date;

with cte as (
select salary, 
	avg(salary) over () as avg_salary
from employees
	)
select *, (salary - avg_salary) as diff from cte;


/*
allows to look backward
*/

select hire_date, last_name,
	lag(hire_date, 1, null) over (order by hire_date)
	as "Next person hired"
from employees
order by hire_date;

/*
first_value() and last_value() functions
retireve either the first or last value in an ordereed set of values
- uses the column name as the only parameter
- order by is required , partition by is not
first_value(column_name) over (order by)
*/
select last_name, department_id, salary,
first_value(last_name) over (order by salary) first_person
from employees
order by salary;

select last_name, department_id, salary,
last_value(last_name) over (order by salary desc) first_person
from employees
order by salary;

/*
- listagg()
- order data, concatenate string, filter or sort data into columns before delimeted actions occurs
- can sort the data in column before it is delimited
listagg(column, 'delimiter') within group(order by clause) over()
- within group is used to specify the order you want your data sorted before the delimiter
action takes place
*/

select department_id as "departments",
	hire_date as "datehired",
	last_name as "surname",
	(listagg(last_name, '; ')
		within group (order by hire_date, last_name)
		over (partition by department_id)  as "employees")
from employees;

/*
windowing clause
- set of parameters or keywords that defines the group or window of rows within a particular
partition that will be evaluated for analytic functions computation.
- rows - specifies the window in physical units or rows
- range - specifies the window as a logical offset
- between ..and - specifies start and end point of the window
- unbounded preceding - indicates window starts from first row of partition
- unbounded following - indicates windows ends at the last row of the partition
- current row - indicates window begins or ends at the current row
- value_expr - preceding or following: uses same expression based on start or end
*/

/*default windowing clause*/
select * from employees;

select first_name, last_name, salary, sum(salary) as "total_sales",
	sum(salary) over (order by salary ) as summing
from employees
group by 1,2,3;

/*
- rows with windowing clause
*/
select department_id, salary,
	sum(salary) over (partition by department_id order by salary) as dept_total
from employees where department_id = 3;

/*
- RANGE with a windowing clasue
*/

select department_id, hire_date, salary, 
	sum(salary) over (partition by department_id order by hire_date range 90 preceding) dept_total
	from employees;

