/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions
select
    year(order_date) as order_year,
    month(order_date) as order_month,
    sum(sales_amount) as total_sales,
    count(distinct customer_key) as total_customers,
    sum(quantity) as total_quantity
from gold_fact_sales
where order_date is not null
group by year(order_date), month(order_date)
order by year(order_date), month(order_date);

-- DATETRUNC()
select
    date_format(order_date, '%Y-%m-01') as order_date,
    sum(sales_amount) as total_sales,
    count(distinct customer_key) as total_customers,
    sum(quantity) as total_quantity
from gold_fact_sales
where order_date is not null
group by date_format(order_date, '%Y-%m-01')
order by date_format(order_date, '%Y-%m-01');

-- FORMAT()
select
    date_format(order_date, '%Y-%b') as order_date,
    sum(sales_amount) as total_sales,
    count(distinct customer_key) as total_customers,
    sum(quantity) as total_quantity
from gold_fact_sales
where order_date is not null
group by date_format(order_date, '%Y-%b')
order by date_format(order_date, '%Y-%b');

