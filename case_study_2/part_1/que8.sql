-- 8. How many pizzas were delivered that had both exclusions and extras?

SELECT 
    COUNT(*) AS pizzas_with_exclusions_and_extras
FROM customer_orders co
JOIN runner_orders ro
    ON co.order_id = ro.order_id
WHERE ro.pickup_time IS NOT NULL
  AND ro.pickup_time <> 'null'
  AND (ro.cancellation IS NULL 
       OR ro.cancellation = '' 
       OR ro.cancellation = 'null')
  AND (co.exclusions IS NOT NULL AND co.exclusions <> '' AND co.exclusions <> 'null')
  AND (co.extras IS NOT NULL AND co.extras <> '' AND co.extras <> 'null');

-- output:-
pizzas_with_exclusions_and_extras
--------------------------------
1
