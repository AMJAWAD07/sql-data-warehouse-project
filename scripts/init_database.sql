/*
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated.
WARNING: This will drop the database if it exists. Be careful!
*/

use mysql;

--Drop and recreate the "DataWarehouse" database
drop database if exists DataWarehouse;
create database DataWarehouse;

-- select the DataWarehouse database to work with
use DataWarehouse;
