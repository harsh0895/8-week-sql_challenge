-- 2. How many unique customer orders were made?

SELECT 
    COUNT(DISTINCT order_id) AS unique_customer_orders
FROM customer_orders;

-- output:-
unique_customer_orders
----------------------
10

