-- 3. What was the first item from the menu purchased by each customer?

select 
	r.customer_id, 
	r.product_name
from (
	select 
		s.customer_id, 
		s.order_date, 
		s.product_id, 
		m.product_name,
		ROW_NUMBER() over(partition by customer_id order by order_date) as rn
	from sales as s
	inner join menu as m 
	on s.product_id = m.product_id
) as r
where r.rn = 1

-- output1:-
| customer_id | product_name |
| ----------- | ------------ |
| A           | sushi        |
| B           | curry        |
| C           | ramen        |



-- The hidden issue (important for interviews)
-- ❓ Problem: Multiple purchases on the same first day

-- Example from your data:
-- Customer A
-- 2021-01-01 → bought sushi and curry

-- When multiple items have the same order_date, SQL Server:
-- Assigns ROW_NUMBER() arbitrarily
-- You may get either sushi or curry, unpredictably

-- ✅ Correct Interpretation (Business Meaning)
-- The question:
-- What was the first item from the menu purchased by each customer?
-- Usually means:
-- 👉 Return all items purchased on the first visit day

WITH first_order AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM sales
    GROUP BY customer_id
)
SELECT
    s.customer_id,
    m.product_name
FROM sales s
JOIN first_order f
    ON s.customer_id = f.customer_id
   AND s.order_date = f.first_order_date
JOIN menu m
    ON s.product_id = m.product_id
ORDER BY s.customer_id;

-- output:-
| customer_id | product_name |
| ----------- | ------------ |
| A           | sushi        |
| A           | curry        |
| B           | curry        |
| C           | ramen        |
