/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
	File Name: create_relationships.sql
*/

-- Alter cleaned_data.countries and add the UNIQUE constraint to country_code_2

ALTER TABLE 
	cleaned_data.countries 
ADD CONSTRAINT 
	unique_country_code_2 
UNIQUE (country_code_2);

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

-- Create Foreign Key relationship for cleaned_data.currencies
ALTER TABLE
	cleaned_data.currencies
ADD CONSTRAINT 
	fk_country_currencies
FOREIGN KEY (country_code_2)
REFERENCES cleaned_data.countries (country_code_2);

-- Create Foreign Key relationship for cleaned_data.languages
ALTER TABLE 
	cleaned_data.languages
ADD CONSTRAINT 
	fk_country_languages 
FOREIGN KEY (country_code_2)
REFERENCES cleaned_data.countries (country_code_2);

