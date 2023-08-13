/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
	File Name: cleanup_db.sql
*/
	
-- Drop All import_data Tables and Schema

DROP TABLE import_data.countries;
DROP TABLE import_data.cities;
DROP TABLE import_data.currencies;
DROP TABLE import_data.languages;
DROP SCHEMA import_data CASCADE;
