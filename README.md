CREATE OR REPLACE PROCEDURE cleaned_data.sproc_output ()
LANGUAGE plpgsql
AS 
$sproc$
  DECLARE
    -- Define the output file path
    output_file_path TEXT;
  BEGIN
    -- Get the absolute path for the output file
    output_file_path := '/var/lib/postgresql/source_data/csv_output/output.csv';

    -- Copy the result set to the CSV file
    COPY (
      SELECT
        ROW_NUMBER() OVER (ORDER BY t1.insert_date) AS row_id,
        t1.insert_date,
        t2.country_name,
        t1.city_name,
        t1.population,
        array_agg(t3.language) AS languages
      FROM
        cleaned_data.cities AS t1
      JOIN
        cleaned_data.countries AS t2
      ON 
        t1.country_code_2 = t2.country_code_2
      LEFT JOIN
        cleaned_data.languages AS t3
      ON 
        t2.country_code_2 = t3.country_code_2
      WHERE
        t2.sub_region = 'latin america and the caribbean'
      AND
        t1.insert_date IN ('2022-04-09', '2022-04-28', '2022-08-11')
      GROUP BY 
        t1.insert_date,
        t2.country_name,
        t1.city_name,
        t1.population
      ORDER BY
        t1.insert_date
      )
    TO output_file_path WITH CSV HEADER;
  END
$sproc$;

-- Call the stored procedure
CALL cleaned_data.sproc_output();
