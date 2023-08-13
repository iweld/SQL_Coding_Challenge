## Shaker's SQL Code Challenge

**Author**: Jaime M. Shaker <br />
**Email**: jaime.m.shaker@gmail.com <br />
**Website**: https://www.shaker.dev <br />
**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/  <br />

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

### SQL Code Challenge

:warning: To start over with an empty table, run the the `drop_all_tables.sql` script. :warning:

<strong>1.  Create Database, Tables and Relations.</strong>   
Using the CSV files located in `source_data/csv_data`, create your new SQL database and tables with the properly formatted data.

* Add a numeric, auto-incrementing Primary Key to every table.
* In the `countries` table, add the column `created_on` with the current date.
* Create a one-to-one relationship with the countries table as the parent table.

:exclamation: This question has already been completed with the ETL process. :exclamation:

<strong>2.  List Regions and Country Count</strong>  
List all of the regions and the total number of countries in each region.  Order by country count in descending order and capitalize the region name.

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

<strong>3. List Sub-Regions and City Count</strong>  
List all of the sub-regions and the total number of cities in each sub-region.  Order by sub-region name alphabetically.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

sub_region                     |city_count|
-------------------------------|----------|
Australia And New Zealand      |       329|
Central Asia                   |       560|
Eastern Asia                   |      3164|
Eastern Europe                 |      2959|
Latin America And The Caribbean|      7204|
Melanesia                      |        60|
Micronesia                     |        15|
Northern Africa                |      1152|
Northern America               |      5844|
Northern Europe                |      2025|
Polynesia                      |        22|
Southeastern Asia              |      2627|
Southern Asia                  |      6848|
Southern Europe                |      3238|
Subsaharan Africa              |      3223|
Western Asia                   |      1400|
Western Europe                 |      3952|

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
SELECT 
	initcap(co.sub_region) AS sub_region,
	count(*) AS city_count
FROM
	cleaned_data.countries AS co
JOIN 
	cleaned_data.cities AS ci
ON
	co.country_code_2 = ci.country_code_2
GROUP BY
	sub_region
ORDER BY 
	sub_region;
  ```
</details>
<br />

<strong>4. Specific Sub-Region and String Functions</strong>  
List all of the countries and the total number of cities in the Northern Europe sub-region.  List the country names in uppercase and order the list by the length of the country name and alphabetically in ascending order.

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


<strong>5. List Specific Countries by Year</strong>  
 List all of the countries and the total number of cities in the Southern Europe sub-region that were inserted in 2021.  Capitalize the country names and order alphabetically by the **LAST** letter of the country name and the number of cities.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

country_name          |city_count|
----------------------|----------|
Andorra               |         5|
Albania               |        11|
Bosnia And Herzegovina|        15|
Croatia               |        22|
North Macedonia       |        28|
Malta                 |        32|
Serbia                |        58|
Slovenia              |        74|
Greece                |        64|
Portugal              |       109|
Spain                 |       302|
San Marino            |         2|
Montenegro            |        12|
Italy                 |       542|

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
SELECT 
	initcap(co.country_name) AS country_name,
	count(*) AS city_count
FROM
	cleaned_data.countries AS co
JOIN 
	cleaned_data.cities AS ci
ON 
	co.country_code_2 = ci.country_code_2
WHERE
	co.sub_region = 'southern europe'
AND
	EXTRACT('year' FROM ci.insert_date) = 2021
GROUP BY 
	co.country_name
ORDER BY 
	substring(co.country_name,length(co.country_name),1), city_count;
  ```
</details>
<br />

<strong>6. List Anti-Join</strong>  
List all of the countries in the region of Asia that did **NOT** have a city with an inserted date from June 2021 through Sept 2021.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

country_name     |
-----------------|
Brunei Darussalam|
Kuwait           |
Macao            |
Singapore        |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
SELECT 
	DISTINCT initcap(co.country_name) AS country_name
FROM
	cleaned_data.countries AS co
LEFT JOIN 
	cleaned_data.cities AS ci
ON 
	co.country_code_2 = ci.country_code_2
AND
	ci.insert_date BETWEEN '2021-06-01' AND '2021-10-01'
WHERE
	co.region = 'asia'
AND 
	ci.country_code_2 IS NULL;
  ```
</details>
<br />

<strong>7. Reversable Names</strong>  
List the country, city name, population and city name length for the city names that are [palindromes](https://en.wikipedia.org/wiki/Palindrome) in the Western Asia sub-region.  Format the population with a thousands separator (1,000) and format the length of the city name in roman numerals.  Order by the length of the city name in descending order and alphabetically in ascending order.

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

<strong>8. Search with Wildcard and Case</strong>  
List all of the countries that end in 'stan'.  Make your query case-insensitive and list whether the total population of the cities listed is an odd or even number for cities inserted in 2022.  Order by whether the population value is odd or even in ascending order and country name in alphabetical order.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

country_name|total_population|odd_or_even|
------------|----------------|-----------|
Afghanistan |  6,006,530     |Even       |
Kazakhstan  |  4,298,264     |Even       |
Kyrgyzstan  |  1,017,644     |Even       |
Pakistan    | 26,344,480     |Even       |
Tajikistan  |  2,720,953     |Odd        |
Turkmenistan|    419,607     |Odd        |
Uzbekistan  |  3,035,547     |Odd        |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
SELECT
	initcap(country_name) AS country_name,
	to_char(sum(ci.population), '99G999G999') total_population,
	CASE
		WHEN (sum(ci.population) % 2) = 0
			THEN 'Even'
		ELSE 
			'Odd'
	END AS odd_or_even
FROM
	cleaned_data.countries AS co
JOIN 
	cleaned_data.cities AS ci
ON 
	co.country_code_2 = ci.country_code_2
WHERE
	co.country_name ILIKE '%stan'
AND 
	EXTRACT('year' FROM ci.insert_date) = 2022
GROUP BY
	co.country_name
ORDER BY 
	odd_or_even, country_name;
  ```
</details>
<br />

<strong>9. Ranking Regions</strong>  
List the third most populated city ranked by region WITHOUT using limit or offset.  List the region name, city name, population and order the results by region.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

region  |city_name|third_largest_pop|
--------|---------|-----------------|
Africa  |Kinshasa | 12,836,000      |
Americas|New York | 18,972,871      |
Asia    |Delhi    | 32,226,000      |
Europe  |Paris    | 11,060,000      |
Oceania |Brisbane |  2,360,241      |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
WITH get_city_rank_cte AS (
	SELECT
		co.region,
		ci.city_name,
		ci.population AS third_largest_pop,
		DENSE_RANK() OVER (PARTITION BY co.region ORDER BY ci.population DESC) AS rnk
	FROM
		cleaned_data.countries AS co
	JOIN 
		cleaned_data.cities AS ci
	ON 
		co.country_code_2 = ci.country_code_2
	WHERE 
		ci.population IS NOT NULL
	GROUP BY
		co.region,
		ci.city_name,
		ci.population
)
SELECT
	initcap(region) AS region,
	initcap(city_name) AS city_name,
	to_char(third_largest_pop, '99G999G999') AS third_largest_pop
FROM
	get_city_rank_cte
WHERE
	rnk = 3;
  ```
</details>
<br />

<strong>10. Using Buckets</strong>  
List the bottom third of all countries in the Western Asia sub-region that speak Arabic.  Include the row number and country name.  Order by row number.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

country_name        |
--------------------|
saudi arabia        |
syrian arab republic|
united arab emirates|
yemen               |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
WITH get_ntile_cte AS (
	SELECT 
		country_name,
		NTILE(3) OVER (ORDER BY country_name) AS nt
	FROM
		cleaned_data.countries AS co
	JOIN 
		cleaned_data.languages AS l
	ON
		co.country_code_2 = l.country_code_2
	WHERE
		sub_region = 'western asia'
	AND 
		l.language = 'arabic'
)
SELECT
	country_name
FROM
	get_ntile_cte
WHERE
	nt = 3;
  ```
</details>
<br />

<strong>11. Using Arrays</strong>  
Create a query that lists country name, capital name, population, languages spoken and currency name for countries in the Northen Africa sub-region.  There can be multiple currency names and languages spoken per country.  Add multiple values for the same field into an array.

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

country_name|city_name|population|languages                                   |currencies     |
------------|---------|----------|--------------------------------------------|---------------|
algeria     |algiers  |   3415811|{french,arabic,kabyle}                      |algerian dinar |
egypt       |cairo    |  20296000|{arabic}                                    |egyptian pound |
libya       |tripoli  |   1293016|{arabic}                                    |libyan dinar   |
morocco     |rabat    |    572717|{arabic,tachelhit,moroccan tamazight,french}|moroccan dirham|
sudan       |khartoum |   7869000|{arabic,english}                            |sudanese pound |
tunisia     |tunis    |   1056247|{french,arabic}                             |tunisian dinar |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
WITH get_row_values AS (
	SELECT
		co.country_name,
		ci.city_name,
		ci.population,
		-- array_agg() aggregates multiple values and returns them in 'array' format.
		array_agg(l.LANGUAGE) AS languages,
		cu.currency_name AS currencies
	FROM
		cleaned_data.countries AS co
	JOIN
		cleaned_data.cities AS ci
	ON 
		co.country_code_2 = ci.country_code_2
	JOIN
		cleaned_data.languages AS l
	ON 
		co.country_code_2 = l.country_code_2
	JOIN
		cleaned_data.currencies AS cu
	ON 
		co.country_code_2 = cu.country_code_2
	WHERE
		sub_region = 'northern africa'
	AND
		ci.capital = TRUE
	GROUP BY
		co.country_name,
		ci.city_name,
		ci.population,
		cu.currency_name
)
SELECT
	*
