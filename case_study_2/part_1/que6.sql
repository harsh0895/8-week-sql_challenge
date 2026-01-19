-- 6. What was the maximum number of pizzas delivered in a single order?

with pizzas_delievered as (
	select ro.order_id,
		COUNT(*) as total_pizzas_delieverd
	from customer_orders co 
	inner join runner_orders ro
	on co.order_id = ro.order_id
	where ro.pickup_time is not null and ro.pickup_time !='null'
	and (cancellation is null or cancellation = '' or cancellation = 'null') 
	group by ro.order_id
)
select 
	MAX(total_pizzas_delieverd) as max_pizzas_delivered
from pizzas_delievered;

-- output:-
max_pizzas_delivered
--------------------
3
