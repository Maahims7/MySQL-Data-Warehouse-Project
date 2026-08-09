/*
===============================================================================
Create Database and Schemas
===============================================================================

Script Purpose:
    This script creates a new database named 'data_warehouse' after checking
    whether it already exists.

    If the database exists, it is dropped and recreated. Additionally, the
    script creates the Bronze, Silver, and Gold schemas used in the
    Medallion Data Architecture.

    Bronze Layer:
        Stores raw data ingested from source systems.

    Silver Layer:
        Stores cleaned, validated, and transformed data.

    Gold Layer:
        Stores business-ready data optimized for reporting,
        analytics, and dashboarding.

WARNING:
    Running this script will drop the entire 'data_warehouse' database
    if it already exists.

    All data, tables, views, procedures, and other database objects
    will be permanently deleted.

    Proceed with caution and ensure proper backups are available
    before executing this script.

===============================================================================
*/

-- Drop and recreate the 'data_warehouse' database
DROP DATABASE IF EXISTS data_warehouse;

-- Create the 'data_warehouse' database
CREATE DATABASE data_warehouse;

-- Switch to the database
USE data_warehouse;

-- Create Schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;

-- Verify Creation
SHOW DATABASES;
