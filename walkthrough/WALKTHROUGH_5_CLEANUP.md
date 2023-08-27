## Basic/Intermediate SQL Analytics Code Challenge

**Author**: Jaime M. Shaker <br />
**Email**: jaime.m.shaker@gmail.com <br />
**Website**: https://www.shaker.dev <br />
**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/  <br />


:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

###  Clean Up 

Now that are tables have been cleaned, we can actually begin answering the questions of the `SQL Coding Challenge`.  Before we do that, let's do a little clean up and `Drop` our import schema and the tables associated with it as they are not needed anymore.

If for whatever reason you needed to start over, you can easily rerun the `build_tables.sql`  and then the `normalize_table.sql` scripts and regenerate the data consistently.

`DROP TABLE` removes tables from the database. To empty a table of rows without destroying the table, use `DELETE` or `TRUNCATE`.

The complete `cleanup_db.sql` script should look like...

```sql
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
```

With our database cleaned of any unnecessary tables and schema, we can now add `Foreign Key` relationships.

Go to [WALKTHROUGH_RELATIONSHIPS](WALKTHROUGH_6_RELATIONSHIPS.md)

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:



