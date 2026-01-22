-- 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

WITH order_level AS (
    SELECT
        co.order_id,
        COUNT(*) AS pizza_count,
        MIN(co.order_time) AS order_time
    FROM customer_orders co
    GROUP BY co.order_id
),
prep_time AS (
    SELECT
        ol.order_id,
        ol.pizza_count,
        DATEDIFF(
            MINUTE,
            ol.order_time,
            CAST(ro.pickup_time AS DATETIME)
        ) AS preparation_time_minutes
    FROM order_level ol
    JOIN runner_orders ro
        ON ol.order_id = ro.order_id
    WHERE ro.pickup_time IS NOT NULL
      AND ro.pickup_time <> 'null'
      AND (ro.cancellation IS NULL 
           OR ro.cancellation = '' 
           OR ro.cancellation = 'null')
)
SELECT 
    pizza_count,
    AVG(preparation_time_minutes) AS avg_preparation_time_minutes
FROM prep_time
GROUP BY pizza_count
ORDER BY pizza_count;

-- output:-
| pizza_count | avg_preparation_time_minutes |
| ----------- | ---------------------------- |
| 1           | 12                           |
| 2           | 18                           |
| 3           | 30                           |

