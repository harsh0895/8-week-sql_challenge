-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

with total_purchased as (
	select s.product_id, COUNT(s.product_id) as total_purchased_counts
	from sales s
	inner join menu m 
	on s.product_id = m.product_id
	group by s.product_id
)
select product_name, total_purchased_counts
from total_purchased as tp
inner join menu as m
on tp.product_id = m.product_id
where total_purchased_counts = (select MAX(total_purchased_counts) from total_purchased)

-- output:-
| product_name | total_purchased_counts |
| ------------ | ---------------------- |
| ramen        | 8                      |
