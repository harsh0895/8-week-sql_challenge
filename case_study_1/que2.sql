-- 2. How many days has each customer visited the restaurant?

select 
	s.customer_id,
	COUNT(distinct s.order_date) as total_visits
from sales as s 
group by s.customer_id
order by s.customer_id;

-- ⭐ Alternative (Without DISTINCT — Advanced)
SELECT 
    customer_id, 
    COUNT(*) AS total_visits
FROM (
    SELECT DISTINCT customer_id, order_date
    FROM sales
) t
GROUP BY customer_id;

-- output:-
| customer_id | total_visits |
| ----------- | ------------ |
| A           | 4            |
| B           | 6            |
| C           | 2            |
