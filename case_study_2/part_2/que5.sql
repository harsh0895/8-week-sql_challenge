-- 5. What was the difference between the longest and shortest delivery times for all orders?

SELECT 
    MAX(delivery_time) - MIN(delivery_time) AS difference_sl
FROM (
    SELECT
        TRY_CAST(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(duration, 'minutes', ''),
                    'minute', ''),
                'mins', ''),
            ' ', '')
            AS INT
        ) AS delivery_time
    FROM runner_orders
    WHERE pickup_time IS NOT NULL
      AND pickup_time <> 'null'
      AND (cancellation IS NULL 
           OR cancellation = '' 
           OR cancellation = 'null')
) m
WHERE delivery_time IS NOT NULL;

-- output:-
difference_sl
-------------
30
