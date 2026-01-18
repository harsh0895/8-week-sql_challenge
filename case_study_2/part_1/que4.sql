-- 4. How many of each type of pizza was delivered?

select 
	pn.pizza_name,
	COUNT(*) as total_pizzas_delievered
from customer_orders co
inner join runner_orders ro
on co.order_id = ro.order_id
inner join pizza_names pn
on co.pizza_id = pn.pizza_id
where ro.pickup_time != 'null'
and ro.pickup_time IS NOT NULL
and (ro.cancellation is null or cancellation = '' or cancellation = 'null')
group by pn.pizza_name

-- output:-
| pizza_name | total_pizzas_delivered |
| ---------- | ---------------------- |
| Meatlovers | 9                      |
| Vegetarian | 3                      |
