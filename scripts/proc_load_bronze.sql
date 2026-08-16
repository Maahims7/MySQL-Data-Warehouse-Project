/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze) - MySQL version
===============================================================================
Script Purpose:
    Loads data into the 'bronze' database from CSV files using
    LOAD DATA LOCAL INFILE (MySQL's equivalent of SQL Server's BULK INSERT).

    IMPORTANT - before running this in DBeaver:
    1) Update the six file paths below to point to the CSV files on YOUR
       machine (the ones in /datasets/source_crm and /datasets/source_erp).
       Use forward slashes even on Windows, e.g. 'C:/dwh_project/datasets/...'.
    2) The MySQL server must have local_infile enabled:
           SET GLOBAL local_infile = 1;
    3) In DBeaver, edit the connection's Driver Properties and set
       allowLoadLocalInfile = true (see README for details).

Usage Example:
    CALL bronze.load_bronze();
===============================================================================
*/

USE bronze;

DELIMITER $$

DROP PROCEDURE IF EXISTS load_bronze $$

CREATE PROCEDURE load_bronze()
proc_body: BEGIN
    DECLARE start_time     DATETIME;
    DECLARE end_time       DATETIME;
    DECLARE batch_start    DATETIME;
    DECLARE batch_end      DATETIME;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT '==========================================' AS message;
        SELECT 'ERROR OCCURRED DURING LOADING BRONZE LAYER' AS message;
        RESIGNAL;
    END;

    SET batch_start = NOW();
    SELECT '================================================' AS message;
    SELECT 'Loading Bronze Layer' AS message;
    SELECT '================================================' AS message;

    SELECT '------------------------------------------------' AS message;
    SELECT 'Loading CRM Tables' AS message;
    SELECT '------------------------------------------------' AS message;

    -- crm_cust_info
    SET start_time = NOW();
    TRUNCATE TABLE crm_cust_info;
    LOAD DATA LOCAL INFILE 'D:/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
        INTO TABLE crm_cust_info
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> crm_cust_info load duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS message;

    -- crm_prd_info
    SET start_time = NOW();
    TRUNCATE TABLE crm_prd_info;
    LOAD DATA LOCAL INFILE 'D:/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
        INTO TABLE crm_prd_info
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> crm_prd_info load duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS message;

    -- crm_sales_details
    SET start_time = NOW();
    TRUNCATE TABLE crm_sales_details;
    LOAD DATA LOCAL INFILE 'D:/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
        INTO TABLE crm_sales_details
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> crm_sales_details load duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS message;

    SELECT '------------------------------------------------' AS message;
    SELECT 'Loading ERP Tables' AS message;
    SELECT '------------------------------------------------' AS message;

    -- erp_loc_a101
    SET start_time = NOW();
    TRUNCATE TABLE erp_loc_a101;
    LOAD DATA LOCAL INFILE 'D:/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
        INTO TABLE erp_loc_a101
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> erp_loc_a101 load duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS message;

    -- erp_cust_az12
    SET start_time = NOW();
    TRUNCATE TABLE erp_cust_az12;
    LOAD DATA LOCAL INFILE 'D:/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
        INTO TABLE erp_cust_az12
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> erp_cust_az12 load duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS message;

    -- erp_px_cat_g1v2
    SET start_time = NOW();
    TRUNCATE TABLE erp_px_cat_g1v2;
    LOAD DATA LOCAL INFILE 'D:/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
        INTO TABLE erp_px_cat_g1v2
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> erp_px_cat_g1v2 load duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS message;

    SET batch_end = NOW();
    SELECT '==========================================' AS message;
    SELECT 'Loading Bronze Layer is Completed' AS message;
    SELECT CONCAT('   - Total Load Duration: ', TIMESTAMPDIFF(SECOND, batch_start, batch_end), ' seconds') AS message;
    SELECT '==========================================' AS message;
END proc_body $$

DELIMITER ;
