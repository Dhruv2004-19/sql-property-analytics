-- Q14: Properties with Below-Average Occupancy in Their City
-- For each property, return:
--   - property_name
--   - city
--   - total_units
--   - occupied_units
--   - occupancy_rate_pct
--       Percentage of units that are occupied.
--   - city_avg_occupancy_rate_pct
--       Average occupancy rate across all properties in the same city.
--   - below_city_avg
--       'Yes' if the property's occupancy rate is below the city average, otherwise 'No'.
-- Results should include all properties.

WITH property_occupancy AS (
    SELECT 
        p.property_name,
        p.city,
        p.total_units,
        COUNT(CASE WHEN u.statuss = 'Occupied' THEN 1 END) AS occupied_units,
        100.0 * COUNT(CASE WHEN u.statuss = 'Occupied' THEN 1 END) 
            / NULLIF(p.total_units, 0) AS occupancy_rate_pct
    FROM properties AS p  
    JOIN units AS u 
        ON p.property_id = u.property_id
    GROUP BY 
        p.property_name,
        p.city, 
        p.total_units
),
city_avg_rate AS (
    SELECT 
        city,
        AVG(occupancy_rate_pct) AS city_avg_occupancy_rate_pct
    FROM property_occupancy
    GROUP BY city     
)
SELECT 
    pa.property_name,
    pa.city,
    pa.total_units,
    pa.occupied_units,
    pa.occupancy_rate_pct,
    ca.city_avg_occupancy_rate_pct,
    CASE 
        WHEN pa.occupancy_rate_pct < ca.city_avg_occupancy_rate_pct THEN 'Yes'
        ELSE 'No'
    END AS below_city_avg
FROM property_occupancy AS pa 
JOIN city_avg_rate AS ca
    ON pa.city = ca.city
ORDER BY pa.city, pa.property_name;
