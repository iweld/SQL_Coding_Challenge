/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
	File Name: drop_all_tables.sql
	
	Description: This script will drop all tables, schemas and constraints used in 
	this project.
*/

-- Drop import_data tables and schema.
DROP TABLE IF EXISTS import_data.countries;
DROP TABLE IF EXISTS import_data.cities;
DROP TABLE IF EXISTS import_data.currencies;
DROP TABLE IF EXISTS import_data.languages;
DROP SCHEMA IF EXISTS import_data;

-- Drop Foreign Key relationship for cleaned_data.currencies
ALTER TABLE IF EXISTS
	-- Table to be altered
	cleaned_data.cities
DROP CONSTRAINT IF EXISTS
	-- Drop this constraint name
	fk_country_city;

-- Drop Foreign Key relationship for cleaned_data.currencies
ALTER TABLE IF EXISTS
	cleaned_data.currencies
DROP CONSTRAINT IF EXISTS 
	fk_country_currencies;

-- Drop Foreign Key relationship for cleaned_data.languages
ALTER TABLE IF EXISTS
	cleaned_data.languages
DROP CONSTRAINT IF EXISTS
	fk_country_languages;

-- Drop cleaned_data tables and schema.
DROP TABLE IF EXISTS cleaned_data.countries;
DROP TABLE IF EXISTS cleaned_data.cities;
DROP TABLE IF EXISTS cleaned_data.currencies;
DROP TABLE IF EXISTS cleaned_data.languages;
DROP SCHEMA IF EXISTS cleaned_data CASCADE;