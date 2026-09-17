-- Q3 – Active Leases with Tenant and Unit Info
-- For each active lease, return:
--   - property_name
--   - unit_number
--   - tenant_name
--   - lease_status
--   - monthly_rent
-- Only include leases where lease_status is 'Active'.

SELECT  
    p.property_name,
    u.unit_number,
    t.tenant_name,
    l.lease_status,
    l.monthly_rent
FROM properties AS p
JOIN units AS u 
    ON p.property_id = u.property_id
JOIN leases AS l 
    ON l.unit_id = u.unit_id
JOIN tenants AS t 
    ON t.tenant_id = l.tenant_id
WHERE l.lease_status = 'Active';
