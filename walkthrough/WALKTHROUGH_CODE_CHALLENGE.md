## Shaker's SQL Analytics Code Challenge
### PostgreSQL Project

**Author**: Jaime M. Shaker

**Email**: jaime.m.shaker@gmail.com

**Website**: https://www.shaker.dev

**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/ 

This project is an opportunity to flex your SQL skills and prepare for the role of a Data Analyst.  This project was inspired by the [Braintree Analytics Code Challenge](https://github.com/AlexanderConnelly/BrainTree_SQL_Coding_Challenge_Data_Analyst) and was created to strengthen your SQL knowledge.

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

### SQL Code Challenge



<strong>1.</strong> Using the CSV files located in `source_data/csv_data`, create your new SQL tables with the properly formatted data.

* Add a numeric, auto-incrementing Primary Key to every table.
* In the `countries` table, add the column `created_on` with the current date.
* Create a one-to-one relationship with the countries table as the parent table.

:exclamation: This question has already been completed with the ETL process. :exclamation:

<strong>2.</strong> List all of the regions and the total number of countries in each region.  Order by country count in descending order and capitalize the region name.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

  region   |country_count|
---------|-------------|
Africa   |           59|
Americas |           57|
Asia     |           50|
Europe   |           48|
Oceania  |           26|
Antartica|            1|

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
SELECT 
	initcap(region) AS region,
	count(*) AS country_count
FROM
	cleaned_data.countries
GROUP BY
	region
ORDER BY 
	country_count DESC;
  ```
</details>
<br />

<strong>3.</strong> List all of the countries and the total number of cities in the Northern Europe sub-region.  List the country names in uppercase and order the list by the length of the country name and alphabetically in ascending order.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

country_name  |city_count|
--------------|----------|
JERSEY        |         1|
LATVIA        |        39|
NORWAY        |       127|
SWEDEN        |       148|
DENMARK       |        75|
ESTONIA       |        20|
FINLAND       |       142|
ICELAND       |        12|
IRELAND       |        64|
LITHUANIA     |        61|
ISLE OF MAN   |         2|
FAROE ISLANDS |        29|
UNITED KINGDOM|      1305|

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
SELECT 
	upper(co.country_name) AS country_name,
	count(*) AS city_count
FROM
	cleaned_data.countries AS co
JOIN 
	cleaned_data.cities AS ci
ON 
	co.country_code_2 = ci.country_code_2
WHERE
	co.sub_region = 'northern europe'
GROUP BY 
	co.country_name
ORDER BY 
	length(co.country_name), co.country_name;
  ```
</details>
<br />


<strong>4.</strong> Repeat the query for question #3, but this time, order the results alphabetically by the **second** letter of the city name in ascending order and the number of cities in descending order.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

country_name  |city_count|
--------------|----------|
LATVIA        |        39|
FAROE ISLANDS |        29|
ICELAND       |        12|
DENMARK       |        75|
JERSEY        |         1|
FINLAND       |       142|
LITHUANIA     |        61|
UNITED KINGDOM|      1305|
NORWAY        |       127|
IRELAND       |        64|
ESTONIA       |        20|
ISLE OF MAN   |         2|
SWEDEN        |       148|

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
SELECT 
	upper(co.country_name) AS country_name,
	count(*) AS city_count
FROM
	cleaned_data.countries AS co
JOIN 
	cleaned_data.cities AS ci
ON 
	co.country_code_2 = ci.country_code_2
WHERE
	co.sub_region = 'northern europe'
GROUP BY 
	co.country_name
ORDER BY 
	length(co.country_name), co.country_name;
  ```
</details>
<br />

<strong>5.</strong> List the country, city name, population and city name length for the city names that are palindromes in the Western Asia sub-region.  Format the population with a thousands separator (1,000) and format the length of the city name in roman numerals.  Order by the length of the city name in descending order and alphabetically in ascending order.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

country_name        |city_name|population|roman_numeral_length|
--------------------|---------|----------|--------------------|
Yemen               |Hajjah   |  46,568  |             VI     |
Syrian Arab Republic|Hamah    | 696,863  |              V     |
Turkey              |Kavak    |  21,692  |              V     |
Turkey              |Kinik    |  29,803  |              V     |
Turkey              |Tut      |  10,161  |            III     |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
SELECT 
	initcap(co.country_name) AS country_name,
	initcap(ci.city_name) AS city_name,
	to_char(ci.population, '999G999') AS population,
	to_char(length(ci.city_name), 'RN') AS roman_numeral_length
FROM
	cleaned_data.countries AS co
JOIN 
	cleaned_data.cities AS ci
ON 
	co.country_code_2 = ci.country_code_2
WHERE
	ci.city_name = reverse(ci.city_name)
AND
	co.sub_region = 'western asia'
ORDER BY 
	length(ci.city_name) DESC, ci.city_name ASC;
  ```
</details>
<br />

<strong>6.</strong> List the percentage of the number of countries per region where spanish is an official language.

<strong>7.</strong> Rank countries by gpd and partition by region.  Show the Year-Over-Year gdp growth for the fourth ranked country in every region.

<strong>8.</strong> Using a Temp Table, create a table with one column called `country_and_capital`.  Then...
* Concatenate country name and capital in parenthesis.
* Output the results in CSV format into `source_data/csv_output/country_n_capital.csv`.
* Drop the temp table.

:exclamation: If you found the repository helpful, please consider giving it a :star:. Thanks! :exclamation:



