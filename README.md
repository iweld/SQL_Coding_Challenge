## Shaker's SQL Analytics Code Challenge
### PostgreSQL Project

**Author**: Jaime M. Shaker

**Email**: jaime.m.shaker@gmail.com

**Website**: https://www.shaker.dev

**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/ 

This project is an opportunity to flex your SQL skills and prepare for the role of a Data Analyst.  This project was inspired by the [Braintree Analytics Code Challenge](https://github.com/AlexanderConnelly/BrainTree_SQL_Coding_Challenge_Data_Analyst) and was created to strengthen your SQL knowledge.

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

:exclamation: Note :exclamation:

This project is meant to measure/gauge your technical abilities with SQL.

* All work should be done in SQL.
* Create an SQL database and tables using the CSV files located in [./csv_data/](source_data/csv_data/)
	* Do not alter the CSV files.
* Some of these questions are intended purely as a measure of your SQL skills and not as actual questions that one would expect to answer from an employer.

I have created a [Walkthrough](walkthrough/WALKTHROUGH_DOCKER.md) if you would like to follow along and complete this challenge with me. 

The questions are listed below with the expected results and answers hidden if you choose to test your SQL skills.

This repository contains all of the necessary files, datasets and directories for running a PostgresSQL server in a Docker Container.  The only prerequisite is that you should already have Docker Desktop installed and running on your computer.

 https://www.docker.com/products/docker-desktop/
 
 ### Getting Started

* This project uses the latest version of `PostgreSQL`, but any SQL database may be used.
* Directories and Files details:
	* `README.md`: This is the file your are currently reading.
	* `.gitignore`: The files and directories listed in this file will be ignored by Git/GitHub.
	* `source_data/csv_data`: This is the location of the CSV files needed to copy into our database.
	* `db`: In the current directory, create an empty directory named '`db`'.  Although this directory is ignored by Git/GitHub, PostgreSQL requires a directory to keep data persistent if you are running a Docker container.  There will be no need to alter any of the files that reside there once the container starts running.
	* `images`: This is the location of the image files displayed in this repository.
	* `walkthrough/`: A directory with a beginner friendly walkthrough of all of the steps I took to complete the SQL challenge.
	* `source_data/`: This directory contains all the files and scripts within our Docker container.
	* `source_data/csv_data`: This is the location of the CSV files needed to copy/insert into our database.
	* `source_data/scripts/`: This directory will contain all sql scripts I used to complete the challenge.

:grey_exclamation:  Start here if you want to follow along my  [SQL Challenge WALKTHROUGH](./walkthrough/WALKTHROUGH_DOCKER.md) :grey_exclamation: 
 
### SQL Code Challenge

1.   Using the CSV files located in `source_data/csv_data`, create your new SQL tables with the properly formatted data.
		* In the `countries` table, add the column `created_on` with the current date.

2. List the Top 5 populated cities along with the country name and subregion.  Order by population in descending order.

	* Repeat the query for question #2, but this time order the results alphabetically by the **last** letter of the city name.

3. List the top 10 city names and population for city names that are Palindromes.  Order by the length of the city name in descending order.

4.  List the percentage of the number of countries per region where spanish is an official language.

5.  Rank countries by gpd and partition by region.  Show the Year-Over-Year gdp growth for the fourth ranked country in every region.

6. Using a Temp Table, create a table with one column called `country_and_capital`.  Then...
	* Concatenate country name and capital in parenthesis.
	* Output the results in CSV format into `source_data/csv_output/country_n_capital.csv`.
	* Drop the temp table.

:grey_exclamation: Start here if you want to follow along my  [SQL Challenge WALKTHROUGH](./walkthrough/WALKTHROUGH_DOCKER.md) :grey_exclamation: 

:exclamation: If you found the repository helpful, please consider giving it a :star:. Thanks! :exclamation:



