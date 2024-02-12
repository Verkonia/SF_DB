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

select distinct brand from transaction
where standard_cost > 1500

select * from transaction
where transaction_date::timestamp between '2017-04-01'::timestamp and '2017-04-09'::timestamp and order_status = 'Approved'

select job_title from customer
where (job_industry_category ='IT' or job_industry_category ='Financial Services') and job_title like 'Senior%'


select distinct(job_title) from customer
where (job_industry_category ='IT' or job_industry_category ='Financial Services') and job_title like 'Senior%'

select tr.brand from transaction tr
left join customer cus on tr.customer_id = cus.customer_id 
where job_industry_category ='Financial Services'

select distinct(tr.brand) from transaction tr
left join customer cus on tr.customer_id = cus.customer_id 
where job_industry_category ='Financial Services'

select tr.brand from transaction tr
left join customer cus on tr.customer_id = cus.customer_id  
where online_order ='True' and brand in('Giant Bicycles','Norco Bicycles','Trek Bicycles')
limit 10

select cus.customer_id  from customer cus
full outer join transaction tr on cus.customer_id = tr.customer_id 
where tr.customer_id  is null 

select tr.customer_id from transaction tr
left join customer cus on tr.customer_id =cus.customer_id 
where job_industry_category ='IT' and standard_cost in (select max(standard_cost) from transaction)

select tr.customer_id  from transaction tr
left join customer cus on tr.customer_id =cus.customer_id 
where job_industry_category in ('IT', 'Health') and transaction_date in (select transaction_date from transaction 
where order_status= 'Approved'and transaction_date::timestamp between '2017-07-07'::timestamp and '2017-07-17'::timestamp)