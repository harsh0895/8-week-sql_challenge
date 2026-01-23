-- 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

WITH delivery_speed AS (
    SELECT
        order_id,
        runner_id,
        TRY_CAST(
            REPLACE(REPLACE(distance, 'km', ''), ' ', '')
            AS FLOAT
        ) AS distance_km,
        TRY_CAST(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(duration, 'minutes', ''),
                    'minute', ''),
                'mins', ''),
            ' ', '')
            AS FLOAT
        ) AS duration_minutes
    FROM runner_orders
    WHERE pickup_time IS NOT NULL
      AND pickup_time <> 'null'
      AND (cancellation IS NULL 
           OR cancellation = '' 
           OR cancellation = 'null')
)
-- Calculate speed per delivery
SELECT
    runner_id,
    order_id,
    ROUND(distance_km / duration_minutes, 3) AS speed_km_per_min
FROM delivery_speed
WHERE distance_km IS NOT NULL
  AND duration_minutes IS NOT NULL
ORDER BY runner_id, order_id;

-- output:-
| runner_id | order_id | speed_km_per_min |
| --------- | -------- | ---------------- |
| 1         | 1        | 0.625            |
| 1         | 2        | 0.741            |
| 1         | 3        | 0.670            |
| 2         | 4        | 0.585            |
| 2         | 7        | 1.000            |
| 2         | 8        | 1.560            |
| 3         | 5        | 0.667            |
| 1         | 10       | 1.000            |

-- Average speed per runner (Trend View)
SELECT
    runner_id,
    ROUND(AVG(distance_km / duration_minutes), 3) AS avg_speed_km_per_min
FROM delivery_speed
WHERE distance_km IS NOT NULL
  AND duration_minutes IS NOT NULL
GROUP BY runner_id
ORDER BY runner_id;

-- output:-
runner_id | avg_speed_km_per_min
1	      |          0.759
2	      |          1.048
3	      |          0.667


