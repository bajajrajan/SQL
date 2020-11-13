create table sales (
	sale_sk bigint,
    order_id int,
    order_date date,
    customer_id int,
    merchant_id int,
    product_sku varchar(30),
    units int,
    price numeric(18,6),
    create_dt date,
    update_dt date
);

create table customers (
	customer_id int,
    first_name varchar(30),
    last_name varchar(30),
    age int,
    address_id int,
    is_prime_member char(1),
    is_active char(1),
    create_dt date,
    update_dt date
);


create table address (
	address_id int,
    country varchar(30),
    state varchar(30),
    city varchar(40),
    create_dt date,
    update_dt date
);

select * from sales;

drop table sales;
insert into sales values (1, 1, '2020-11-11', 1, 1, '126363456', 1, 34.99, '2020-11-11', null);
insert into sales values (1, 1, '2020-11-11', 1, 2, '12636345657', 1, 14.99, '2020-11-10', null);
insert into sales values (2, 2, '2020-11-11', 2, 1, '126363456', 1, 94.99, '2020-11-11', null);
insert into sales values (2, 2, '2020-11-11', 2, 3, '12636345658', 4, 17.99, '2020-11-11', null);
insert into sales values (2, 2, '2020-11-11', 2, 2, '12636345657', 2, 34.00, '2020-11-11', null);
insert into sales values (3, 3, '2020-11-11', 3, 4, '12636345659', 10, 10.00, '2020-11-11', null);
insert into sales values (4, 4, '2020-10-11', 1, 4, '12636345659', 4, 34.99, '2020-10-11', null);
insert into sales values (5, 1, '2020-10-11', 1, 1, '126363456', 1, 50.99, '2020-10-11', null);
insert into sales values (6, 6, '2020-09-11', 2, 4, '12636345659', 1, 63.00, '2020-09-11', null);
insert into sales values (7, 7, '2020-08-11', 3, 1, '126363456', 1, 34.99, '2020-09-11', null);
insert into sales values (8, 8, '2020-07-11', 1, 5, '12636345650', 1, 30.99, '2020-07-11', null);
insert into sales values (9, 9, '2020-06-11', 2, 5, '12636345650', 1, 15.00, '2020-06-11', null);
insert into sales values (10, 10, '2020-06-10', 2, 1, '126363456', 5, 9.00, '2020-06-10', null);
insert into sales values (10, 10, '2020-06-10', 2, 3, '12636345658', 3, 5.00, '2020-06-10', null);
insert into sales values (11, 11, '2020-05-11', 1, 4, '12636345659', 1, 50.99, '2020-05-11', null);
insert into sales values (11, 11, '2020-05-11', 1, 1, '126363456', 3, 34.99, '2020-05-11', null);
insert into sales values (12, 12, '2020-05-11', 4, 1, '126363456', 4, 4.99, '2020-05-11', null);


insert into customers values (1, 'Ryan', 'Harris', 25, 1, 'Y', 'Y', '2019-01-01', '2019-01-01');
insert into customers values (2, 'Aakash', 'Satija', 28, 2, 'Y', 'Y', '2019-02-01', '2019-02-01');
insert into customers values (3, 'Biren', 'Suhag', 35, 3, 'Y', 'Y', '2019-03-01', '2019-03-01');
insert into customers values (4, 'Vikas', 'Naseer', 52, 4, 'Y', 'Y', '2019-01-01', '2019-01-01');

select * from customers;

insert into address values (1, 'USA', 'Texas', 'Dallas', '2019-01-01', '2019-01-01');
insert into address values (2, 'USA', 'Texas', 'Dallas', '2019-02-01', '2019-02-01');
insert into address values (3, 'USA', 'Texas', 'Austin', '2019-03-01', '2019-03-01');
insert into address values (4, 'USA', 'Texas', 'Austin', '2019-01-01', '2019-01-01');

select * from address;

# query 1
# 10 top customers per city based on amount spent
select * from sales where customer_id = 4;
select customer_id, sum(units*price)
from sales
group by customer_id;

select customer_id, units*price from sales
order by customer_id;

with cte_gp_amt as (
	select distinct customer_id, 
    (sum(units*price) over (partition by customer_id)) as m_a from sales
    #group by customer_id
),
join_cust as (
	select c.customer_id, last_name, first_name, address_id, m_a
    from customers c
    left join 
    cte_gp_amt ct on
    c.customer_id = ct.customer_id),
join_address as (
	select a.address_id, a.country, a.state, a.city, j.customer_id, j.last_name, j.first_name, j.m_a
    from address a left join join_cust j on
    a.address_id = j.address_id),
rank_amt as (
	select a.city, a.m_a, 
    (rank() over (partition by a.city order by a.m_a desc)) as top from join_address a )
select * from rank_amt;


with cte as (
	select distinct c.customer_id, a.city,
		(sum(s.units*s.price) over (partition by c.customer_id, a.city)) as sum_price
        from address a left join customers c
        on a.address_id = c.address_id
        left join sales s on 
        c.customer_id = s.customer_id
),
rank_cte as (
	select c.customer_id, c.city, c.sum_price,
    (rank() over (partition by city order by sum_price desc)) as rank_cust_by_city from cte c
)
select * from rank_cte where rank_cust_by_city < 2;

with cte as
(select c.customer_id, a.city, sum(s.price*s.units) as sum_price,
(rank() over (partition by a.city order by sum(s.price*s.units) desc)) as rank_cust
from address a left join customers c on 
a.address_id = c.address_id 
left join sales s on 
c.customer_id = s.customer_id
group by c.customer_id, a.city) 
select * from cte;
        
# Question 2

select * from sales;

select merchant_id, month(order_date) as grouped_month, sum(price*units) as sales_amt from sales
group by merchant_id, grouped_month
order by merchant_id;

with cte as (
	select merchant_id, month(order_date) as month_order,
    (sum(price*units) over (partition by (month(order_date)))) from sales)
select * from cte group by merchant_id, month_order
order by merchant_id
;

select merchant_id, month(order_date),
	(sum(price*units) over (partition by month(order_date) )) as sales_amt_per_month
from sales
group by merchant_id, month(order_date)
order by merchant_id;

# Query 3
# selects 2nd best selling product in amazon

select * from sales;

with cte as (
select product_sku, 
	(sum(units) over (partition by product_sku)) as sum_units
from sales
),
cte2 as (
select product_sku, sum_units,
(dense_rank() over ( order by sum_units desc)) as rank_units from cte)
select * from cte2 where rank_units = 2 group by product_sku ;

select product_sku, units,
	(rank() over (order by ((sum(units) over (partition by product_sku))))) as rank_units
    from sales;
    
# Second best product in amazon based on units sold
with cte as (
	select product_sku, units, 
		(sum(units) over (partition by product_sku)) as sum_units
	from sales
),
cte2 as (
	select product_sku, units, sum_units,
		(dense_rank() over (order by sum_units desc)) as rank_units
    from cte    
)
select * from cte2 where rank_units = 4 group by product_sku;

    
    




