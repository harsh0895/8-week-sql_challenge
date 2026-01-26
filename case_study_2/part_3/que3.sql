-- 3. What was the most common exclusion?

WITH exclusion_split AS (
	select 
		TRY_CAST(rtrim(LTRIM(s.value)) AS INT) as topping_id
	from customer_orders co
	inner join runner_orders ro
		on co.order_id = ro.order_id
	cross apply string_split(co.exclusions, ',') s 
	WHERE ro.pickup_time IS NOT NULL
	AND ro.pickup_time <> 'null'
	AND (ro.cancellation IS NULL 
		OR ro.cancellation = '' 
		OR ro.cancellation = 'null') and 
		co.exclusions <> 'null' and co.exclusions is not null 
	and co.exclusions <> ''
)
select TOP 1 
	pt.topping_name, 
	COUNT(*) as times_added
from exclusion_split es 
inner join pizza_toppings pt
	on es.topping_id = pt.topping_id
group by pt.topping_name
order by times_added desc

-- output:-
| topping_name | times_added |
| ------------ | ----------- |
| Cheese       | 3           |

