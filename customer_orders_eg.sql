/*for each customer, identify the top 3 products on which they have spent the most money in total.
The total spent on a product is calculated as the sum of quantity * price across all orders placed by the customer.
The result should include the following columns: customer_name, product_name, total_spent
 
orders Table:
-------------
order_id (Primary Key)
customer_id
order_date
total_amount
 
customers Table:
----------------
customer_id (Primary Key)
customer_name
city
country
 
order_items Table:
------------------
order_item_id (Primary Key)
order_id
product_id
quantity
unit_price
 
products Table:
---------------
product_id (Primary Key)
product_name
category
*/

with customer_spend_by_product (
select c.customer_name
, p.product_name
, (oi.unit_price*oi.quantity) as total_spent
, rank(order by total_spent desc partition by customer_name, product_name) as myrank --1,2,3, etc.
from orders as o
join customers as c on o.customer_id = c.customer_id
join order_items as oi on o.order_id = oi.order_id
join products as p on oi.product_id = p.product_id
group by customer_name, product_name
)
select customer_name, product_name, total_spent
from customer_spend_by_product
where myrank >=3;
