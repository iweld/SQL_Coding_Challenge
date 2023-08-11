/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
	File Name: code_challenge.sql
*/


/* Question 2. 
 * 
 * List all of the regions and the total number of countries in each region.
 * 
 */

SELECT 
	initcap(region) AS region,
	count(*) AS country_count
FROM
	cleaned_data.countries
GROUP BY
	region
ORDER BY 
	country_count DESC;

/*

region   |country_count|
---------+-------------+
Africa   |           59|
Americas |           57|
Asia     |           50|
Europe   |           48|
Oceania  |           26|
Antartica|            1|

*/

/* Question 3. 
 * 
 * List all of the countries and the total number of cities in the Northern Europe sub-region.  
 * List the country names in uppercase and order the list by the length of the country name in ascending order.
 * 
 */

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

/*

country_name  |city_count|
--------------+----------+
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

*/
	
/* Question 4.
 * 
 * List all of the countries and the total number of cities in the Southern Europe sub-region 
 * that were inserted in 2022.  Capitalize the country names and order alphabetically by the 
 * LAST letter of the country name in descending order.
 * 
 */ 

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

/*

country_name          |city_count|
----------------------+----------+
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

*/


/* Question 5.
 * 
 * List the country, city name, population and city name length for the city names that are palindromes in the 
 * Western Asia sub-region.  Format the population with a thousands separator (1,000) and format the length of 
 * the city name in roman numerals.  Order by the length of the city name in descending order and 
 * alphabetically in ascending order.
 * 
 */

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

/*

country_name        |city_name|population|roman_numeral_length|
--------------------+---------+----------+--------------------+
Yemen               |Hajjah   |  46,568  |             VI     |
Syrian Arab Republic|Hamah    | 696,863  |              V     |
Turkey              |Kavak    |  21,692  |              V     |
Turkey              |Kinik    |  29,803  |              V     |
Turkey              |Tut      |  10,161  |            III     |

*/


/* Question 6.
 * 
 * List all of the countries that end in 'stan'.  Make your query case-insensitive and list whether 
 * the total population of the cities listed is an odd or even number.  Order by whether it's odd or even 
 * and country name in alphabetical order.
 * 
 */

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

/*

country_name|total_population|odd_or_even|
------------+----------------+-----------+
Afghanistan |  6,006,530     |Even       |
Kazakhstan  |  4,298,264     |Even       |
Kyrgyzstan  |  1,017,644     |Even       |
Pakistan    | 26,344,480     |Even       |
Tajikistan  |  2,720,953     |Odd        |
Turkmenistan|    419,607     |Odd        |
Uzbekistan  |  3,035,547     |Odd        |

*/

/* Question 7.
 * 
 * List the third most populated city by region WITHOUT using limit or offset.
 * List the region name, city name and total population and order by region.
 * 
 */

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

/*

region  |city_name|third_largest_pop|
--------+---------+-----------------+
Africa  |Kinshasa | 12,836,000      |
Americas|New York | 18,972,871      |
Asia    |Delhi    | 32,226,000      |
Europe  |Paris    | 11,060,000      |
Oceania |Brisbane |  2,360,241      |

*/

/* Question 8.
 * 
 * List the bottom third of all countries in the Western Asia sub-region that speak Arabic.
 * 
 */

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


/*

country_name        |
--------------------+
saudi arabia        |
syrian arab republic|
united arab emirates|
yemen               |

*/

/* Question 9.
 * 
 *  Create a query that lists country name, capital name, population, languages spoken 
 * 	and currency name for countries in the Northen Africa sub-region.  There can be multiple 
 * 	currency names and languages spoken per country.  Add multiple values for the same 
 * 	field into an array.
 * 
 */

WITH get_row_values AS (
	SELECT
		co.country_name,
		ci.city_name,
		ci.population,
		array_agg(l.LANGUAGE) AS language_array,
		cu.currency_name AS currency_array
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

/*

country_name|city_name|population|language_array                              |currency_array |
------------+---------+----------+--------------------------------------------+---------------+
algeria     |algiers  |   3415811|{french,arabic,kabyle}                      |algerian dinar |
egypt       |cairo    |  20296000|{arabic}                                    |egyptian pound |
libya       |tripoli  |   1293016|{arabic}                                    |libyan dinar   |
morocco     |rabat    |    572717|{arabic,tachelhit,moroccan tamazight,french}|moroccan dirham|
sudan       |khartoum |   7869000|{arabic,english}                            |sudanese pound |
tunisia     |tunis    |   1056247|{french,arabic}                             |tunisian dinar |

*/


/* Question 10.
 * 
 *  Produce a query that returns the city names for cities in the U.S. that were inserted on April, 28th 2022. List 
 * how many vowels and consonants are present in the city name and concatnate their percentage to the their respective 
 * count in parenthesis.
 * 
 */

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
		ci.country_code_2 in ('us')
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
	
/*

city_name      |vowel_count_perc|consonants_count_perc|
---------------+----------------+---------------------+
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
	
*/



	

	


		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	

