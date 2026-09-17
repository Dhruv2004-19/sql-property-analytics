-- Q6 – Lease Count and Average Rent per City
-- For each city, return:
--   - number_of_active_leases
--       Count of leases where lease_status is 'Active'.
--   - avg_monthly_rent_of_active_leases
--       Average monthly_rent across those active leases.
-- Only active leases should be considered.

SELECT 
    p.city,
    COUNT(*) AS number_of_active_leases,
    AVG(l.monthly_rent) AS avg_monthly_rent_of_active_leases
FROM properties AS p
JOIN units AS u 
    ON p.property_id = u.property_id
JOIN leases AS l 
    ON l.unit_id = u.unit_id 
WHERE l.lease_status = 'Active'
GROUP BY p.city;
