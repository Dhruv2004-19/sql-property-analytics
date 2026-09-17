-- Q2 – Property-wise Unit Count
-- For each property, return:
--   - property_name
--   - city
--   - total_units
--       Count of units belonging to the property.
-- This gives a high-level view of portfolio size per property.

SELECT 
    p.property_name,
    p.city,
    COUNT(u.unit_id) AS total_units
FROM properties AS p 
JOIN units AS u 
    ON p.property_id = u.property_id
GROUP BY 
    p.property_name,
    p.city;
