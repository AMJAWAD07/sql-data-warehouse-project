/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    Simulating schemas using table prefixes for silver layer, dropping existing tables 
    if they already exist.
    e.g., silver_customers
	  Run this script to re-define the DDL structure of 'silver' Tables
===============================================================================
*/


-- Drop and create 'silver_crm_cust_info'
use DataWarehouse;
drop table if exists silver_crm_cust_info;

create table silver_crm_cust_info (
    cst_id             int,
    cst_key            varchar(50),
    cst_firstname      varchar(50),
    cst_lastname       varchar(50),
    cst_marital_status varchar(50),
    cst_gndr           varchar(50),
    cst_create_date    date,
    dwh_create_date    datetime default current_timestamp
);

-- Drop and create 'silver_crm_prd_info'
drop table if exists silver_crm_prd_info;

create table silver_crm_prd_info (
    prd_id          int,
    cat_id          varchar(50),
    prd_key         varchar(50),
    prd_nm          varchar(50),
    prd_cost        int,
    prd_line        varchar(50),
    prd_start_dt    date,
    prd_end_dt      date,
    dwh_create_date datetime default current_timestamp
);

-- Drop and create 'silver_crm_sales_details'
drop table if exists silver_crm_sales_details;

create table silver_crm_sales_details (
    sls_ord_num     varchar(50),
    sls_prd_key     varchar(50),
    sls_cust_id     int,
    sls_order_dt    date,
    sls_ship_dt     date,
    sls_due_dt      date,
    sls_sales       int,
    sls_quantity    int,
    sls_price       int,
    dwh_create_date datetime default current_timestamp
);

-- Drop and create 'silver_erp_loc_a101'
drop table if exists silver_erp_loc_a101;

create table silver_erp_loc_a101 (
    cid             varchar(50),
    cntry           varchar(50),
    dwh_create_date datetime default current_timestamp
);

-- Drop and create 'silver_erp_cust_az12'
drop table if exists silver_erp_cust_az12;

create table silver_erp_cust_az12 (
    cid             varchar(50),
    bdate           date,
    gen             varchar(50),
    dwh_create_date datetime default current_timestamp
);

-- Drop and create 'silver_erp_px_cat_g1v2'
drop table if exists silver_erp_px_cat_g1v2;

create table silver_erp_px_cat_g1v2 (
    id              varchar(50),
    cat             varchar(50),
    subcat          varchar(50),
    maintenance     varchar(50),
    dwh_create_date datetime default current_timestamp
);
