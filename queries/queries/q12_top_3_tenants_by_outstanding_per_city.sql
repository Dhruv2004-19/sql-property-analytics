-- Q12: Top 3 Tenants by Outstanding per City
-- For each city, return the top 3 tenants by total outstanding amount.
-- Outstanding is defined as the sum of invoice amounts where status is 'Open' or 'Partial'.
-- For each tenant, return:
--   - city
--   - tenant_name
--   - total_outstanding
--   - rank_in_city (1 = highest outstanding in that city)
-- Only the top 3 tenants per city should be included in the result.

WITH city_outstanding AS (
    SELECT 
        p.city,
        t.tenant_name,
        SUM(CASE 
            WHEN i.status IN ('Open', 'Partial') THEN i.amount  
            ELSE 0 
        END) AS total_outstanding
    FROM tenants AS t 
    JOIN leases AS l 
        ON t.tenant_id = l.tenant_id
    JOIN units AS u 
        ON l.unit_id = u.unit_id
    JOIN properties AS p 
        ON u.property_id = p.property_id
    JOIN invoice AS i 
        ON i.lease_id = l.lease_id
    GROUP BY p.city, t.tenant_name
)
SELECT 
    city,
    tenant_name,
    total_outstanding,
    rank_in_city 
FROM (
    SELECT 
        city,
        tenant_name,
        total_outstanding,     
        ROW_NUMBER() OVER (
            PARTITION BY city 
            ORDER BY total_outstanding DESC
        ) AS rank_in_city
    FROM city_outstanding
) AS ranked 
WHERE rank_in_city <= 3
ORDER BY city, rank_in_city;
