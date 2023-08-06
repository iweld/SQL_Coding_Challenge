## Shaker's SQL Analytics Code Challenge
### PostgreSQL Project

**Author**: Jaime M. Shaker

**Email**: jaime.m.shaker@gmail.com

**Website**: https://www.shaker.dev

**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/ 

This project is an opportunity to flex your SQL skills and prepare for the role of a Data Analyst.  This project was inspired by the [Braintree Analytics Code Challenge](https://github.com/AlexanderConnelly/BrainTree_SQL_Coding_Challenge_Data_Analyst) and was created to strengthen your SQL knowledge.

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

#### Normalization

According to Wikipedia, [Database normalization](https://en.wikipedia.org/wiki/Database_normalization)  is the process of structuring a relational database in accordance with a series of so-called normal forms in order to reduce data redundancy and improve data integrity. Normalization entails organizing the columns (attributes) and tables (relations) of a database to ensure that their dependencies are properly enforced by database integrity constraints.

Database normalization forms can be quite involved and go beyond the scope of this walkthrough.  In this section, we will restructure our tables with the proper constraints, relationships and "clean" the data as we insert it into our new tables.

To keep things organised, we will created our new tables with the `clean_data ` schema.

Create a new file in the `source_data/scripts` named `normalize_tables.sql`.  Upon inspecting the import.countries table, we can see that there are duplicate entries, mixed upper/lower case characters, added white space and special characters.

```sql
SELECT 
	country_name,
	country_code_2
FROM 
	import_data.countries 
LIMIT 5;
```

**Results:**

country_name   |country_code_2|
---------------|--------------|
!afghANistan   |af?           |
  albania      |aL            |
Albania        |AL            |
?algeria?      |dz            |
american samoa?|as            |

Before we can insert our data into our new table. We must ensure that the data has been 'cleaned'.  During the insert, lets...
* Remove extra spaces (whitespace)
* Remove special characters.
* Convert all characters to lower case.

We could create a `TEMP TABLE` but it seems to be an unecessary step for this project.

```sql
-- We must insure that our data is properly organized.  Let's create a schema
-- specificaly for our transformed, clean data.
CREATE SCHEMA IF NOT EXISTS cleaned_data;
-- Create countries table
-- Drop this table everytime this script is run to ensure repeatability.
DROP TABLE IF EXISTS cleaned_data.countries;
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
		trim(lower(regexp_replace(i.country_name, '^\W+|\W+$', '', 'g'))),
		-- Properly cast type from TEXT into new table
		trim(lower(regexp_replace(i.country_code_2, '^\W+|\W+$', '', 'g')))::varchar,
		trim(lower(regexp_replace(i.country_code_3, '^\W+|\W+$', '', 'g')))::varchar,
		trim(lower(regexp_replace(i.region, '^\W+|\W+$', '', 'g'))),
		trim(lower(regexp_replace(i.sub_region, '^\W+|\W+$', '', 'g'))),
		trim(lower(regexp_replace(i.intermediate_region, '^\W+|\W+$', '', 'g'))),
		-- Use the built-in function current_date to insert current date into created_on field.
		current_date
	FROM 
		import_data.countries AS i
);
```
Now we can run the same query in our new `cleaned_data.countries` table and see our updated results.

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
albania       |al            |
algeria       |dz            |
american samoa|as            |

We can see that the data has been 'cleaned' and is now in a more usable form.  We also note that there are duplicate entries.   Before removing any duplicates, let's continue cleaning the data and adding our clean tables into our `normalize_table.sql` script. 

Click the link to view the complete [normalize_table.sql](../source_data/scripts/normalize_tables.sql)

Once all of your tables are cleaned and loaded, click the link below

 Go to [WALKTHROUGH_CLEANUP](WALKTHROUGH_CLEANUP.md)

:exclamation: If you found the repository helpful, please consider giving it a :star:. Thanks! :exclamation:



