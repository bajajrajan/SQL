CREATE TABLE companies (
    company_id VARCHAR(255) AUTO_INCREMENT,
    company_name VARCHAR(255),
    headquarters_phone_number VARCHAR(255),
    PRIMARY KEY (company_id)
);

alter table companies
add unique key (headquarters_phone_number);

alter table companies
change column company_name company_name varchar(255) default 'X';

alter table companies
modify company_name varchar(255) not null;

insert into companies (headquarters_phone_number)
values ('+1 214 908 7651');

alter table companies
modify headquarters_phone_number varchar(255);