use [Project-1_Ecommerces]
select * from customers;
select * from order_items;
select * from orders;
select * from products;
select * from sales_cleaned;

-- data cleaning

select 
count(*) as total_Rows,
sum(case when customer_id is null then 1 else 0 end ) as customer_id_missing,
sum(case when country is null then 1 else 0 end ) as country_missing,
sum(case when signup_date is null then 1 else 0 end) as signup_date_missing 
from customers;

select
count(*) as total_rows,
sum(case when order_id is null then 1 else 0 end ) as order_id_missing,
Sum( case when customer_id is null then 1 else 0 end ) as customer_id_missing,
Sum( case when order_date is null then 1 else 0 end ) as order_date_missing,
Sum( case when status is null then 1 else 0 end ) as status_missing
from orders;

select 
count(*) as total_rows,
Sum( case when product_id is null then 1 else 0 end ) as product_id_missing,
Sum( case when product_name is null then 1 else 0 end ) as product_name_missing,
Sum( case when category is null then 1 else 0 end ) as category_missing
from products;

select 
count(*) as total_rows,
Sum( case when order_id is null then 1 else 0 end ) as order_id_missing,
Sum( case when product_id is null then 1 else 0 end ) as product_id_missing,
Sum( case when quantity is null then 1 else 0 end ) as quantity_id_missing,
Sum( case when price is null then 1 else 0 end ) as price_missing,
Sum( case when Revenue is null then 1 else 0 end ) as Revenue_missing,
Sum( case when customer_id is null then 1 else 0 end ) as customer_id_missing,
Sum( case when order_date is null then 1 else 0 end ) as order_date_missing,
Sum( case when status is null then 1 else 0 end ) as status_missing,
Sum( case when year is null then 1 else 0 end ) as year_missing,
Sum( case when month is null then 1 else 0 end ) as month_missing
from sales_cleaned;

--duplicate customers table
select country , 
count(*) as duplicate_Count 
from customers
group by country
having count(*)>1;

select  signup_date ,
count(*) as duplicate_Count 
from customers
group by signup_date
having count(*)>1;
-- order_items table
select  price ,
count(*) as duplicate_Count 
from order_items
group by price
having count(*)>1;

select  quantity ,
count(*) as duplicate_Count 
from order_items
group by quantity
having count(*)>1;

select  order_id ,
count(*) as duplicate_Count 
from order_items
group by order_id
having count(*)>1;
--orders table
select  order_date ,
count(*) as duplicate_Count 
from orders
group by order_date
having count(*)>1;

select  customer_id,
count(*) as duplicate_Count 
from orders
group by customer_id
having count(*)>1;

--products table
select  category ,
count(*) as duplicate_Count 
from products
group by category
having count(*)>1;

--sales_cleaned table
select  price ,
count(*) as duplicate_Count 
from sales_cleaned
group by price
having count(*)>1;

select Revenue,
count(*) as duplicate_count
from sales_cleaned
group by Revenue
having count(*) >1;

select quantity,
count(*) as duplicate_count
from sales_cleaned
group by quantity
having count(*)>1
-- data analysis
-- customers - customer distribution by country 
select country,
count(*) as total_customer
from customers
group by country
order by total_customer desc;
-- customers - total_customer distribution by signup_data 
select signup_date,
count(*) as total_customer
from customers
group by signup_date
order by total_customer desc;
-- order_items - order_id distribution by price
select price,
count(*) as total_order_id
from order_items
group by price
order by total_order_id desc;
-- order_items - price distribution by quantity
select quantity,
count(*) as total_price
from order_items
group by quantity
order by total_price desc;
-- customers - customer distribution by country 
select order_date,
count(*) as total_custmoer_id
from orders
group by order_date
order by total_custmoer_id desc;
-- orders - order_id distribution by customer_id  
 select customer_id,
 count(*) as total_order_id
 from orders
 group by customer_id
 order by total_order_id desc;
 -- products - product_id distribution by category
 select category,
 count(*) as total_product_id
 from products
 group by category
 order by total_product_id desc;
-- sales_cleand - price distribution by revenue
 select Revenue,
 count(*) as total_price
 from sales_cleaned
 group by Revenue
 order by total_price desc;
 -- salces_cleand - quantity distribution by price
 select price,
 count(*) as total_quantity
 from sales_cleaned
 group by price
 order by total_quantity desc;
-- using joins how we can do analysis and use aggrgate functions
-- how many orders has each customer placed 
select c.customer_id,
c.country,
count(o.order_id) as total_orders
from customers as c 
left join orders as o 
on c.customer_id=o.customer_id
group by 
c.customer_id,
c.country
order by total_orders desc;

select oi.order_id,
oi.price,
count(o.order_date) as total_order_date
from order_items as oi 
left join orders as o 
on oi.order_id=o.order_id
group by 
oi.order_id,
oi.price
order by total_order_date desc;

select p.product_id,
p.category,
count(p.product_id) as total_product
from products as  p
right join order_items  io
on p.product_id = io.product_id
group by p.product_id,p.category
order by total_product desc;

select p.product_id,
p.category,
count(p.product_id) as total_product
from products as  p
inner join order_items  io
on p.product_id = io.product_id
group by p.product_id,p.category
order by total_product desc;
--inner join
select * from products
inner join order_items
on products.product_id = order_items.product_id;
--left join
select * from products
left join order_items
on products.product_id = order_items.product_id;