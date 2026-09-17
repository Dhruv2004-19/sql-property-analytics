-- Q7 – Rent Roll (Unit-wise with Billed, Collected, Outstanding)
-- For each unit that has an active lease, return:
--   - property_name
--   - city
--   - unit_number
--   - tenant_name
--   - lease_status
--   - monthly_rent
--   - total_rent_billed
--       Sum of invoice amounts where invoice_type is 'Rent'.
--   - total_rent_collected
--       Sum of invoice amounts where invoice_type is 'Rent' and status is 'Paid'.
--   - total_outstanding
--       Sum of invoice amounts where status is 'Open' or 'Partial'.
-- Only include units with active leases.

SELECT 
    p.property_name,
    p.city,
    u.unit_number,
    t.tenant_name,
    l.lease_status,
    l.monthly_rent,
    SUM(CASE 
        WHEN i.invoice_type = 'Rent' THEN i.amount 
        ELSE 0  
    END) AS total_rent_billed,
    SUM(CASE 
        WHEN i.invoice_type = 'Rent' AND i.status = 'Paid' THEN i.amount 
        ELSE 0  
    END) AS total_rent_collected,
    SUM(CASE
        WHEN i.status IN ('Open', 'Partial') THEN i.amount 
        ELSE 0 
    END) AS total_outstanding
FROM properties AS p 
JOIN units AS u 
    ON p.property_id = u.property_id
JOIN leases AS l 
    ON l.unit_id = u.unit_id
JOIN tenants AS t 
    ON t.tenant_id = l.tenant_id
JOIN invoice AS i 
    ON i.lease_id = l.lease_id
WHERE l.lease_status = 'Active'
GROUP BY 
    p.property_name,
    p.city,
    u.unit_number,
    t.tenant_name,
    l.lease_status,
    l.monthly_rent;
