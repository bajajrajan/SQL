select w.utm_content, count(distinct w.website_session_id) as sessions,
count(distinct o.order_id) as orders,
count(distinct o.order_id)/count(distinct w.website_session_id) as session_to_order_conv_rt
from website_sessions w
left join orders o
	on o.website_session_id = w.website_session_id
where w.website_session_id between 1000 and 2000 
group by w.utm_content
order by sessions desc;


-- top traffic sources
-- utm source, utm campaiign, http referer, sessions, where - created_at < 2012-04-12
select count(*) from website_sessions;
select * from orders;
select 
	utm_source, 
	utm_campaign, 
    http_referer, 
    count(distinct website_session_id) as sessions
from website_sessions w
where created_at < '2012-04-12'
group by 1,2,3
order by 4 desc;

-- Assign2
select count(distinct w.website_session_id) as sessions,
	count(distinct o.order_id) as orders,
    count(distinct o.order_id)/count(distinct w.website_session_id) as session_to_order_conv_rate
from orders o 
right join website_sessions w 
on o.website_session_id = w.website_session_id
where 
utm_source = 'gsearch' and utm_campaign = 'nonbrand'
and w.created_at < '2012-04-14';

-- Assign 3
-- Month - allows to extract month from a date or datetime
-- month(created_at), year(created_at), week(created_at)
-- use date functions with group by and agreegate function like count and sum to show trending

select
	year(created_at),
    month(created_at),
    week(created_at),
    min(date(created_at)) as mininum_date,
    count(distinct website_session_id) as sessions
from website_sessions
where website_session_id between 100000 and 150000
group by 1,2,3;


select * from orders;
select 
	primary_product_id,
    #order_id,
    #items_purchased,
    count( distinct case when items_purchased = 1 then order_id else null end) as count_single_items_orders,
    count( distinct case when items_purchased = 2 then order_id else null end) as count_two_items_orders
from orders
group by 1;

# Assign 3
select 
	date(created_at) as week_start_date,
    count(distinct website_session_id) as sessions
from website_sessions
where created_at < '2012-05-10'
group by 1;

# Solution - can have columns which are not in select statement but in group by statement
select 
	min(date(created_at)) as week_started_at,
    count(distinct website_session_id) as sessions
from website_sessions
where created_at <'2012-05-12'
	and utm_source = 'gsearch'
    and utm_campaign = 'nonbrand'
group by 
	year(created_at),
    week(created_at);
    
# Assign
select device_type, count(w.website_session_id), count(order_id), count(order_id)/count(w.website_session_id)
from website_sessions w 
left join orders o 
on o.website_session_id = w.website_session_id
where w.created_at < '2012-05-11'
	and utm_source = 'gsearch'
    and utm_campaign = 'nonbrand'
group by 1;

# Assign
select 
	min(date(created_at)) as week_start_date,
    count(distinct case when device_type = 'desktop' then website_session_id else null end) as dtop_sessions,
    count(distinct case when device_type = 'mobile' then website_session_id else null end) as mob_sessions
from website_sessions
where created_at < '2012-06-09'
	and created_at > '2012-04-15'
    and utm_source = 'gsearch'
    and utm_campaign = 'nonbrand'
group by 
	year(created_at),
    week(created_at)
order by week_start_date;

