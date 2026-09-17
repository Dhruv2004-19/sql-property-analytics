-- Q13: Running Total of Rent Collected per Property Over Time
-- For each property and each month, return:
--   - property_name
--   - city
--   - month_start (first day of the month, e.g., 2024-01-01)
--   - rent_collected_this_month
--       Sum of invoice amounts where invoice_type is 'Rent' and status is 'Paid'.
--   - running_total_collected
--       Cumulative sum of rent collected from the first month up to the current month for that property.
-- Results should be ordered by property and month.

WITH rent_collection_month AS (
    SELECT 
        p.property_name,
        p.city,
        DATE_FORMAT(i.invoice_date, '%Y-%m-01') AS month_start,
        SUM(CASE 
            WHEN i.invoice_type = 'Rent' AND i.status = 'Paid' 
            THEN i.amount 
            ELSE 0 
        END) AS rent_collected_this_month
    FROM properties AS p 
    JOIN units AS u 
        ON p.property_id = u.property_id
    JOIN leases AS l
        ON l.unit_id = u.unit_id
    JOIN invoice AS i 
        ON i.lease_id = l.lease_id
    GROUP BY 
        p.property_name,
        p.city,
        DATE_FORMAT(i.invoice_date, '%Y-%m-01')
)
SELECT 
    property_name,
    city,
    month_start,
    rent_collected_this_month,
    SUM(rent_collected_this_month) OVER (
        PARTITION BY property_name 
        ORDER BY month_start
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_collected
FROM rent_collection_month
ORDER BY property_name, month_start;
