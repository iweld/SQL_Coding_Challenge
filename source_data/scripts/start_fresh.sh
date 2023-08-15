#!/bin/bash

psql sql_coding_challenge -f drop_all_tables.sql
psql sql_coding_challenge -f build_tables.sql
psql sql_coding_challenge -f normalize_tables.sql
psql sql_coding_challenge -f remove_duplicates.sql
psql sql_coding_challenge -f cleanup_db.sql
psql sql_coding_challenge -f create_relationships.sql
echo "Build Process Complete"