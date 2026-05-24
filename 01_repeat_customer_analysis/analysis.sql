-- Identify repeat and one-time customers
WITH customer_segments AS (
    SELECT
        customer_id,
        CASE
            WHEN COUNT(order_id) >= 2 THEN 'repeat customer'
            ELSE 'one-time customer'
        END AS customer_type
    FROM orders
    GROUP BY customer_id
),

-- Enrich orders with product information and customer type
enriched_orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.product_id,
        p.product_name,
        o.amount,
        cs.customer_type
    FROM orders o
    JOIN customer_segments cs
        ON o.customer_id = cs.customer_id
    JOIN products p
        ON o.product_id = p.product_id
),

-- Keep only repeat customer transactions
repeat_orders AS (
    SELECT *
    FROM enriched_orders
    WHERE customer_type = 'repeat customer'
),

-- Aggregate revenue per product for repeat customers
product_revenue AS (
    SELECT
        product_id,
        product_name,
        SUM(amount) AS repeat_revenue
    FROM repeat_orders
    GROUP BY product_id, product_name
)

-- Rank products by repeat customer revenue
SELECT
    product_id,
    product_name,
    repeat_revenue,
    RANK() OVER (ORDER BY repeat_revenue DESC) AS revenue_rank
FROM product_revenue;
