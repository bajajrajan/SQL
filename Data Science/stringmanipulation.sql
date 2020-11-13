select upper(first_name), lower(department), length(first_name)
from employees;

--trim
select trim('    Hello SQL    ')

-- concat
select first_name || ' ' || last_name full_name from employees;

--bollean expression
select first_name || ' ' || last_name full_name, (salary > 140000) is_highly_paid
from employees order by salary desc;


select department, ('Clothing' IN (department)) from employees;

select department, (department like '%oth%')
from employees;

--String operations
select 'This is test data' test_data;

--substring
select substring('This is test data' from 1 for 4) test_data_extracted
select substring('This is test data' from 9 for 4) test_data_extracted
select substring('This is test data' from 9) test_data_extracted

--replace
select department, replace(department, 'Clothing', 'Attire') modified_data
from departments;

select department, replace(department, department, department || ' Department') modified_data
from departments;

--position
select position('@' in email)
from employees;

select substring(email, position('@' in email)+1)
from employees;

--coalesce - null replaced by mentioned character
select coalesce(email, 'None')
from employees