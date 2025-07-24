/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    Simulating schemas using table prefixes for bronze layer, dropping existing tables 
    if they already exist.
    e.g., bronze_customers
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/


-- Drop and Create bronze_crm_cust_info
drop table if exists bronze_crm_cust_info;

create table bronze_crm_cust_info (
    cst_id              int,
    cst_key             varchar(50),
    cst_firstname       varchar(50),
    cst_lastname        varchar(50),
    cst_marital_status  varchar(50),
    cst_gndr            varchar(50),
    cst_create_date     date
);


-- Drop and Create crm_prd_info
drop table if exists bronze_crm_prd_info;

create table bronze_crm_prd_info (
    prd_id       int,
    prd_key      varchar(50),
    prd_nm       varchar(50),
    prd_cost     int,
    prd_line     varchar(50),
    prd_start_dt datetime,
    prd_end_dt   datetime
);

-- Drop and Create bronze_crm_sales_details
drop table if exists bronze_crm_sales_details;

create table bronze_crm_sales_details (
    sls_ord_num  varchar(50),
    sls_prd_key  varchar(50),
    sls_cust_id  int,
    sls_order_dt int,
    sls_ship_dt  int,
    sls_due_dt   int,
    sls_sales    int,
    sls_quantity int,
    sls_price    int
);


-- Drop and Create erp_loc_a101
drop table if exists bronze_erp_loc_a101;

create table bronze_erp_loc_a101 (
    cid    varchar(50),
    cntry  varchar(50)
);


-- Drop and Create erp_cust_az12
drop table if exists bronze_erp_cust_az12;

create table bronze_erp_cust_az12 (
    cid    varchar(50),
    bdate  date,
    gen    varchar(50)
);

-- Drop and Create erp_px_cat_g1v2
drop table if exists bronze_erp_px_cat_g1v2;

create table bronze_erp_px_cat_g1v2 (
    id           varchar(50),
    cat          varchar(50),
    subcat       varchar(50),
    maintenance  varchar(50)
);
