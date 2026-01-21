-- 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

WITH pickup_times AS (
    SELECT DISTINCT
        ro.order_id,
        ro.runner_id,
        DATEDIFF(
            MINUTE,
            co.order_time,
            CAST(ro.pickup_time AS DATETIME)
        ) AS minutes_diff
    FROM runner_orders ro
    JOIN customer_orders co
        ON ro.order_id = co.order_id
    WHERE ro.pickup_time IS NOT NULL
      AND ro.pickup_time <> 'null'
)
SELECT 
    runner_id,
    AVG(minutes_diff) AS avg_minutes_to_pickup
FROM pickup_times
GROUP BY runner_id
ORDER BY runner_id;


-- output:-
| runner_id | avg_minutes_to_pickup |
| --------- | --------------------- |
| 1         | 14.00                 |
| 2         | 20.00                 |
| 3         | 10.00                 |

