-- 7. Which item was purchased just before the customer became a member?

with last_item_purchased as (
	select 
		s.customer_id, 
		s.order_date, 
		mm.join_date, 
		m.product_name,
		RANK() over(partition by s.customer_id order by s.order_date desc) as rn 
	from sales s
	inner join members mm
	on s.customer_id = mm.customer_id
	inner join menu m 
	on s.product_id = m.product_id
	where s.order_date < mm.join_date
)
select 
	customer_id,
	order_date,
	join_date,
	product_name
from last_item_purchased
where rn = 1

-- output:-
| customer_id | order_date | join_date  | product_name |
| ----------- | ---------- | ---------- | ------------ |
| A           | 2021-01-01 | 2021-01-07 | sushi        |
| A           | 2021-01-01 | 2021-01-07 | curry        |
| B           | 2021-01-04 | 2021-01-09 | sushi        |
