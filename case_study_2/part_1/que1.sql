-- 1. How many pizzas were ordered?

select 
    COUNT(pizza_id) as total_pizzas_ordered
from customer_orders;

-- output:-
total_pizzas_ordered
--------------------
14
