-- 6. What is the number and percentage of customer plans after their initial free trial?

WITH ordered_plans AS (
    SELECT
        s.customer_id,
        p.plan_name,
        ROW_NUMBER() OVER (
            PARTITION BY s.customer_id
            ORDER BY s.start_date
        ) AS plan_order
    FROM subscriptions s
    JOIN plans p
        ON s.plan_id = p.plan_id
)
SELECT
    plan_name,
    COUNT(customer_id) AS customer_count,
    ROUND(
        COUNT(customer_id) * 100.0
        / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions),
        1
    ) AS percentage_of_customers
FROM ordered_plans
WHERE plan_order = 2
GROUP BY plan_name
ORDER BY customer_count DESC;

-- output:-
| plan_name     | customer_count | percentage_of_customers |
| ------------- | -------------- | ----------------------- |
| basic monthly | 546            | 54.6                    |
| pro monthly   | 325            | 32.5                    |
| churn         | 92             | 9.2                     |
| pro annual    | 37             | 3.7                     |
