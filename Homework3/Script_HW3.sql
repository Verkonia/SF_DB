create Table customer (
  customer_id int4,
  first_name varchar(50),
  last_name varchar(50),
  gender varchar(30),
  dob varchar(50),
  job_title varchar(50),
  job_industry_category varchar(50),
  wealth_segment varchar(50),
  deceased_indicator varchar(50),
  owns_car varchar(30),
  address varchar(50),
  postcode varchar(30),
  state varchar(30),
  country varchar(30),
  property_valuation int4
)

create table  transaction (
  transaction_id int4,
  product_id int4,
  customer_id int4,
  transaction_date varchar(30),
  online_order varchar(30),
  order_status varchar(30),
  brand varchar(30),
  product_line varchar(30),
  product_class varchar(30),
  product_size varchar(30),
  list_price float4,
  standard_cost float4
)

select count(customer_id), job_industry_category  
from customer
group by job_industry_category
order by count desc

select sum(tr.list_price),cus.job_industry_category,date_trunc('month', tr.transaction_date::date) 
from transaction tr
inner join customer cus on tr.customer_id =cus.customer_id
group by cus.job_industry_category, date_trunc('month', tr.transaction_date::date) 
order by date_trunc('month', tr.transaction_date::date)

select count(online_order), brand
from transaction tr
inner join customer cus on tr.customer_id = cus.customer_id
where online_order='True' and job_industry_category ='IT'
group by brand

select customer_id, sum(list_price), min(list_price), count(list_price)
from transaction
group by customer_id
order by sum desc, count desc


select customer_id, 
	sum(list_price) over(partition by customer_id),
	max(list_price) over(partition by customer_id),
	min(list_price) over(partition by customer_id),
	count(list_price) over(partition by customer_id)
from transaction 
order by sum desc, count desc

select first_name, last_name,
	sum(list_price) over(partition by first_name, last_name)
from customer cus
left join transaction tr on cus.customer_id=tr.transaction_id
order by sum desc
limit 1

select first_name, last_name,
	sum(list_price) over(partition by first_name, last_name)
from customer cus
left join transaction tr on cus.customer_id=tr.transaction_id
order by sum asc
limit 1

select *
from(
	select customer_id,transaction_date,
		row_number() over(partition by customer_id order by transaction_date::date asc) as number
	from transaction
	)
where number = 1

select first_name,
	last_name,
	job_industry_category,
	lag-lead as dif
	from(
	select *, 
	lag(days) over(partition by first_name, last_name order by days desc),
	lead(days) over(partition by first_name, last_name order by days desc)
	from(
		select cus.first_name, 
			cus.last_name, 
			cus.job_industry_category,
			tr.transaction_date,
			date_trunc('day', tr.transaction_date::date) as days
		from customer cus
		right join transaction tr on cus.customer_id=tr.customer_id
	))
where lag-lead is not null
order by dif desc
limit 2