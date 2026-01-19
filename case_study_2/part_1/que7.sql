-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT
    co.customer_id,
    SUM(
        CASE 
            WHEN 
                (co.exclusions IS NOT NULL AND co.exclusions <> '' AND co.exclusions <> 'null')
             OR (co.extras IS NOT NULL AND co.extras <> '' AND co.extras <> 'null')
            THEN 1 
            ELSE 0 
        END
    ) AS pizzas_with_changes,
    SUM(
        CASE 
            WHEN 
                (co.exclusions IS NULL OR co.exclusions = '' OR co.exclusions = 'null')
            AND (co.extras IS NULL OR co.extras = '' OR co.extras = 'null')
            THEN 1 
            ELSE 0 
        END
    ) AS pizzas_with_no_changes
FROM customer_orders co
JOIN runner_orders ro
    ON co.order_id = ro.order_id
WHERE ro.pickup_time IS NOT NULL
  AND ro.pickup_time <> 'null'
  AND (ro.cancellation IS NULL 
       OR ro.cancellation = '' 
       OR ro.cancellation = 'null')
GROUP BY co.customer_id
ORDER BY co.customer_id;


-- output:-
| customer_id | pizzas_with_changes | pizzas_with_no_changes |
| ----------- | ------------------- | ---------------------- |
| 101         | 0                   | 2                      |
| 102         | 0                   | 3                      |
| 103         | 3                   | 1                      |
| 104         | 2                   | 1                      |
| 105         | 1                   | 0                      |
