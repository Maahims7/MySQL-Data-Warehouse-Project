/*
===============================================================================
ETL Script: Load CRM Data (Bronze Layer)
===============================================================================
Script Purpose:
    This script loads CRM source data from CSV files into Bronze layer tables.

    Source Files:
        - cust_info.csv
        - prd_info.csv
        - sales_details.csv

Notes:
    - Files must be placed in the MySQL Uploads directory.
    - Empty values are converted to NULL.
    - Existing data is truncated before loading.

Author: Mahendra
Project: MySQL Data Warehouse Project
===============================================================================
*/

USE data_warehouse;

-- ============================================================================
-- LOAD CRM CUSTOMER INFORMATION
-- ============================================================================

TRUNCATE TABLE bronze.crm_cust_info;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_info.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
 @cst_id,
 @cst_key,
 @cst_firstname,
 @cst_lastname,
 @cst_marital_status,
 @cst_gndr,
 @cst_create_date
)
SET
 cst_id             = NULLIF(@cst_id,''),
 cst_key            = NULLIF(@cst_key,''),
 cst_firstname      = NULLIF(@cst_firstname,''),
 cst_lastname       = NULLIF(@cst_lastname,''),
 cst_marital_status = NULLIF(@cst_marital_status,''),
 cst_gndr           = NULLIF(@cst_gndr,''),
 cst_create_date    = NULLIF(@cst_create_date,'');

-- ============================================================================
-- LOAD CRM PRODUCT INFORMATION
-- ============================================================================

TRUNCATE TABLE bronze.crm_prd_info;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/prd_info.csv'
INTO TABLE bronze.crm_prd_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
 @prd_id,
 @prd_key,
 @prd_nm,
 @prd_cost,
 @prd_line,
 @prd_start_dt,
 @prd_end_dt
)
SET
 prd_id       = NULLIF(@prd_id,''),
 prd_key      = NULLIF(@prd_key,''),
 prd_nm       = NULLIF(@prd_nm,''),
 prd_cost     = NULLIF(@prd_cost,''),
 prd_line     = NULLIF(@prd_line,''),
 prd_start_dt = NULLIF(@prd_start_dt,''),
 prd_end_dt   = NULLIF(@prd_end_dt,'');

-- ============================================================================
-- LOAD CRM SALES DETAILS
-- ============================================================================

TRUNCATE TABLE bronze.crm_sales_details;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_details.csv'
INTO TABLE bronze.crm_sales_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
 @sls_ord_num,
 @sls_prd_key,
 @sls_cust_id,
 @sls_order_dt,
 @sls_ship_dt,
 @sls_due_dt,
 @sls_sales,
 @sls_quantity,
 @sls_price
)
SET
 sls_ord_num  = NULLIF(@sls_ord_num,''),
 sls_prd_key  = NULLIF(@sls_prd_key,''),
 sls_cust_id  = NULLIF(@sls_cust_id,''),
 sls_order_dt = NULLIF(@sls_order_dt,''),
 sls_ship_dt  = NULLIF(@sls_ship_dt,''),
 sls_due_dt   = NULLIF(@sls_due_dt,''),
 sls_sales    = NULLIF(@sls_sales,''),
 sls_quantity = NULLIF(@sls_quantity,''),
 sls_price    = NULLIF(@sls_price,'');

-- ============================================================================
-- LOAD VALIDATION
-- ============================================================================

SELECT 'crm_cust_info' AS table_name, COUNT(*) AS row_count
FROM bronze.crm_cust_info

UNION ALL

SELECT 'crm_prd_info', COUNT(*)
FROM bronze.crm_prd_info

UNION ALL

SELECT 'crm_sales_details', COUNT(*)
FROM bronze.crm_sales_details;
