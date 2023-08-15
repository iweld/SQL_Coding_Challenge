/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
	File Name: normalize_tables.sql
*/

-- We must insure that our data is properly organized.  Let's create a schema
-- specificaly for our transformed, clean data.
CREATE SCHEMA IF NOT EXISTS cleaned_data;
-- Create countries table
-- Drop this table everytime this script is run to ensure repeatability.
-- We are adding CASCADE for when we add foreign key relationships.
DROP TABLE IF EXISTS cleaned_data.countries CASCADE;
-- We must presuppose that the data in it's current state is unusable/unreliable.
-- 
CREATE TABLE cleaned_data.countries (
	-- The country_id was automatically incremented and can be entered as an integer.
	country_id INT NOT NULL,
	-- Different from other database systems, in PostgreSQL, there is no performance difference among the three character types (char, varchar and text).  
	-- Use text to ensure that there are no errors due to string length.
	country_name TEXT NOT NULL,
	-- The data appears to have duplicate entries so we will remove them once the data has been cleaned of
	-- any unwanted characters.
	country_code_2 varchar(2) NOT NULL,
	country_code_3 varchar(3) NOT NULL,
	region TEXT,
	sub_region TEXT,
	intermediate_region TEXT,
	created_on date,
	PRIMARY KEY (country_id)
);

INSERT INTO cleaned_data.countries (
	country_id,
	country_name,
	country_code_2,
	country_code_3,
	region,
	sub_region,
	intermediate_region,
	created_on
)
(
	SELECT
		i.country_id,
		-- regex_replace() function removes any special characters with a simple regex-expression.
		-- trim() function removes white space from either end of the string.
		-- lower() function converts all characters to lowercase.
		trim(lower(regexp_replace(i.country_name, '[^\w\s^. ]', '', 'gi'))),
		-- Properly cast type from TEXT into new table
		trim(lower(regexp_replace(i.country_code_2, '[^\w\s^. ]', '', 'gi')))::varchar,
		trim(lower(regexp_replace(i.country_code_3, '[^\w\s^. ]', '', 'gi')))::varchar,
		trim(lower(regexp_replace(i.region, '[^\w\s^. ]', '', 'gi'))),
		trim(lower(regexp_replace(i.sub_region, '[^\w\s^. ]', '', 'gi'))),
		trim(lower(regexp_replace(i.intermediate_region, '[^\w\s^. ]', '', 'gi'))),
		-- Use the built-in function current_date to insert current date into created_on field.
		current_date
	FROM 
		import_data.countries AS i
);

/* Create cleaned_data.cities table */
DROP TABLE IF EXISTS cleaned_data.cities;
CREATE TABLE cleaned_data.cities (
	city_id int,
	city_name TEXT,
	latitude float,
	longitude float,
	country_code_2 varchar(2) NOT NULL,
	capital boolean,
	population int,
	insert_date date,
	PRIMARY KEY (city_id)
);

INSERT INTO cleaned_data.cities (
	city_id,
	city_name,
	latitude,
	longitude,
	country_code_2,
	capital,
	population,
	insert_date
)
(
	SELECT
		i.city_id,
		trim(lower(regexp_replace(i.city_name, '[^\w\s^. ]', '', 'gi'))),
		i.longitude::float,
		i.latitude::float,
		trim(lower(regexp_replace(i.country_code_2, '[^\w\s^. ]', '', 'gi')))::varchar,
		i.capital::boolean,
		i.population::int,
		i.insert_date::date
	FROM 
		import_data.cities AS i
);

/* Create cleaned_data.currencies table */
DROP TABLE IF EXISTS cleaned_data.currencies;
CREATE TABLE cleaned_data.currencies (
	currency_id int,
	country_code_2 varchar(2) NOT NULL,
	currency_name TEXT,
	currency_code TEXT,
	PRIMARY KEY (currency_id)
);

INSERT INTO cleaned_data.currencies (
	currency_id,
	country_code_2,
	currency_name,
	currency_code
)
(
	SELECT 
		currency_id,
		trim(lower(regexp_replace(i.country_code_2, '[^\w\s^. ]', '', 'gi')))::varchar,
		trim(lower(regexp_replace(i.currency_name, '[^\w\s^. ]', '', 'gi'))),
		trim(lower(regexp_replace(i.currency_code, '[^\w\s^. ]', '', 'gi')))
	FROM
		import_data.currencies AS i
);

/* Create cleaned_data.languages table */
DROP TABLE IF EXISTS cleaned_data.languages;
CREATE TABLE cleaned_data.languages (
	language_id int,
	language TEXT,
	country_code_2 varchar(2) NOT NULL,
	PRIMARY KEY (language_id)
);

INSERT INTO cleaned_data.languages (
	language_id,
	language,
	country_code_2
)
(
	SELECT 
		language_id,
		trim(lower(regexp_replace(i.language, '[^\w\s^. ]', '', 'gi'))),
		trim(lower(regexp_replace(i.country_code_2, '[^\w\s^. ]', '', 'gi')))::varchar
	FROM
		import_data.languages AS i
);
	