FROM
	get_row_values;
  ```
</details>
<br />

<strong>12. Using Case and Percentages</strong>  
Produce a query that returns the city names for cities in the U.S. that were inserted on April, 28th 2022.  List how many vowels and consonants are present in the city name and concatnate their percentage to the their respective count in parenthesis.  

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

city_name      |vowel_count_perc|consonants_count_perc|
---------------|----------------|---------------------|
standish       |2 (25.00%)      |6 (75%)              |
grand forks    |2 (18.18%)      |9 (81.82%)           |
camano         |3 (50.00%)      |3 (50%)              |
cedar hills    |3 (27.27%)      |8 (72.73%)           |
gladstone      |3 (33.33%)      |6 (66.67%)           |
whitehall      |3 (33.33%)      |6 (66.67%)           |
homewood       |4 (50.00%)      |4 (50%)              |
willowbrook    |4 (36.36%)      |7 (63.64%)           |
port salerno   |4 (33.33%)      |8 (66.67%)           |
vadnais heights|5 (33.33%)      |10 (66.67%)          |
jeffersonville |5 (35.71%)      |9 (64.29%)           |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
WITH get_letter_count AS (
	SELECT
		ci.city_name,
		length(ci.city_name) string_length,
		length(regexp_replace(ci.city_name, '[aeiou]', '', 'gi')) AS consonant_count
	FROM
		cleaned_data.cities AS ci
	WHERE
		ci.insert_date = '2022-04-28'
	AND
		country_code_2 in ('us')
),
get_letter_diff AS (
	SELECT
		city_name,
		string_length - consonant_count AS vowels,
		round(100 * (string_length - consonant_count) / string_length::NUMERIC, 2) AS vowel_perc,
		consonant_count AS consonants,
		round( 100 * (consonant_count)::NUMERIC / string_length, 2)::float AS consonants_perc
	FROM
		get_letter_count
)
SELECT 
	city_name,
	vowels || ' (' || vowel_perc || '%)' AS vowel_count_perc,
	consonants || ' (' || consonants_perc || '%)' AS consonants_count_perc
FROM
	get_letter_diff
ORDER BY 
	vowels;
  ```
</details>
<br />

<strong>13. Most Consecutive Days</strong>  
List the most consecutive inserted dates and the capitalized city names for cities in Canada that where inserted in April 2022.  

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

most_consecutive_dates|city_name   |
----------------------|------------|
2022-04-22|South Dundas|
2022-04-23|La Prairie  |
2022-04-24|Elliot Lake |
2022-04-25|Lachute     |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
WITH get_dates AS (
	SELECT
		DISTINCT ON (insert_date) insert_date AS insert_date,
		city_name
	FROM
		cleaned_data.cities
	WHERE
		country_code_2 = 'ca'
	AND
		insert_date BETWEEN '2022-04-01' AND '2022-04-30'
	ORDER BY
		insert_date
),
get_diff AS (
	SELECT
		city_name,
		insert_date,
		EXTRACT('day' FROM insert_date) - ROW_NUMBER() OVER (ORDER BY insert_date) AS diff
	FROM
		get_dates
),
get_diff_count AS (
	SELECT
		city_name,
		insert_date,
		count(*) OVER (PARTITION BY diff) AS diff_count
	FROM
		get_diff
),
get_rank AS (
	SELECT
		DENSE_RANK() OVER (ORDER BY diff_count desc) AS rnk,
		insert_date,
		city_name
	FROM
		get_diff_count
)
SELECT
	insert_date AS most_consecutive_dates,
	initcap(city_name) AS city_name
FROM
	get_rank
WHERE
	rnk = 1
