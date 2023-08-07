## Shaker's SQL Analytics Code Challenge
### PostgreSQL Project

**Author**: Jaime M. Shaker

**Email**: jaime.m.shaker@gmail.com

**Website**: https://www.shaker.dev

**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/ 

This project is an opportunity to flex your SQL skills and prepare for the role of a Data Analyst.  This project was inspired by the [Braintree Analytics Code Challenge](https://github.com/AlexanderConnelly/BrainTree_SQL_Coding_Challenge_Data_Analyst) and was created to strengthen your SQL knowledge.

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

#### SQL Code Challenge

<strong>1.</strong> Using the CSV files located in `source_data/csv_data`, create your new SQL tables with the properly formatted data.

* Add a numeric, auto-imcrementing Primary Key to every table.
* In the `countries` table, add the column `created_on` with the current date.
* Create a one-to-one relationship with the countries table as the parent table.

:exclamation: This question has already been completed with the ETL process. :exclamation:

<strong>2.</strong> List all of the regions and the total number of countries in each region.

<strong>2.</strong> List the Top 5 populated cities along with the country name and subregion.  Order by population in descending order.


<strong>3.</strong> Repeat the query for question #2, but this time order the results alphabetically by the **last** letter of the city name.

<strong>4.</strong> List the top 10 city names and population for city names that are Palindromes.  Order by the length of the city name in descending order.

<strong>5.</strong> List the percentage of the number of countries per region where spanish is an official language.

<strong>6.</strong> Rank countries by gpd and partition by region.  Show the Year-Over-Year gdp growth for the fourth ranked country in every region.

<strong>7.</strong> Using a Temp Table, create a table with one column called `country_and_capital`.  Then...
* Concatenate country name and capital in parenthesis.
* Output the results in CSV format into `source_data/csv_output/country_n_capital.csv`.
* Drop the temp table.

:exclamation: If you found the repository helpful, please consider giving it a :star:. Thanks! :exclamation:



