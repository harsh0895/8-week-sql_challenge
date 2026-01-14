-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT 
    s.customer_id,
    SUM(
        CASE
            WHEN m.product_name = 'sushi' THEN m.price * 20
            ELSE m.price * 10
        END
    ) AS product_price
FROM sales s
INNER JOIN menu m
    ON s.product_id = m.product_id
GROUP BY s.customer_id;

-- output:-
| customer_id | product_price |
| ----------- | ------------- |
| A           | 860           |
| B           | 940           |
| C           | 360           |

