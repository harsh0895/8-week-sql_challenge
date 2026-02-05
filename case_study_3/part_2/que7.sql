-- 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

WITH latest_plan AS (
    SELECT
        s.customer_id,
        p.plan_name,
        ROW_NUMBER() OVER (
            PARTITION BY s.customer_id
            ORDER BY s.start_date DESC
        ) AS rn
    FROM subscriptions s
    JOIN plans p
        ON s.plan_id = p.plan_id
    WHERE s.start_date <= '2020-12-31'
)
SELECT
    plan_name,
    COUNT(customer_id) AS customer_count,
    ROUND(
        COUNT(customer_id) * 100.0
        / (SELECT COUNT(DISTINCT customer_id)
           FROM subscriptions
           WHERE start_date <= '2020-12-31'),
        1
    ) AS percentage_of_customers
FROM latest_plan
WHERE rn = 1
GROUP BY plan_name
ORDER BY customer_count DESC;

-- output:-
| plan_name     | customer_count | percentage_of_customers |
| ------------- | -------------- | ----------------------- |
| pro monthly   | 326            | 32.6                    |
| churn         | 236            | 23.6                    |
| basic monthly | 224            | 22.4                    |
| pro annual    | 195            | 19.5                    |
| trial         | 19             | 1.9                     |
