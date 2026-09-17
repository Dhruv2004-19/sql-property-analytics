-- Q4 – Rent Billed vs Collected per Property
-- For each property, return:
--   - property_name
--   - city
--   - total_rent_billed
--       Total amount invoiced for Rent (all statuses).
--   - total_rent_collected
--       Total amount invoiced for Rent where status is 'Paid'.
-- Results should be grouped by property.

SELECT 
    p.property_name,
    p.city,
    SUM(CASE 
        WHEN i.invoice_type = 'Rent' THEN i.amount 
        ELSE 0 
    END) AS total_rent_billed,
    SUM(CASE 
        WHEN i.invoice_type = 'Rent' AND i.status = 'Paid' THEN i.amount 
        ELSE 0 
    END) AS total_rent_collected
FROM properties AS p 
JOIN units AS u 
    ON p.property_id = u.property_id      
JOIN leases AS l 
    ON l.unit_id = u.unit_id 
JOIN invoice AS i 
    ON i.lease_id = l.lease_id 
GROUP BY 
    p.property_name,
    p.city;
