/*
===============================================================================
ETL Script: Load ERP Data (Bronze Layer)
===============================================================================
Script Purpose:
    This script loads ERP source data from CSV files into Bronze layer tables.

    Source Files:
        - CUST_AZ12.csv
        - LOC_A101.csv
        - PX_CAT_G1V2.csv

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
-- LOAD ERP LOCATION DATA
-- ============================================================================

TRUNCATE TABLE bronze.erp_loc_a101;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LOC_A101.csv'
INTO TABLE bronze.erp_loc_a101
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
 @cid,
 @cntry
)
SET
 cid   = NULLIF(@cid,''),
 cntry = NULLIF(@cntry,'');

-- ============================================================================
-- LOAD ERP CUSTOMER DATA
-- ============================================================================

TRUNCATE TABLE bronze.erp_cust_az12;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CUST_AZ12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
 @cid,
 @bdate,
 @gen
)
SET
 cid   = NULLIF(@cid,''),
 bdate = NULLIF(@bdate,''),
 gen   = NULLIF(@gen,'');

-- ============================================================================
-- LOAD ERP PRODUCT CATEGORY DATA
-- ============================================================================

TRUNCATE TABLE bronze.erp_px_cat_g1v2;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PX_CAT_G1V2.csv'
INTO TABLE bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
 @id,
 @cat,
 @subcat,
 @maintenance
)
SET
 id          = NULLIF(@id,''),
 cat         = NULLIF(@cat,''),
 subcat      = NULLIF(@subcat,''),
 maintenance = NULLIF(@maintenance,'');

-- ============================================================================
-- LOAD VALIDATION
-- ============================================================================

SELECT 'erp_loc_a101' AS table_name, COUNT(*) AS row_count
FROM bronze.erp_loc_a101

UNION ALL

SELECT 'erp_cust_az12', COUNT(*)
FROM bronze.erp_cust_az12

UNION ALL

SELECT 'erp_px_cat_g1v2', COUNT(*)
FROM bronze.erp_px_cat_g1v2;
