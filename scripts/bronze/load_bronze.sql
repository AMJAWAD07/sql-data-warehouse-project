/*
===============================================================================
Load Bronze Layer (Source -> Bronze)
===============================================================================

Script Purpose:
      - Truncates the bronze tables before loading data.
      - load data from csv Files to bronze tables. 

Reason for not using a stored procedure:
The 'LOAD DATA LOCAL INFILE' statement is used here for bulk insertion of CSV data 
directly into the table. MySQL does not support using 'LOAD DATA' inside a stored 
procedure due to security and file access restrictions. This is why a procedure is not used here.
*/

use DataWarehouse;

/*
Disable strict SQL mode for the session and enable LOCAL INFILE globally to allow CSV import.
Strict SQL mode is disabled to prevent MySQL from rejecting or throwing errors on slightly malformed or incomplete data during import.
Caution: This makes the import more forgiving but can lead to bad/missing data silently.
Use it only if you understand the structure of your data or are doing quick testing (e.g., personal projects).
*/
set session sql_mode='';
set global local_infile = 1;


-- truncate and load data in crm_cust_info
truncate table bronze_crm_cust_info;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_info.csv'
into table bronze_crm_cust_info
fields terminated by ','
ignore 1 rows;

-- truncate and load data in crm_prd_info
truncate table bronze_crm_prd_info;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/prd_info.csv'
into table bronze_crm_prd_info
fields terminated by ','
ignore 1 rows;


-- truncate and load data in crm_sales_details
truncate table bronze_crm_sales_details;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_details.csv'
into table bronze_crm_sales_details
fields terminated by ','
ignore 1 rows;


-- truncate and load data in erp_loc_a101
truncate table bronze_erp_loc_a101;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LOC_A101.csv'
into table bronze_erp_loc_a101
fields terminated by ','
ignore 1 rows;

-- truncate and load data in erp_cust_az12
truncate table bronze_erp_cust_az12;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CUST_AZ12.csv'
into table bronze_erp_cust_az12
fields terminated by ','
ignore 1 rows;

-- truncate and load data in erp_px_cat_g1v2
truncate table bronze_erp_px_cat_g1v2;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PX_CAT_g1v2.csv'
into table bronze_erp_px_cat_g1v2
fields terminated by ','
ignore 1 rows;

