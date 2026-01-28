-- 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name.

select 
	p.plan_name, 
	COUNT(*) as total_events
from subscriptions s
inner join plans p 
on s.plan_id = p.plan_id
where s.start_date >= '2021-01-01'
group by p.plan_name

output:-
| plan_name     | total_events |
| ------------- | ------------ |
| basic monthly | 8            |
| churn         | 71           |
| pro annual    | 63           |
| pro monthly   | 60           |
