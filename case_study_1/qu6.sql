-- 6. Which item was purchased first by the customer after they became a member?

with first_item_purchased as (
	select 
		s.customer_id, 
		s.order_date, 
		mm.join_date, 
		m.product_name,
		RANK() over(partition by s.customer_id order by s.order_date) as rn 
	from sales s
	inner join members mm
	on s.customer_id = mm.customer_id
	inner join menu m 
	on s.product_id = m.product_id
	where s.order_date >= mm.join_date
)
select 
    customer_id,
    product_name, 
    join_date, 
    order_date
from first_item_purchased
where rn = 1

-- output:-.
| customer_id | product_name | join_date  | order_date |
| ----------- | ------------ | ---------- | ---------- |
| A           | curry        | 2021-01-07 | 2021-01-07 |
| B           | sushi        | 2021-01-09 | 2021-01-11 |


