-- 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

WITH ordered_plans AS (
    SELECT
        s.customer_id,
        p.plan_name,
        s.start_date,
        ROW_NUMBER() OVER (
            PARTITION BY s.customer_id 
            ORDER BY s.start_date
        ) AS plan_order
    FROM subscriptions s
    JOIN plans p
        ON s.plan_id = p.plan_id
)

SELECT
    COUNT(DISTINCT customer_id) AS churned_after_trial,
    ROUND(
        COUNT(DISTINCT customer_id) * 100.0
        / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions),
        0
    ) AS churn_percentage
FROM ordered_plans
WHERE plan_order = 2
  AND plan_name = 'churn'
  AND customer_id IN (
        SELECT customer_id
        FROM ordered_plans
        WHERE plan_order = 1
          AND plan_name = 'trial'
  );


-- output:-
churned_after_trial | churn_percentage
92                  | 9.00