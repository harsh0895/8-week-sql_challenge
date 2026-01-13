-- 5. Which item was the most popular for each customer?

with total_item_purchased as (
	select 
		s.customer_id,
		m.product_name,
		COUNT(s.product_id) as most_popular,
		RANK() over(partition by s.customer_id order by count(s.product_id) desc) as rn
	from sales s
	inner join menu m 
	on s.product_id = m.product_id
	group by s.customer_id, m.product_name
)
select customer_id, product_name, most_popular
from total_item_purchased
where rn = 1

-- output:-
| customer_id | product_name | most_popular |
| ----------- | ------------ | ------------ |
| A           | ramen        | 3            |
| B           | curry        | 2            |
| B           | sushi        | 2            |
| B           | ramen        | 2            |
| C           | ramen        | 3            |
