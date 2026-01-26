-- 2. What was the most commonly added extra?

WITH extras_split AS (
    SELECT
        TRY_CAST(LTRIM(RTRIM(s.value)) AS INT) AS topping_id
    FROM customer_orders co
    JOIN runner_orders ro
        ON co.order_id = ro.order_id
    CROSS APPLY STRING_SPLIT(co.extras, ',') s
    WHERE ro.pickup_time IS NOT NULL
      AND ro.pickup_time <> 'null'
      AND (ro.cancellation IS NULL 
           OR ro.cancellation = '' 
           OR ro.cancellation = 'null')
      AND co.extras IS NOT NULL
      AND co.extras <> ''
      AND co.extras <> 'null'
)
SELECT TOP 1
    pt.topping_name,
    COUNT(*) AS times_added
FROM extras_split es
JOIN pizza_toppings pt
    ON es.topping_id = pt.topping_id
GROUP BY pt.topping_name
ORDER BY times_added DESC;

-- output:-
| topping_name | times_added |
| ------------ | ----------- |
| Bacon        | 4           |
