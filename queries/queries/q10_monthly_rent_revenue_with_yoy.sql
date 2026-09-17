-- Q10: Monthly Rent Revenue with YoY Growth
-- For each month, return:
--   - month_start (first day of the month, e.g., 2024-01-01)
--   - total_rent_revenue
--       Sum of invoice amounts where invoice_type is 'Rent' and status is not 'Cancelled'.
--   - revenue_same_month_last_year
--       Total rent revenue for the same month in the previous year.
--   - yoy_growth_pct
--       Year-over-year growth percentage compared to the same month last year.
-- Results should be ordered chronologically by month_start.

WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(invoice_date, '%Y-%m-01') AS month_start,
        SUM(amount) AS total_rent_revenue
    FROM invoice 
    WHERE invoice_type = 'Rent' 
      AND status <> 'Cancelled'
    GROUP BY DATE_FORMAT(invoice_date, '%Y-%m-01')
),
revenue_with_lag AS (
    SELECT 
        month_start,
        total_rent_revenue,
        LAG(total_rent_revenue, 12) OVER (
            ORDER BY month_start
        ) AS revenue_same_month_last_year
    FROM monthly_revenue
)
SELECT 
    month_start,
    total_rent_revenue,
    revenue_same_month_last_year,
    ROUND(
        (total_rent_revenue - revenue_same_month_last_year) 
        / NULLIF(revenue_same_month_last_year, 0) * 100,
        2
    ) AS yoy_growth_pct
FROM revenue_with_lag
ORDER BY month_start;
