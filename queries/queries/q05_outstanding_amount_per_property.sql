-- Q5 – Outstanding Amount per Property
-- For each property, return:
--   - property_name
--   - city
--   - total_outstanding_amount
--       Sum of invoice amounts where status is 'Open' or 'Partial'.
-- Results should be grouped by property.

SELECT 
    p.property_name,     
    p.city,
    SUM(CASE  
        WHEN i.status IN ('Open', 'Partial') THEN i.amount 
        ELSE 0
    END) AS total_outstanding_amount
FROM properties AS p 
JOIN units AS u 
    ON p.property_id = u.property_id
JOIN leases AS l 
    ON u.unit_id = l.unit_id 
JOIN invoice AS i
    ON i.lease_id = l.lease_id
GROUP BY 
    p.property_name,
    p.city;
