create Table customer (
  customer_id int2 primary key,
  first_name varchar,
  last_name varchar,
  gender varchar,
  DOB timestamp,
  wealth_segment varchar,
  deceased_indicator varchar,
  owns_car varchar,
  property_valuation integer
)

create Table transaction (
  transaction_id int2 primary key,
  product_id int2,
  customer_id int2,
  transaction_date varchar,
  online_order boolean,
  order_status varchar
)

create Table product (
  transaction_id int2 primary key,
  brand varchar,
  product_line varchar,
  product_class varchar,
  product_size varchar,
  list_price float4,
  standard_cost float4
)

create Table adress (
  customer_id int2 primary key,
  address varchar,
  postcode varchar,
  state varchar,
  country varchar
)

create Table job (
  customer_id int2 primary key,
  job_title varchar,
  job_industry_category varchar
)