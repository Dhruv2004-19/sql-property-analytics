-- Q1: Property and Unit Overview
-- For each unit, return basic property and unit details:
--   - property_name
--   - city
--   - unit_number
--   - unit_type
--   - unit_status
-- This provides a simple list of all units with their associated property information.

SELECT 
    p.property_name,
    p.city,
    u.unit_number,
    u.unit_type,
    u.statuss
FROM properties AS p 
JOIN units AS u 
    ON p.property_id = u.property_id;
