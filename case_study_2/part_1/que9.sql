-- 9. What was the total volume of pizzas ordered for each hour of the day?

SELECT 
    DATEPART(HOUR, order_time) AS hour_of_day,
    COUNT(*) AS total_pizzas_ordered
FROM customer_orders
GROUP BY DATEPART(HOUR, order_time)
ORDER BY hour_of_day;

-- output:-.
| hour_of_day | total_pizzas_ordered |
| ----------- | -------------------- |
| 11          | 1                    |
| 13          | 3                    |
| 18          | 3                    |
| 19          | 1                    |
| 21          | 3                    |
| 23          | 3                    |
