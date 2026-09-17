-- Q9: AR Aging Buckets
-- Return outstanding invoices grouped by how many days they are overdue.
-- Use the following buckets:
--   - '0-30 Days'
--   - '31-60 Days'
--   - '61-90 Days'
--   - '90+ Days'
-- For each bucket, return:
--   - days_group
--   - number_of_invoices
--   - total_outstanding_amount
-- Consider only invoices where:
--   - status is 'Open' or 'Partial'
--   - due_date is in the past.

SELECT 
    CASE
        WHEN DATEDIFF(CURDATE(), due_date) <= 30 THEN '0-30 Days'
        WHEN DATEDIFF(CURDATE(), due_date) <= 60 THEN '31-60 Days' 
        WHEN DATEDIFF(CURDATE(), due_date) <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END AS days_group,
    COUNT(invoice_id) AS number_of_invoices,
    SUM(amount) AS total_outstanding_amount
FROM invoice
WHERE status IN ('Open', 'Partial')
  AND due_date < CURDATE()
GROUP BY 
    CASE
        WHEN DATEDIFF(CURDATE(), due_date) <= 30 THEN '0-30 Days'
        WHEN DATEDIFF(CURDATE(), due_date) <= 60 THEN '31-60 Days' 
        WHEN DATEDIFF(CURDATE(), due_date) <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END
ORDER BY days_group;
