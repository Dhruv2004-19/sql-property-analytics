# SQL Property Analytics

A collection of 15 intermediate SQL queries for a property management analytics scenario.  
This project demonstrates joins, aggregations, CTEs, window functions, and time-based logic on a realistic schema.

## Overview

This repository contains analytical queries for a property rental business. The queries cover:

- Property and unit overview
- Occupancy analysis
- Rent billing, collection, and outstanding amounts
- AR aging buckets
- Monthly revenue with YoY growth
- Lease expiry forecasting
- Tenant-level risk analysis (overdue invoices)

All queries are written for MySQL-compatible syntax (e.g., `DATE_FORMAT`, `DATEDIFF`, `CURDATE()`).

## Schema

The queries assume the following tables:

- `properties`
  - `property_id`, `property_name`, `city`, `total_units`, …
- `units`
  - `unit_id`, `property_id`, `unit_number`, `unit_type`, `statuss`, …
- `leases`
  - `lease_id`, `unit_id`, `tenant_id`, `lease_status`, `monthly_rent`, `lease_start_date`, `lease_end_date`, …
- `tenants`
  - `tenant_id`, `tenant_name`, …
- `invoice` (or `inovie` in your DB)
  - `invoice_id`, `lease_id`, `invoice_type`, `amount`, `status`, `invoice_date`, `due_date`, …

Relationships:

- `properties` → `units` (one-to-many via `property_id`)
- `units` → `leases` (one-to-many via `unit_id`)
- `leases` → `tenants` (many-to-one via `tenant_id`)
- `leases` → `invoice` (one-to-many via `lease_id`)

## Queries

All queries are in the `queries/` folder.

**Q1: Property and Unit Overview**  
For each unit, return basic property and unit details: property_name, city, unit_number, unit_type, unit_status.

**Q2: Property-wise Unit Count**  
For each property, return property_name, city, and total_units (count of units belonging to the property).

**Q3: Active Leases with Tenant and Unit Info**  
For each active lease, return property_name, unit_number, tenant_name, lease_status, and monthly_rent. Only include leases where lease_status is 'Active'.

**Q4: Rent Billed vs Collected per Property**  
For each property, return property_name, city, total_rent_billed (all Rent invoices), and total_rent_collected (Rent invoices with status = 'Paid').

**Q5: Outstanding Amount per Property**  
For each property, return property_name, city, and total_outstanding_amount (sum of invoice amounts where status is 'Open' or 'Partial').

**Q6: Lease Count and Average Rent per City**  
For each city, return number_of_active_leases and avg_monthly_rent_of_active_leases. Only active leases are considered.

**Q7: Rent Roll (Unit-wise with Billed, Collected, Outstanding)**  
For each unit that has an active lease, return property_name, city, unit_number, tenant_name, lease_status, monthly_rent, total_rent_billed, total_rent_collected, and total_outstanding.

**Q8: Property-wise Occupancy Report**  
For each property, return property_name, city, total_units, occupied_units, vacant_units, and occupancy_rate_pct (percentage of units that are occupied).

**Q9: AR Aging Buckets**  
Return outstanding invoices grouped into buckets: '0-30 Days', '31-60 Days', '61-90 Days', '90+ Days'. For each bucket, show days_group, number_of_invoices, and total_outstanding_amount.

**Q10: Monthly Rent Revenue with YoY Growth**  
For each month, return month_start, total_rent_revenue, revenue_same_month_last_year, and yoy_growth_pct (year-over-year growth percentage).

**Q11: Lease Expiry Forecast (Next 12 Months)**  
For each month in the next 12 months, return expiry_month, number_of_leases_expiring, and total_monthly_rent_expiring. Only active leases ending within the next 12 months are considered.

**Q12: Top 3 Tenants by Outstanding per City**  
For each city, return the top 3 tenants by total outstanding amount, with columns: city, tenant_name, total_outstanding, and rank_in_city (1 = highest outstanding in that city).

**Q13: Running Total of Rent Collected per Property Over Time**  
For each property and each month, return property_name, city, month_start, rent_collected_this_month, and running_total_collected (cumulative sum of rent collected over time for that property).

**Q14: Properties with Below-Average Occupancy in Their City**  
For each property, return property_name, city, total_units, occupied_units, occupancy_rate_pct, city_avg_occupancy_rate_pct, and below_city_avg ('Yes' if the property's occupancy is below the city average, otherwise 'No').

**Q15: Tenants with More Than 3 Overdue Invoices**  
Return tenants who have more than 3 overdue invoices. For each such tenant, return tenant_name, city, num_overdue_invoices, and total_overdue_amount. An invoice is overdue if status is 'Open' or 'Partial' and due_date is in the past.

## How to Run

1. Clone or download this repository.
2. Connect to your MySQL-compatible database that has the schema described above.
3. Open any `.sql` file from the `queries/` folder.
4. Run the query in your SQL client (MySQL CLI, MySQL Workbench, DBeaver, etc.).

Adjust table/column names if your schema differs slightly (e.g., `status` vs `statuss`, `invoice` vs `inovie`).

## Skills Demonstrated

- Multi-table joins
- Conditional aggregation with `CASE`
- CTEs (`WITH` clauses)
- Window functions (`ROW_NUMBER()`, `LAG()`, running totals)
- Date functions and time-based analysis
- Grouping and filtering with `HAVING`

## License

This project is for learning and portfolio purposes. Feel free to reuse and adapt the queries.
