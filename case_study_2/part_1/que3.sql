-- 3. How many successful orders were delivered by each runner?

select 
	runner_id, 
	COUNT(*) as total_orders_delivered
from runner_orders
where pickup_time != 'null'
and (cancellation is null or cancellation = '' or cancellation = 'null') 
group by runner_id

-- output:-
| runner_id | total_orders_delivered |
| --------- | ---------------------- |
| 1         | 4                      |
| 2         | 3                      |
| 3         | 1                      |
