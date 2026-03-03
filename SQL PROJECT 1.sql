use customer_behavior_db;
select * from customer limit 20

select gender, SUM(purchase_amount) as revenue
from customer
group by gender

select ï»¿customer_id, purchase_amount 
from customer 
where discount_applied = 'Yes' and purchase_amount >=(select AVG(purchase_amount) from customer)
 
select item_purchased,ROUND(AVG(review_rating),2) as "Average Product Rating"
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5;

select shipping_type,
ROUND(AVG(purchase_amount) ,2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type

select subscription_status,
COUNT(ï»¿customer_id) as total_customers,
ROUND(AVG(purchase_amount),2) as avg_spend,
ROUND(SUM(purchase_amount),2) as total_revenue
from customer
group by subscription_status
order by total_revenue,avg_spend DESC;

select item_purchased,
ROUND(100* SUM(CASE WHEN discount_applied = 'YES' THEN 1 ELSE 0 END)/COUNT(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5;

with customer_type as (
select ï»¿customer_id, previous_purchases ,
case
   when previous_purchases =1 then 'new'
   when previous_purchases between 2 and 10 then ' returning'
   else 'loyal'
   end as customer_segment
   from customer
   )
    select customer_segment , count(*) as "number of customers"
    from customer_type
    group by customer_segment
    
WITH item_counts AS (
select category,
item_purchased,
COUNT(ï»¿customer_id) as total_orders,
ROW_NUMBER() OVER(PARTITION BY category ORDER BY COUNT(ï»¿customer_id) DESC) as item_rank
from customer
group by category, item_purchased
)

select item_rank, category, item_purchased, total_orders
from item_counts
where item_rank <= 3;
 
 select subscription_status,
 count(ï»¿customer_id) as repeat_buyers
 from customer
 where previous_purchases > 5
 group by subscription_status
 
select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc;