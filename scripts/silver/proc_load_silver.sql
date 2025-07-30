/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    call load_silver();
===============================================================================
*/


drop procedure if exists load_silver;
delimiter $$

create procedure load_silver()
begin
        /*
    Disable strict SQL mode for the session.
    Strict SQL mode is disabled to prevent MySQL from rejecting or throwing errors on slightly malformed or incomplete data during import.
    Caution: This makes the import more forgiving but can lead to bad/missing data silently.
    Use it only if you understand the structure of your data or are doing quick testing (e.g., personal projects).
    */
    	set session sql_mode = '';

	
    	-- Load crm_cust_info
    
    	truncate table silver_crm_cust_info;
    

    	insert into silver_crm_cust_info (
	      cst_id, cst_key, cst_firstname, cst_lastname, 
	      cst_marital_status, cst_gndr, cst_create_date
	  )
	select
		cst_id,
		cst_key,
		trim(cst_firstname),
		trim(cst_lastname),
		case 
			when UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			when UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			else 'n/a'
		end,
		CASE 
			WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			ELSE 'n/a'
		END,
		cst_create_date
	FROM (
		SELECT 
			*,
			ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
		FROM bronze_crm_cust_info
		WHERE cst_id IS NOT NULL
	) AS ranked
	WHERE flag_last = 1;


	   

	-- Load crm_prd_info
   
	truncate table silver_crm_prd_info;
	

	INSERT INTO silver_crm_prd_info (
	prd_id, cat_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt
	)
	SELECT
		prd_id,
		REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_'),
		SUBSTRING(prd_key, 7),
		prd_nm,
		IFNULL(prd_cost, 0),
		CASE 
			WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
			WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
			WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
			WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
			ELSE 'n/a'
		END,
		prd_start_dt,
		CAST(
				DATE_SUB(
					LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt),
					INTERVAL 1 DAY
				) AS DATE
			  ) AS prd_end_dt
	FROM bronze_crm_prd_info;

		

	-- Load crm_sales_details
		
	truncate table silver_crm_sales_details;


	insert into silver_crm_sales_details (
	sls_ord_num, sls_prd_key, sls_cust_id,
	sls_order_dt, sls_ship_dt, sls_due_dt,
	sls_sales, sls_quantity, sls_price
	)
	select
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		if(char_length(sls_order_dt) != 8 or sls_order_dt = 0, null, str_to_date(sls_order_dt, '%Y%m%d')),
		if(char_length(sls_ship_dt) != 8 or sls_ship_dt = 0, null, str_to_date(sls_ship_dt, '%Y%m%d')),
		if(char_length(sls_due_dt) != 8 or sls_due_dt = 0, null, str_to_date(sls_due_dt, '%Y%m%d')),
		case 
			when sls_sales is null or sls_sales <= 0 or sls_sales = '0' or sls_sales != sls_quantity * abs(sls_price) then sls_quantity * abs(sls_price)
			else sls_sales
		end,
		sls_quantity,
		case 
			when sls_price is null or sls_price <= 0 then ifnull(sls_sales / nullif(sls_quantity, 0), 0)
			else sls_price
		end
	from bronze_crm_sales_details;

	   

	-- Load erp_cust_az12
   
	truncate table silver_erp_cust_az12;
   

	insert into silver_erp_cust_az12 (
		cid, bdate, gen
	)
	select
		if(left(cid, 3) = 'NAS', substring(cid, 4), cid),
		if(bdate > now(), null, bdate),
		case
			when upper(trim(replace(replace(replace(gen, '\r', ''), '\n', ''), ' ', ''))) in ('M', 'MALE') then 'Male'
			when upper(trim(replace(replace(replace(gen, '\r', ''), '\n', ''), ' ', ''))) in ('F', 'FEMALE') then 'Female'
			else 'n/a'
		end
	from bronze_erp_cust_az12;

	

	-- Load erp_loc_a101
  
	truncate table silver_erp_loc_a101;
	

	insert into silver_erp_loc_a101 (
		cid, cntry
	)
	select
		replace(cid, '-', ''),
		case
			when trim(cntry) = 'DE' then 'Germany'
			when trim(cntry) in ('US', 'USA') then 'United States'
			when trim(cntry) = '' or cntry is null then 'n/a'
			else trim(cntry)
		end
	from bronze_erp_loc_a101;

		

	-- Load erp_px_cat_g1v2
   
	truncate table silver_erp_px_cat_g1v2;
 

	insert into silver_erp_px_cat_g1v2 (
		id, cat, subcat, maintenance
	)
	select id, cat, subcat, maintenance
	from bronze_erp_px_cat_g1v2;

end$$

delimiter ;
		
