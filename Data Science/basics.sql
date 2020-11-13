select * from employees
where (gender = 'M' and department = 'Automotive' and (salary between 40000 and 100000))
or (gender = 'F' and department = 'Toys');

-- assignment1
select * from students where age between 18 and 20;

--2
select student_name from students 
where student_name like '%ch%'
or student_name like '%nd';

--3
select * from students 
where (student_name like '%ae%'
or student_name like '%ph%')
and NOT age = 19;

--
select student_name, age from students
order by 2 desc;

--
select student_name, age from students
limit 4

--
select * from students
where (age <= 20 and student_no in (3,4,5,7))
or (age > 20 and student_no >=4)

--
SELECT *
FROM students
WHERE AGE <= 20 
AND ( student_no BETWEEN 3 AND 5 OR student_no = 7 )
OR (AGE > 20 AND student_no >= 4);
