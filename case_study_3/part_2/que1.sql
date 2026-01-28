-- 1. How many customers has Foodie-Fi ever had?

select 
	count(distinct customer_id) total_customer 
from subscriptions

-- output:-
total_customer
1000