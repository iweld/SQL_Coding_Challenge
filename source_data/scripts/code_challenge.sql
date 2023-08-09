/*
	SQL Code Challenge
	Author: Jaime M. Shaker
	Email: jaime.m.shaker@gmail.com or jaime@shaker.dev
	Website: https://www.shaker.dev
	LinkedIn: https://www.linkedin.com/in/jaime-shaker/
	
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
	
/* Question 4.
 * 
 * Repeat the query for question #3, but this time, order the results alphabetically by 
 * the **second** letter of the city name in ascending order and the number of cities 
 * in descending order.
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
	substring(co.country_name,2,1) ASC, count(*) DESC;

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

/* Question 6.
 * 
 * List all of the countries that end in 'stan'.  Make your query case insensitive and list whether 
 * the total population of the cities listed an odd or even number.
 * 
 */

SELECT
	country_name,
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
	country_name ILIKE '%stan'
GROUP BY
	country_name
ORDER BY 
	country_name;

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










