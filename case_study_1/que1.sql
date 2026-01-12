-- 1. What is the total amount each customer spent at the restaurant?

select 
	s.customer_id,
	SUM(m.price) as total_amount
from sales as s
inner join menu as m 
on s.product_id = m.product_id
group by s.customer_id
order by s.customer_id

-- output:-
| customer_id | total_amount |
| ----------- | ------------ |
| A           | 76           |
| B           | 74           |
| C           | 36           |

