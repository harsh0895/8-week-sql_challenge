-- 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value.

select 
	DATEFROMPARTS(YEAR(s.start_date), MONTH(s.start_date), 1) AS month_start,
	COUNT(*) as total_distribution
from plans p 
inner join subscriptions s 
on p.plan_id = s.plan_id
where p.plan_name = 'trial'
group by DATEFROMPARTS(YEAR(s.start_date), MONTH(s.start_date), 1)
order by month_start

-- output:-
| month_start | total_distribution |
| ----------- | ------------------ |
| 2020-01-01  | 88                 |
| 2020-02-01  | 68                 |
| 2020-03-01  | 94                 |
| 2020-04-01  | 81                 |
| 2020-05-01  | 88                 |
| 2020-06-01  | 79                 |
| 2020-07-01  | 89                 |
| 2020-08-01  | 88                 |
| 2020-09-01  | 87                 |
| 2020-10-01  | 79                 |
| 2020-11-01  | 75                 |
| 2020-12-01  | 84                 |
