-- 4. Generate an order item for each record in the customers_orders table in the format of one of the following:
--     Meat Lovers
--     Meat Lovers - Exclude Beef
--     Meat Lovers - Extra Bacon
--     Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

WITH exclusions_cte AS (
    SELECT
        co.order_id,
        co.pizza_id,
        STRING_AGG(pt.topping_name, ', ') AS exclusions
    FROM customer_orders co
    CROSS APPLY STRING_SPLIT(co.exclusions, ',') s
    JOIN pizza_toppings pt
        ON TRY_CAST(LTRIM(RTRIM(s.value)) AS INT) = pt.topping_id
    WHERE co.exclusions IS NOT NULL
      AND co.exclusions <> ''
      AND co.exclusions <> 'null'
    GROUP BY co.order_id, co.pizza_id
),
extras_cte AS (
    SELECT
        co.order_id,
        co.pizza_id,
        STRING_AGG(pt.topping_name, ', ') AS extras
    FROM customer_orders co
    CROSS APPLY STRING_SPLIT(co.extras, ',') s
    JOIN pizza_toppings pt
        ON TRY_CAST(LTRIM(RTRIM(s.value)) AS INT) = pt.topping_id
    WHERE co.extras IS NOT NULL
      AND co.extras <> ''
      AND co.extras <> 'null'
    GROUP BY co.order_id, co.pizza_id
)
SELECT
    pn.pizza_name
    + COALESCE(' - Exclude ' + e.exclusions, '')
    + COALESCE(' - Extra ' + x.extras, '') AS order_item
FROM customer_orders co
JOIN pizza_names pn
    ON co.pizza_id = pn.pizza_id
LEFT JOIN exclusions_cte e
    ON co.order_id = e.order_id
   AND co.pizza_id = e.pizza_id
LEFT JOIN extras_cte x
    ON co.order_id = x.order_id
   AND co.pizza_id = x.pizza_id
ORDER BY co.order_id;


-- output:-
| order_item                                          |
| --------------------------------------------------- |
| Meat Lovers                                         |
| Meat Lovers                                         |
| Vegetarian                                          |
| Meat Lovers - Exclude Cheese                        |
| Meat Lovers - Exclude Cheese                        |
| Vegetarian - Exclude Cheese                         |
| Meat Lovers - Extra Bacon                           |
| Vegetarian - Extra Bacon                            |
| Meat Lovers - Exclude Cheese - Extra Bacon, Chicken |
