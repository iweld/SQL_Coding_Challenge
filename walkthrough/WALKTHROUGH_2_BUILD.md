## Basic/Intermediate SQL Code Challenge

**Author**: Jaime M. Shaker <br />
**Email**: jaime.m.shaker@gmail.com <br />
**Website**: https://www.shaker.dev <br />
**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/  <br />

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

### ETL (Extract/Transform/Load)

ETL is the process data engineers use to extract data from different sources, transform the data into a usable resource, and load that data into the systems that end-users can access and use to solve business problems.  
* Although this term is used on a much larger scale for data warehousing, on a much, much smaller scale, we are doing the same thing by:
	* Extracting raw data from CSV files.
	* Transforming the data to make it usable.
	* Loading the data into tables within our database

Also known as `Data Wrangling`.

In Data Analysis, the analyst must ensure that the data is 'clean' before doing any analysis. 'Dirty' data can lead to unreliable, inaccurate and/or misleading results.

* Garbage in = garbage out.

These are some of the steps that can be taken to properly prepare this dataset for analysis.

* Check for duplicate entries and remove them.
* Remove extra spaces and/or other invalid characters.
* Separate or combine values as needed.
* Correct incorrect spelling or inputted data.
* Check for null or empty values.

Let's create a new file in [source_data/scripts/](../source_data/scripts/) and name it `build_tables.sql`.

Before we can transform the data, we must get the data into the database.  Let's create a script that will consistantly build and rebuild our schema and tables.  We will use the `countries.csv` to create the countries table.

```sql
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
```
Execute the complete script and SUCCESS!  We have inserted the `countries.csv` into the `import_data.countries` table.

Let's test our new table and take a look at the first 5 rows of data.

```sql
SELECT * FROM import_data.countries LIMIT 5;
```
**Results**

country_id|country_name    |country_code_2|country_code_3|region  |sub_region       |intermediate_region|created_on|
----------|----------------|--------------|--------------|--------|-----------------|-------------------|----------|
1|!afg!hANistan   |af?           |afg           |asia    |$southern asia   |                   |          |
2|  alba$nia      |aL            |alb           |europe! |southern *europe |                   |          |
3|Alb?ania        |AL            |alb           |eur#ope |$southern e#urope|                   |          |
4|?algeria?       |d!z           |dza           |africa  |northern africa  |                   |          |
5|americ#an samoa?|as            |as!m          |0oceania|polyne$sia       |                   |          |

As you can see, some countries do not have an `immediate_region` field and none of our entries have a `created_on` value yet.  Also notice that some of the country names have special characters, upper/lower case characters and whitespace.

This will definitely cause some problems if not corrected, however, right now our only concern is to get the data into our database. 

Let's use the same process to add all of the CSV files in `source_data/csv_data/`
* cities.csv
* currencies.csv
* languages.csv

After adding all the necessary code, our `build_tables.sql` file should now look like this...

```sql
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
```
Execute the complete script and our data has now been successfully extracted from the CSV files and inserted/copied into our database.  This script can be repeated over and over and it will always give the same results. 

We can now TRANSFORM our data into a usable resource.

 Go to [WALKTHROUGH_NORMALIZE](WALKTHROUGH_3_NORMALIZE.md)


:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:



