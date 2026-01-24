-- 1. What are the standard ingredients for each pizza?

WITH recipe_toppings AS (
    SELECT
        pr.pizza_id,
        TRY_CAST(LTRIM(RTRIM(s.value)) AS INT) AS topping_id
    FROM pizza_recipes pr
    CROSS APPLY STRING_SPLIT(pr.toppings, ',') s
)
SELECT
    pn.pizza_name,
    pt.topping_name
FROM recipe_toppings rt
JOIN pizza_toppings pt
    ON rt.topping_id = pt.topping_id
JOIN pizza_names pn
    ON rt.pizza_id = pn.pizza_id
ORDER BY pn.pizza_name, pt.topping_name;

-- output:-
| pizza_name | topping_name |
| ---------- | ------------ |
| Meatlovers | Bacon        |
| Meatlovers | BBQ Sauce    |
| Meatlovers | Beef         |
| Meatlovers | Cheese       |
| Meatlovers | Chicken      |
| Meatlovers | Mushrooms    |
| Meatlovers | Pepperoni    |
| Meatlovers | Salami       |
| Vegetarian | Cheese       |
| Vegetarian | Mushrooms    |
| Vegetarian | Onions       |
| Vegetarian | Peppers      |
| Vegetarian | Tomatoes     |
| Vegetarian | Tomato Sauce |
