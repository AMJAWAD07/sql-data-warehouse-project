/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/


-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    select 
        date_format(order_date, '%Y-01-01') as order_date,
        sum(sales_amount) as total_sales,
        avg(price) as avg_price
    from gold_fact_sales
    where order_date is not null
    group by date_format(order_date, '%Y-01-01')
) t;
