-- Q15: Tenants with More Than 3 Overdue Invoices
-- Return tenants who have more than 3 overdue invoices.
-- An invoice is considered overdue if:
--   - status is 'Open' or 'Partial'
--   - due_date is in the past.
-- For each such tenant, return:
--   - tenant_name
--   - city
--   - num_overdue_invoices
--   - total_overdue_amount
-- Only tenants with more than 3 overdue invoices should be included.

SELECT 
    t.tenant_name,
    p.city,
    COUNT(i.invoice_id) AS num_overdue_invoices,
    SUM(i.amount) AS total_overdue_amount
FROM tenants AS t 
JOIN leases AS l 
    ON t.tenant_id = l.tenant_id
JOIN units AS u 
    ON l.unit_id = u.unit_id
JOIN properties AS p 
    ON u.property_id = p.property_id
JOIN invoice AS i 
    ON l.lease_id = i.lease_id
WHERE i.status IN ('Open', 'Partial')
  AND i.due_date < CURDATE()
GROUP BY 
    t.tenant_id,
    t.tenant_name,
    p.city
HAVING COUNT(*) > 3
ORDER BY num_overdue_invoices DESC;
