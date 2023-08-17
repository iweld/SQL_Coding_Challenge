#!/bin/bash

# Although these commands can be done in a simple one-liner, I've made
# the individual commands for new people that may not understand the syntax.
#
# The breakdown of the command are as follows.
# psql: is a terminal-based front-end to PostgreSQL.
# sql_coding_challenge: Name of our database.
# -f: Checks if the file exists and is a regular file.
# some_file.sql: The sql script  to execute via psql 

psql sql_coding_challenge -f drop_all_tables.sql
psql sql_coding_challenge -f build_tables.sql
psql sql_coding_challenge -f normalize_tables.sql
psql sql_coding_challenge -f remove_duplicates.sql
psql sql_coding_challenge -f cleanup_db.sql
psql sql_coding_challenge -f create_relationships.sql
echo "Build Process Complete"