# Temp table - allows to create a dataset stored as a table which you can query

select 
	pageview_url,
    count(distinct website_pageview_id) as pvs
from website_pageviews
group by pageview_url
order by pvs desc;

create temporary table first_pageview
select 
	website_session_id,
    min(website_pageview_id) as min_pv_id
from website_pageviews
where website_pageview_id < 1000
group by website_session_id;

select 
	website_pageviews.pageview_url as landing_page,
    count(distinct first_pageview.website_session_id) as sessions_hitting_this_lander
from first_pageview
	left join website_pageviews
		on first_pageview.min_pv_id = website_pageviews.website_pageview_id
group by 
	website_pageviews.pageview_url;
    
# Assign
select 
	pageview_url,
    count(distinct website_pageview_id) cnt
from website_pageviews
where created_at < '2012-06-09'
group by 1
order by cnt desc;

# Assign
# step 1: find the first pageview for each session
# step 2: find the url the customer saw on that first pageview

create temporary table first_pv_per_session
select 
		website_session_id,
        min(website_pageview_id) as first_pv
from website_pageviews
where created_at < '2012-06-12'
group by website_session_id;

select 
	w.pageview_url as landing_page_url,
    count(f.website_session_id) as sessions_hitting_page
from first_pv_per_session f
	left join website_pageviews w
    on f.first_pv = w.website_pageview_id
group by landing_page_url;

# Assign 