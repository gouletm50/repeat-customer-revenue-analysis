-- Cash Flow vs Revenue Analysis
-- Monthly comparison of revenue vs cash inflow

WITH revenue_by_month AS (
	-- Revenue is recognized at order level (based on order date)
	SELECT
		d.month,
		SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct)) AS revenue
	FROM order_items oi
	JOIN orders o
		ON oi.order_id = o.order_id
	JOIN dim_date d
		ON DATE(o.order_date) = d.full_date
	GROUP BY d.month
),

cash_by_month AS (
	-- Cash flow is based on actual payment date (cash received)
	SELECT
		d.month,
		SUM(p.amount) AS cash_flow
	FROM payments p
	JOIN dim_date d
		ON DATE(p.payment_date) = d.full_date
	GROUP BY d.month
)

-- Align revenue and cash flow on the same monthly dimension
SELECT
	d.month,
	COALESCE(r.revenue, 0) AS revenue,
	COALESCE(c.cash_flow, 0) AS cash_flow
FROM dim_date d
LEFT JOIN revenue_by_month r
	ON d.month = r.month
LEFT JOIN cash_by_month c
	ON d.month = c.month
ORDER BY d.month;
