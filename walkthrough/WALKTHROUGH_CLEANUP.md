## Shaker's SQL Analytics Code Challenge

**Author**: Jaime M. Shaker
**Email**: jaime.m.shaker@gmail.com
**Website**: https://www.shaker.dev
**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/ 


:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

###  Clean Up 

Removing duplicate entries is part of the Normalization process.  I've saved this process for the clean-up phase to reduce clutter in the `normalize_tables.sql` script.

Create a new file in `source_data/scripts/` and name it `cleanup_tables.sql`.  In this script, we will first remove duplicate entries in our tables.  

After inspecing our data, we see that every country must have a unique `country_code_2`.

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
	-- Using an aggregate function forces us to group all exact country_codes together.
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

According to our results, there are 14 `country_codes_2` with multiple entries.  Let's create another query that `deletes` all of the multiple entries. 

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

There are no results.  We have successfully deleted multiple entries in the `cleaned_data.countries` table.  We can also take a peek at our `clean_data.countries` table and check if it removed the duplicate entries.  Initally we saw that `Albania` had multiple entries.

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

The multiple entries for `Albania` have been deleted.  

This query works for the `clean_data.countries` table because every country has one unique `country_code_2`.  The problem with using this method with the other tables is that many different countries share cities of the same name, currency type and languages.  The other tables would have to seach for a combination of the table fields.  To reduce clutter, the only table that has duplicate entries is the `clean_data.countries` table.

Now that are tables have been cleaned, we can actually begin answering the questions of the `SQL Coding Challenge`.  Before we do that, let's do a little more clean up and `Drop` our import schema and the tables associated with it as they are not needed anymore.

If for whatever reason we needed to start over, we can easily run the `build_tables.sql`  and then the `normalize_table.sql` scripts and regenerate the data consistently.

`DROP TABLE` removes tables from the database. To empty a table of rows without destroying the table, use `DELETE` or `TRUNCATE`.

The complete `cleaned_data.cleanup_tables.sql` script should look like...

```sql
/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
	File Name: cleanup_tables.sql
*/

-- Remove Duplicate Entries
-- Check for duplicate entries in clean_data.countries
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
	
-- Drop All import_data Tables and Schema

DROP TABLE import_data.countries;
DROP TABLE import_data.cities;
DROP TABLE import_data.currencies;
DROP TABLE import_data.languages;
DROP SCHEMA import_data;
```

With our database cleaned of any unnecessary tables and schema, we can now add `Foreign Key` relationships.

Go to [WALKTHROUGH_RELATIONSHIPS](WALKTHROUGH_RELATIONSHIPS.md)

:exclamation: If you found the repository helpful, please consider giving it a :star:. Thanks! :exclamation:



