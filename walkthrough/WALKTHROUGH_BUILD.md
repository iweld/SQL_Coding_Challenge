## Shaker's SQL Analytics Code Challenge
### PostgreSQL Project

**Author**: Jaime M. Shaker

**Email**: jaime.m.shaker@gmail.com

**Website**: https://www.shaker.dev

**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/ 

This project is an opportunity to flex your SQL skills and prepare for the role of a Data Analyst.  This project was inspired by the [Braintree Analytics Code Challenge](https://github.com/AlexanderConnelly/BrainTree_SQL_Coding_Challenge_Data_Analyst) and was created to strengthen your SQL knowledge.

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

#### ETL (Extract/Transform/Load)

ETL is the process data engineers use to extract data from different sources, transform the data into a usable resource, and load that data into the systems that end-users can access and use to solve business problems.  
* Although this term is used on a much larger scale for data warehousing, on a much smaller scale, we are doing the same thing by:
	* Extracting raw data from CSV's.
	* Transforming the data to make it usable.
	* Loading the data to tables within our database

Let's create a new file in [source_data/scripts/](../source_data/scripts/) called `build_tables.sql`.

Before we can transform the data, we must get it into the database.  Let's create a script that will consistantly build and rebuild our schema and tables.  We will use the country.csv to create the countries table.

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
	country_id INT GENERATED ALWAYS AS IDENTITY,
	country_name TEXT,
	country_code_2 TEXT,
	country_code_3 TEXT,
	region TEXT,
	sub_region TEXT,
	intermediate_region TEXT,
	created_on date
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
-- The CSV files are comma seperated and include headers.
WITH delimiter ',' header csv;
```
Execute the complete script and SUCCESS!  We have inserted the `countries.csv` into the `import_data.countries` table.

Let's test our new table.

```sql
SELECT * FROM import_data.countries LIMIT 5;
```
**Results**

country_id|country_name   |country_code_2|country_code_3|region |sub_region     |intermediate_region|created_on|
----------|---------------|--------------|--------------|-------|---------------|-------------------|----------|
1|!afghANistan   |af?           |afg           |asia   |southern asia  |                   |          |
2|  albania      |aL            |alb           |europe |southern europe|                   |          |
3|Albania        |AL            |alb           |europe |southern europe|                   |          |
4|?algeria?      |dz            |dza           |africa |northern africa|                   |          |
5|american samoa?|as            |asm           |oceania|polynesia      |                   |          |

As you can see, some countries do not have an `immediate_region` fields and none of our entries have a `created_on` value yet.  We also notice that some of the country names have special characters and whitespace.

Our only concern right now is to get the data into our database.  We will correct these issues in the next step.

Let's use the same process to add all of the CSV files in `source_data/csv_data/`
* cities.csv
* currencies.csv
* gdp.csv
* languages.csv

After adding all the necessary code, our build_tables.sql file should now look like this...

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
-- The CSV files are comma seperated and include headers.
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
	PRIMARY KEY (city_id)
);

COPY import_data.cities (
	city_name,
	latitude,
	longitude,
	country_code_2,
	capital,
	population
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

/* Create import.gdp table */
DROP TABLE IF EXISTS import_data.gdp;
CREATE TABLE import_data.gdp (
	gdp_id INT GENERATED ALWAYS AS IDENTITY,
	country_code_2 TEXT,
	fiscal_year TEXT,
	gdp_amount TEXT,
	PRIMARY KEY (gdp_id)
);

COPY import_data.gdp (
	country_code_2,
	fiscal_year,
	gdp_amount
)
FROM '/var/lib/postgresql/source_data/csv_data/gdp.csv'
WITH DELIMITER ',' HEADER CSV;
```
Our data has now been successfully extracted from the CSV files and inserted/copied into our database.  We can now TRANSFORM our data into a usable resource.

 Go to [WALKTHROUGH_NORMALIZE](WALKTHROUGH_NORMALIZE.md)


:exclamation: If you found the repository helpful, please consider giving it a :star:. Thanks! :exclamation:



