-- 8. What is the total items and amount spent for each member before they became a member?

select
	s.customer_id,
	COUNT(*) as total_items,
	SUM(m.price) as total_amount_spent
from sales s
inner join members mm
    on s.customer_id = mm.customer_id
inner join menu m 
    on s.product_id = m.product_id
where s.order_date < mm.join_date
group by s.customer_id

-- output:-
| customer_id | total_items | total_amount_spent |
| ----------- | ----------- | ------------------ |
| A           | 2           | 25                 |
| B           | 3           | 40                 |