ORDER BY 
	insert_date;
  ```
</details>
<br />

<strong>14. Month over Month in View</strong>  
Create a view that lists the month-year, the number of cities inserted for that month, a running city count total and the month over month percentage growth for 2021.

Format the cities count and the running total with the thousands separator and format the month over month growth with a plus symbol and percentage symbol

Example: 
month_year|cities_inserted|running_total|month_over_month|
----------|---------------|-------------|----------------|
Feb-2021  | 1,291         |  2,762      |+87.76%         |

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

month_year|cities_inserted|running_total|month_over_month|
----------|---------------|-------------|----------------|
Jan-2021  | 1,471         |  1,471      |                |
Feb-2021  | 1,291         |  2,762      |+87.76%         |
Mar-2021  | 1,485         |  4,247      |+53.77%         |
Apr-2021  | 1,508         |  5,755      |+35.51%         |
May-2021  | 1,509         |  7,264      |+26.22%         |
Jun-2021  | 1,395         |  8,659      |+19.20%         |
Jul-2021  | 1,394         | 10,053      |+16.10%         |
Aug-2021  | 1,481         | 11,534      |+14.73%         |
Sep-2021  | 1,452         | 12,986      |+12.59%         |
Oct-2021  | 1,446         | 14,432      |+11.14%         |
Nov-2021  | 1,378         | 15,810      |+9.55%          |
Dec-2021  | 1,472         | 17,282      |+9.31%          |

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
DROP VIEW IF EXISTS cleaned_data.year_2021_growth;
CREATE VIEW cleaned_data.year_2021_growth AS (
	WITH get_month_count AS (
		SELECT
			date_trunc('month', insert_date) as single_month,
		  	count(*) AS monthly_count
		FROM 
			cleaned_data.cities
		WHERE 
			EXTRACT('year' FROM insert_date) = 2021
		GROUP BY 
			single_month
		ORDER BY 
			single_month
	),
	get_running_total AS (
		SELECT
			single_month::date,
		  	monthly_count,
		  	sum(monthly_count) OVER (ORDER BY single_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_num_cities
		FROM
			get_month_count
	),
	get_month_over_month AS (
		SELECT
			single_month,
			monthly_count,
			total_num_cities,
			round(100.0 * ((total_num_cities - Lag(total_num_cities, 1) OVER (ORDER BY single_month)) / Lag(total_num_cities, 1) OVER (ORDER BY single_month))::NUMERIC, 2) AS month_over_month
		FROM
			get_running_total
	)
	SELECT
		to_char(single_month, 'Mon-YYYY') AS month_year,
		to_char(monthly_count, '9G999') AS cities_inserted,
		to_char(total_num_cities, '99G999') AS running_total,
		to_char(month_over_month, 'sg99.99') || '%' AS month_over_month
	FROM
		get_month_over_month
);

SELECT 
	*
FROM 
	cleaned_data.year_2021_growth;
  ```
</details>
<br />

<strong>15. Stored Procedure to CSV</strong>  
Create and call a stored procedure that lists a unique row id number, insert date, county name, city name, population and languages spoken for countries in the Latin America and the Caribbean sub-region that were insert on either '2022-04-09', '2022-04-28' or '2022-08-11'.

 Order by the insert date and output the results (including headers) to a CSV file located in [/source_data/csv_output/](../source_data/csv_output/) . 

<details>
  <summary>Click to expand expected results!</summary>

  ##### Expected Results:

Results located in [/source_data/csv_output/output.csv](../source_data/csv_output/output.csv)

</details>
</p>

<details>
  <summary>Click to expand answer!</summary>

  ##### Answer
  ```sql
CREATE OR REPLACE PROCEDURE cleaned_data.sproc_output ()
LANGUAGE plpgsql
AS 
$sproc$
	BEGIN
		COPY (
			SELECT
				ROW_NUMBER() OVER (ORDER BY ci.insert_date) AS row_id,
				ci.insert_date,
				co.country_name,
				ci.city_name,
				ci.population,
				array_agg(la.language) AS languages
			FROM
				cleaned_data.cities AS ci
			JOIN
				cleaned_data.countries AS co
			ON 
				co.country_code_2 = ci.country_code_2
			LEFT JOIN
				cleaned_data.languages AS la
			ON 
				co.country_code_2 = la.country_code_2
			WHERE
				co.sub_region = 'latin america and the caribbean'
			AND
				ci.insert_date IN ('2022-04-09', '2022-04-28', '2022-08-11')
			GROUP BY 
				ci.insert_date,
				co.country_name,
				ci.city_name,
				ci.population
			ORDER BY
				ci.insert_date
			)
		TO '/var/lib/postgresql/source_data/csv_output/output.csv' DELIMITER ',' CSV HEADER;
	END
$sproc$;

-- Call the stored procedure
CALL cleaned_data.sproc_output();
  ```
</details>
<br />

:warning: To start over with an empty table, run the the `drop_all_tables.sql` script. :warning:

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:


