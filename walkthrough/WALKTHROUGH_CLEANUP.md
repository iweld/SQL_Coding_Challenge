## Shaker's SQL Analytics Code Challenge
### PostgreSQL Project

**Author**: Jaime M. Shaker

**Email**: jaime.m.shaker@gmail.com

**Website**: https://www.shaker.dev

**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/ 

This project is an opportunity to flex your SQL skills and prepare for the role of a Data Analyst.  This project was inspired by the [Braintree Analytics Code Challenge](https://github.com/AlexanderConnelly/BrainTree_SQL_Coding_Challenge_Data_Analyst) and was created to strengthen your SQL knowledge.

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

#### Clean Up

Removing duplicate entries is part of the Normalization process.  I've saved this process for the clean up phase to reduce clutter in the `normalize_tables.sql` script.

Create a new file in `source_data/scripts/` and name it `cleanup_tables.sql`.  In this scripts, we will first remove duplicate entries in our tables.  After inspecing our data, we can presume that every country must have a unique `country_code_2`.

Let's create a query that checks for multiple entries of `country_code_2` in our `clean_data.countries` table.

```sql
-- Remove Duplicate Entries
-- Check for duplicate entries
SELECT
	-- Get the columns.
	country_code_2,
	-- Count how many times the country_code_2 occurs.
	count(*)
FROM
	cleaned_data.countries
GROUP BY 
	-- Using an aggregate function forces us to group all like names together.
	country_code_2
HAVING 
	-- Only select values that have a count greater than one (multiple entries).
	count(*) > 1;
```

**Results:**

country_code_2|count|
--------------|-----|
cn            |    3|
al            |    2|
sa            |    2|
ie            |    2|
ly            |    2|
mo            |    2|
re            |    2|
ph            |    2|
zw            |    2|
az            |    2|
kw            |    2|
cy            |    3|
rs            |    2|
mh            |    2|

From our results we can see that there are 14 `country_codes_2` with multiple entries.  Let's create another query that `deletes` all of the multiple entries. 

```sql
-- Delete duplicate entries

DELETE 
FROM 
	-- Add an alias to the id's we wish to keep
	cleaned_data.countries AS clean_data_1
USING 
	-- Add an alias to the duplicate id's
	cleaned_data.countries AS clean_data_2
WHERE 
	-- This statement will remove the greater value id's.
	clean_data_1.country_id > clean_data_2.country_id
AND 
	-- This statement ensures that both values are identical.
	clean_data_1.country_code_2 = clean_data_2.country_code_2;
```

Now, if we were to rerun our first query which checked for duplicate entries, it should not return anything.

```sql
-- Remove Duplicate Entries
-- Check for duplicate entries
SELECT
	-- Get the columns.
	country_code_2,
	-- Count how many times the country_code_2 occurs.
	count(*)
FROM
	cleaned_data.countries
GROUP BY 
	-- Using an aggregate function forces us to group all like names together.
	country_code_2
HAVING 
	-- Only select values that have a count greater than one (multiple entries).
	count(*) > 1;
```
**Results:**

country_code_2|count|
--------------|-----|

We can also take a peek at our clean_data_countries table and check if it removed the duplicate entries.  We could initally see that `Albania` has multiple entries.

```sql
SELECT 
	country_name,
	country_code_2
FROM 
	cleaned_data.countries 
LIMIT 5;
```

**Results:**
country_name  |country_code_2|
--------------|--------------|
afghanistan   |af            |
albania       |al            |
algeria       |dz            |
american samoa|as            |
andorra       |ad            |

We can now see that the multiple entry for `Albania` has been deleted.  

This works for the `clean_data.countries` table because every country has one unique country_code_2.  The problem with using this method with the other tables is because many different countries share cities of the same name, currency type and languages.  To reduce the complexity of this challenge, the only table that has duplicate entries is the `clean_data.countries` table.

Now that are tables have been cleaned, we can actually begin answering the questions of the `SQL Coding Challenge`.  Before we do that, let's do a little clean up and `Drop` our import schema and the table associated with it as they are not needed anymore.

If for whatever reason we needed to start over, we can easily run the build_tables.sql script.

`DROP TABLE` removes tables from the database. To empty a table of rows without destroying the table, use `DELETE` or `TRUNCATE`.

```sql
DROP TABLE import_data.countries;
DROP TABLE import_data.cities;
DROP TABLE import_data.currencies;
DROP TABLE import_data.languages;
DROP TABLE import_data.gdp;
DROP SCHEMA import_data;
```
All of our tables in the `cleaned_data` schema share a common field name `country_code_2`.  We also know that this field is `UNIQUE` in the `cleaned_data.countries` table because there can only be one country code per country.

Using this information, we can make the `cleaned_data.countries` table be the parent table and all other tables can have a `FOREIGN KEY` relationship to it.

First, lets `ALTER` the `cleaned_data.countries` table and add the `UNIQUE` constraint to the `country_code_2` field.

```sql
-- Alter cleaned_data.countries and add the UNIQUE constraint to country_code_2
ALTER TABLE 
	cleaned_data.countries 
ADD CONSTRAINT 
	unique_country_code_2 
UNIQUE (country_code_2);
```

Let us now `ALTER` the child tables and add a `FOREIGN KEY` constraint.

```sql
-- Alter all other tables and add a foreign key constraint and reference.
-- Create Foreign Key relationship for cleaned_data.cities
ALTER TABLE 
	-- Table to be altered
	cleaned_data.cities
ADD CONSTRAINT 
	-- Give this constraint a name
	fk_country_city 
	-- Which key in cleaned_data.cities is a foreign key
FOREIGN KEY (country_code_2)
	-- Which key to reference from parent table
REFERENCES cleaned_data.countries (country_code_2);
```

Once you have created a `FOREIGN KEY` constraint for all of our other tables, your `Entity Relationship Diagram` should look something like this.

![alt text](images/ERD.PNG)

We are now ready to complete the `SQL Coding Challenge`.

click the link below

 Go to [WALKTHROUGH_CLEANUP](WALKTHROUGH_CODE_CHALLENGE.md)


2. List the Top 5 populated cities along with the country name and subregion.  Order by population in descending order.

	* Repeat the query for question #2, but this time order the results alphabetically by the **last** letter of the city name.

3. List the top 10 city names and population for city names that are Palindromes.  Order by the length of the city name in descending order.

4.  List the percentage of the number of countries per region where spanish is an official language.

5.  Rank countries by gpd and partition by region.  Show the Year-Over-Year gdp growth for the fourth ranked country in every region.

6. Using a Temp Table, create a table with one column called `country_and_capital`.  Then...
	* Concatenate country name and capital in parenthesis.
	* Output the results in CSV format into `source_data/csv_output/country_n_capital.csv`.
	* Drop the temp table.

:exclamation: If you found the repository helpful, please consider giving it a :star:. Thanks! :exclamation:



