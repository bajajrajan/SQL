/*
- delimiter $$ is used because we may have lots of ';' separated sql statements in the procedure
  and to continue executing all of them, we need to change the default delimiter to any variable of our choice
  in this case '$$'
- in parameters can be used automatically in the sp definitation
- out parameters need a variable (@variablename) to be set to initial before calling the sp, once assigned -
  call the sp with the input parameters + out (@variablename) in the call definition
- functions will have input varialbes with datatypes and output datatypes only, it will return a value rather 
  storing them into a varialbe
- need to declare a varaible for output inside the function and return that at the function ending
- function has only 1 output, should not be used for insert, update or delete cos it returns something always
- can easily include the output of a function in a select statement with other tables
- for more than 1 output opt for a procedure - should be used for insert, update and delete
*/

drop procedure if exists select_employees;

DELIMITER $$
create procedure select_employees()
begin
	select * from employees limit 1000;
end$$
delimiter ;

call select_employees();

delimiter $$
create procedure avg_salary()
begin
	select avg(salary) from salaries;
end$$
delimiter ;

call avg_salary();

delimiter $$
use employees $$
create procedure emp_avg_salary(in p_emp_no integer)
begin
select e.first_name, e.last_name, avg(s.salary)
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end$$
delimiter ;

call emp_avg_salary(13000);

delimiter $$
create procedure emp_avg_salary_out(in p_emp_no int, out p_avg_salary decimal(10,2))
begin
select avg(s.salary)
into p_avg_salary from employees e join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end$$
delimiter ;


drop procedure if exists emp_info;
delimiter $$
create procedure emp_info(in p_fname varchar(255), in p_lname varchar(255), out p_eno integer)
begin
	select e.emp_no 
    into p_eno
    from employees e where e.first_name = p_fname and e.last_name = p_lname;
end$$
delimiter ;

select * from employees;

set @p_eno = 0;
call emp_info('Aruna','Journel', @p_eno);
select @p_eno as emp_no;

# Functions

drop function f_emp_avg_salary;
delimiter $$
create function f_emp_avg_salary (p_emp_no integer) returns decimal(10,2)
deterministic no sql reads sql data
begin
declare v_avg_salary decimal(10,2);
select avg(s.salary)
into v_avg_salary from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;

return v_avg_salary;
end$$
delimiter ;

select f_emp_avg_salary(11300);

drop function if exists emp_info;
delimiter $$
create function emp_info (fname varchar(255), lname varchar(255)) returns integer
deterministic no sql reads sql data
begin
declare eno integer;
select emp_no 
into eno
from employees where first_name = fname and last_name = lname;
return eno;
end$$
delimiter ;

select emp_info('Aruna', 'Journel');