create table zepto(
sku_id SERIAL primary key,
category varchar(120),
name varchar(120) NOT NULL,
mrp decimal(8,2),
discount_pct numeric(5,2),
available_qnt integer,
discounted_selling_price numeric(8,2),
weight_in_gms integer,
out_of_stock boolean,
quantity integer
);


# EDA

-- row count
select count(*) from zepto;


-- df.head()
select *
from zepto
limit 5;


-- unique category
select DISTINCT category
from zepto
order by category;


-- product in stock
select out_of_stock , count(*)
from zepto
group by out_of_stock;


-- product name entered multiple times with different prices, weights, or discounts
select name,count(sku_id) as "n_SKU"
from zepto
group by name
HAVING count(sku_id) > 1
order by "n_SKU" desc;


-- Business Questions

-- 1. top 10 products based on discount_pct

select distinct name,mrp,discount_pct
from zepto
order by discount_pct desc
limit 10;


-- 2. products with max mrp but are out of stock

select distinct name,mrp
from zepto
where out_of_stock = TRUE and mrp < (select max(mrp) from zepto)
order by mrp desc 
limit 5;


-- 3. estimated revenue per category

select category,
sum(discounted_selling_price * available_qnt) as "total_est_revenue"
from zepto
where out_of_stock = FALSE
group by category
order by total_est_revenue desc;


-- 4. all products with mrp > 500 & discount_pct<10

select distinct name,mrp,discount_pct
from zepto
where mrp > 500.0 and discount_pct < 10;


-- 5. top 5 categories with high avg discount_pct

select category, round(avg(discount_pct),2) as "avg. discount pct"
from zepto
group by category
order by "avg. discount pct" desc
limit 5;


-- 6. price per gram for products above 100g & sort by best value

select distinct name,round((discounted_selling_price/weight_in_gms),2) as "price per gram"
from zepto 
where weight_in_gms >= 100
order by "price per gram";

-- 7. group the products into categories as light,medium,bulk

select distinct name, weight_in_gms,
case when weight_in_gms < 1000 then 'light'
when weight_in_gms < 5000 then 'medium'
else 'bulk'
end as "weight_category"
from zepto;


-- 8.total inventory weight per category
select category,sum(weight_in_gms * available_qnt) as "weight per category"
from zepto
group by category
order by "weight per category" desc;