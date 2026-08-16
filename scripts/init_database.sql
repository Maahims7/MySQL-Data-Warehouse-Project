/*
=============================================================
Create Databases (MySQL version)
=============================================================
Script Purpose:
    MySQL does not support multiple schemas inside one database the way
    SQL Server does, so this project uses three separate MySQL databases
    instead of three schemas: 'bronze', 'silver', 'gold'.
    Cross-database queries (e.g. gold reading from silver) work fine in
    MySQL as long as they live on the same server, so the rest of the
    project (naming, joins, views) stays the same.

WARNING:
    Running this script will DROP the 'bronze', 'silver', and 'gold'
    databases if they exist. All data in them will be permanently
    deleted. Make sure you have backups if needed before running this.
=============================================================
*/

DROP DATABASE IF EXISTS bronze;
DROP DATABASE IF EXISTS silver;
DROP DATABASE IF EXISTS gold;

CREATE DATABASE bronze;
CREATE DATABASE silver;
CREATE DATABASE gold;
