-- 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

select 
    (DATEDIFF(day, '2021-01-01', registration_date) / 7 + 1) as 'week_number',
	COUNT(*) as total_runners
from runners
group by (DATEDIFF(day, '2021-01-01', registration_date) / 7 + 1);

-- output:-
| week_number | total_runners |
| ----------- | ------------- |
| 1           | 2             |
| 2           | 1             |
| 3           | 1             |
