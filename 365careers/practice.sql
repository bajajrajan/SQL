create table emp
(
	empno int auto_increment,
    fname varchar(10),
    lname varchar(10),
primary key (empno)
);

create table mgr
(
	deptno int,
    empno int,
    hire date
);

insert into mgr values (100, 3, '2020-01-01');
insert into mgr values (101, 5, '2020-01-01');
insert into mgr values (100, 7, '2020-01-01');
insert into mgr values (100, 9, '2020-01-01');
insert into mgr values (100, 11, '2020-01-01');

insert into emp (fname, lname) values ('a', 'b');
insert into emp (fname, lname) values ('c', 'd');
insert into emp (fname, lname) values ('e', 'f');
insert into emp (fname, lname) values ('g', 'h');
insert into emp (fname, lname) values ('i', 'j');
insert into emp (fname, lname) values ('k', 'l');
insert into emp (fname, lname) values ('m', 'n');
insert into emp (fname, lname) values ('o', 'p');
insert into emp (fname, lname) values ('q', 'r');
insert into emp (fname, lname) values ('s', 't');

select * from emp;
select * from mgr;

select * from emp e 
left join 
mgr m 
on e.empno = m.empno
where e.empno is not null
order by m.empno asc;

select * from mgr m 
left join 
emp e
on e.empno = m.empno
where e.empno is not null;

select * from emp e 
right join 
mgr m 
on e.empno = m.empno
;

select * from mgr m 
right join 
emp e 
on e.empno = m.empno
order by m.empno;