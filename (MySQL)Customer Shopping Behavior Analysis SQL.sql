use sales_analysis;

select * from ccsb;

select gender, round(sum(purchase_amount),2) as total_revenue
from ccsb group by gender order by total_revenue desc;

select item_purchased as Item_Name, round(avg(review_rating),2) as Average_rating
from ccsb group by item_purchased order by Average_rating desc
limit 6;

select* from ccsb;

select customer_id, purchase_amount as total_revenue
from ccsb where discount_applied = "Yes"
and purchase_amount >=(select round(avg(purchase_amount),2) from ccsb)
order by total_revenue desc;

select shipping_type,round(avg(purchase_amount),2)
as average_revenue
from ccsb group by shipping_type
order by average_revenue desc;

select * from ccsb;

select subscription_status, 
count(customer_id),
round(avg(purchase_amount),2) as average_spent,
sum(purchase_amount) as total_spent
from ccsb group by subscription_status;

select item_purchased, 
round(sum(case when discount_applied = "Yes" then 1 else 0 end)/count(*) *100,2) as discount_rate
from ccsb
group by item_purchased
order by discount_rate desc
limit 5;

select * from ccsb;

with customer_type as(
select customer_id,previous_purchases,
case when previous_purchases = 1 then "New"
when previous_purchases between 2 and 10 then "Returning"
else "Loyal" end as customer_segment
from ccsb)

select customer_segment, count(*) as total_customer
from customer_type
group by customer_segment;

select * from ccsb;

with item_count as(
select category,item_purchased,
count(customer_id) as total_order,
row_number() over(partition by category order by count(customer_id)desc)
as item_rank
from ccsb
group by category, item_purchased)

select item_rank, category, item_purchased,total_order
from item_count
where item_rank <= 3;

select * from ccsb;

select subscription_status,
sum(case when previous_purchases > 5 then 1 else 0 end) as purchase_count
from ccsb
group by subscription_status;

select * from ccsb;

select age_group,
sum(purchase_amount) as revenue
from ccsb
group by age_group
order by revenue desc;

select * from ccsb;

select gender,
count(subscription_status)
from ccsb
where subscription_status = "Yes"
group by gender;

