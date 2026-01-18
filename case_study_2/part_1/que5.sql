-- 5. How many Vegetarian and Meatlovers were ordered by each customer?

select 
	co.customer_id,
	pn.pizza_name,
	COUNT(*) total_pizzas_ordered
from customer_orders co
inner join pizza_names pn
on co.pizza_id = pn.pizza_id
group by co.customer_id, pn.pizza_name
order by co.customer_id

-- output:-
| customer_id | pizza_name | total_pizzas_ordered |
| ----------- | ---------- | -------------------- |
| 101         | Meatlovers | 2                    |
| 101         | Vegetarian | 1                    |
| 102         | Meatlovers | 2                    |
| 102         | Vegetarian | 1                    |
| 103         | Meatlovers | 3                    |
| 103         | Vegetarian | 1                    |
| 104         | Meatlovers | 3                    |
| 105         | Vegetarian | 1                    |
