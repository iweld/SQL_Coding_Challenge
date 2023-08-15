/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
	File Name: remove_duplicates.sql
*/

-- Remove Duplicate Entries
-- Check for duplicate entries in clean_data.countries
/*
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
*/
	
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
