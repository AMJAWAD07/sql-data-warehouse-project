/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the Total Sales
select sum(sales_amount) as total_sales from gold_fact_sales;

-- Find how many items are sold
select sum(quantity) as total_quantity from gold_fact_sales;

-- Find the average selling price
select avg(price) as avg_price from gold_fact_sales;

-- Find the Total number of Orders
select count(order_number) as total_orders from gold_fact_sales;
select count(distinct order_number) as total_orders from gold_fact_sales;

-- Find the total number of products
select count(product_name) as total_products from gold_dim_products;

-- Find the total number of customers
select count(customer_key) as total_customers from gold_dim_customers;

-- Find the total number of customers that has placed an order
select count(distinct customer_key) as total_customers from gold_fact_sales;

-- Generate a Report that shows all key metrics of the business
select 'Total Sales' as measure_name, sum(sales_amount) as measure_value from gold_fact_sales
union all
select 'Total Quantity', sum(quantity) from gold_fact_sales
union all
select 'Average Price', avg(price) from gold_fact_sales
union all
select 'Total Orders', count(distinct order_number) from gold_fact_sales
union all
select 'Total Products', count(distinct product_name) from gold_dim_products
union all
select 'Total Customers', count(customer_key) from gold_dim_customers;
