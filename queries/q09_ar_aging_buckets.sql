-- Q9: AR Aging Buckets
-- Buckets: '0-30 Days', '31-60 Days', '61-90 Days', '90+ Days'
-- Fields: days_group, number_of_invoices, total_outstanding_amount
-- Filters: status IN ('Open', 'Partial') AND due_date < CURDATE()

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
