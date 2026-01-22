-- 4. What was the average distance travelled for each customer?

WITH order_level AS (
    SELECT
        c.order_id,
        c.customer_id,
        TRY_CAST(
            REPLACE(REPLACE(r.distance, 'km', ''), ' ', '')
            AS FLOAT
        ) AS distance_km
    FROM customer_orders c
    JOIN runner_orders r
        ON c.order_id = r.order_id
    WHERE r.pickup_time IS NOT NULL
      AND r.pickup_time <> 'null'
      AND (r.cancellation IS NULL 
           OR r.cancellation = '' 
           OR r.cancellation = 'null')
    GROUP BY 
        c.order_id,
        c.customer_id,
        r.distance
)
SELECT
    customer_id,
    AVG(distance_km) AS avg_distance_km
FROM order_level
GROUP BY customer_id
ORDER BY customer_id;



-- output:-
| customer_id | avg_distance_km |
| ----------- | --------------- |
| 101         | 20.0            |
| 102         | 18.4            |
| 103         | 23.4            |
| 104         | 10.0            |
| 105         | 25.0            |
