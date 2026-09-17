-- Q11: Lease Expiry Forecast (Next 12 Months)
-- For each month in the next 12 months, return:
--   - expiry_month (first day of the month, e.g., 2026-10-01)
--   - number_of_leases_expiring
--   - total_monthly_rent_expiring
-- Consider only leases where:
--   - lease_status is 'Active'
--   - lease_end_date falls within the next 12 months from today.
-- Results should be ordered by expiry_month.

SELECT 
    DATE_FORMAT(lease_end_date, '%Y-%m-01') AS expiry_month,
    COUNT(lease_id) AS number_of_leases_expiring,
    SUM(monthly_rent) AS total_monthly_rent_expiring
FROM leases
WHERE lease_status = 'Active'
  AND lease_end_date BETWEEN CURDATE() 
                         AND DATE_ADD(CURDATE(), INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(lease_end_date, '%Y-%m-01')
ORDER BY expiry_month;
