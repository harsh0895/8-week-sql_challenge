-- 10. What was the volume of orders for each day of the week?

SELECT 
    DATEPART(WEEKDAY, order_time) AS weekday_number,
    DATENAME(WEEKDAY, order_time) AS day_of_week,
    COUNT(*) AS total_pizzas_ordered
FROM customer_orders
GROUP BY DATEPART(WEEKDAY, order_time), DATENAME(WEEKDAY, order_time)
ORDER BY weekday_number;

-- output:-
| weekday_number | day_of_week | total_pizzas_ordered |
| -------------- | ----------- | -------------------- |
| 4              | Wednesday   | 5                    |
| 5              | Thursday    | 3                    |
| 6              | Friday      | 1                    |
| 7              | Saturday    | 5                    |
