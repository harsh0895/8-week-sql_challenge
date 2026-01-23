-- 7. What is the successful delivery percentage for each runner?

SELECT
    runner_id,
    ROUND(
        100.0 * 
        SUM(
            CASE 
                WHEN pickup_time IS NOT NULL
                 AND pickup_time <> 'null'
                 AND (cancellation IS NULL 
                      OR cancellation = '' 
                      OR cancellation = 'null')
                THEN 1 
                ELSE 0 
            END
        ) / COUNT(*),
        2
    ) AS successful_delivery_percentage
FROM runner_orders
GROUP BY runner_id
ORDER BY runner_id;

-- output:-
| runner_id | successful_delivery_percentage |
| --------- | ------------------------------ |
| 1         | 100.00                         |
| 2         | 75.00                          |
| 3         | 50.00                          |
