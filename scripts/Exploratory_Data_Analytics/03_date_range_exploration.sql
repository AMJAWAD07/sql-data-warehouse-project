/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months
select 
    min(order_date) as first_order_date,
    max(order_date) as last_order_date,
    timestampdiff(month, min(order_date), max(order_date)) as order_range_months
from gold_fact_sales;


-- Find the youngest and oldest customer based on birthdate
select
    MIN(birthdate) AS oldest_birthdate,
    timestampdiff(year, MIN(birthdate), now()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    timestampdiff(year, MAX(birthdate), now()) AS youngest_age
FROM gold_dim_customers;
