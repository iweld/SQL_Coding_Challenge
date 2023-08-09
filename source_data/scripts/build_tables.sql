/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
	File Name: build_tables.sql
*/

-- We must insure that our data is properly organized.  Let's create a schema
-- specificaly for importing/copying data from our CSV files.
CREATE SCHEMA IF NOT EXISTS import_data;
-- Create import_data.countries table
-- Drop this table everytime this script is run to ensure repeatability.
DROP TABLE IF EXISTS import_data.countries;
-- Create a new table and add a country_id to use as a primary key.
-- We will initially insert all the data as TEXT to ensure there aren't any errors during the COPY.
-- We will also create a created_on field that will have the date that the table was created.
CREATE TABLE import_data.countries (
	-- Create an auto-incrementing, unique key for every row.  
	-- This will also be used as our Primary Key.
	country_id INT GENERATED ALWAYS AS IDENTITY,
	country_name TEXT,
	country_code_2 TEXT,
	country_code_3 TEXT,
	region TEXT,
	sub_region TEXT,
	intermediate_region TEXT,
	created_on date,
	PRIMARY KEY (country_id)
);
-- We will use the COPY statment to extract the data from our CSV files.
COPY import_data.countries (
	country_name,
	country_code_2,
	country_code_3,
	region,
	sub_region,
	intermediate_region
)
-- PostgreSQL stores its data in /var/lib/postgresql/
-- In the docker-compose.yaml file, we created a volume name 'source_data/' that our container can access.
FROM '/var/lib/postgresql/source_data/csv_data/countries.csv'
-- The CSV files are comma separated and include headers.
WITH DELIMITER ',' HEADER CSV;

-- Using the same process, lets create tables for all of our csv files.
/* Create import.cities table */
DROP TABLE IF EXISTS import_data.cities;
CREATE TABLE import_data.cities (
	city_id INT GENERATED ALWAYS AS IDENTITY,
	city_name TEXT,
	latitude TEXT,
	longitude TEXT,
	country_code_2 TEXT,
	capital TEXT,
	population TEXT,
	insert_date TEXT,
	PRIMARY KEY (city_id)
);

COPY import_data.cities (
	city_name,
	latitude,
	longitude,
	country_code_2,
	capital,
	population,
	insert_date
)
FROM '/var/lib/postgresql/source_data/csv_data/cities.csv'
WITH DELIMITER ',' HEADER CSV;

/* Create import.currencies table */
DROP TABLE IF EXISTS import_data.currencies;
CREATE TABLE import_data.currencies (
	currency_id INT GENERATED ALWAYS AS IDENTITY,
	country_code_2 TEXT,
	currency_name TEXT,
	currency_code TEXT,
	PRIMARY KEY (currency_id)
);

COPY import_data.currencies (
	country_code_2,
	currency_name,
	currency_code
)
FROM '/var/lib/postgresql/source_data/csv_data/currencies.csv'
WITH DELIMITER ',' HEADER CSV;

/* Create import.languages table */
DROP TABLE IF EXISTS import_data.languages;
CREATE TABLE import_data.languages (
	language_id INT GENERATED ALWAYS AS IDENTITY,
	language TEXT,
	country_code_2 TEXT,
	PRIMARY KEY (language_id)
);

COPY import_data.languages (
	language,
	country_code_2
)
FROM '/var/lib/postgresql/source_data/csv_data/languages.csv'
WITH DELIMITER ',' HEADER CSV;