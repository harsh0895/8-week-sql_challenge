-- 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

SELECT 
    COUNT(DISTINCT s.customer_id) AS churned_customers,
    ROUND(
        COUNT(DISTINCT s.customer_id) * 100.0 
        / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions),
        1
    ) AS percentage_of_customers
FROM subscriptions s
JOIN plans p 
    ON p.plan_id = s.plan_id
WHERE p.plan_name = 'churn';

output:-
churned_customers | percentage_of_customers
307               | 30.70