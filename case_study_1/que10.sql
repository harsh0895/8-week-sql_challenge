-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
    -- not just sushi - how many points do customer A and B have at the end of January?

select s.customer_id,
	sum(CASE
		when datediff(Day, mm.join_date, s.order_date) < 7 then m.price * 20
		else m.price * 10
	end) as total_price1
from sales s
inner join menu m
on s.product_id = m.product_id
inner join members mm
on s.customer_id = mm.customer_id
where s.order_date >= mm.join_date
AND s.order_date <= '2021-01-31'
group by s.customer_id

-- output:-
| customer_id | total_points |
| ----------- | ------------ |
| A           | 1020         |
| B           | 320          |

