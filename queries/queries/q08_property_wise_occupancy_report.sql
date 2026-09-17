-- Q8 – Property-wise Occupancy Report (with Occupancy %)
-- For each property, return:
--   - property_name
--   - city
--   - total_units
--   - occupied_units
--       Count of units where status is 'Occupied'.
--   - vacant_units
--       Count of units where status is 'Available'.
--   - occupancy_rate_pct
--       Percentage of units that are occupied.
-- Results should be grouped by property.

SELECT 
    p.property_name,
    p.city,
    p.total_units AS total_units,        
    COUNT(CASE WHEN u.statuss = 'Occupied' THEN 1 END) AS occupied_units,
    COUNT(CASE WHEN u.statuss = 'Available' THEN 1 END) AS vacant_units,
    100.0 * COUNT(CASE WHEN u.statuss = 'Occupied' THEN 1 END) 
        / NULLIF(p.total_units, 0) AS occupancy_rate_pct    
FROM properties AS p
JOIN units AS u
    ON p.property_id = u.property_id
GROUP BY 
    p.property_name,
    p.city,
    p.total_units;
