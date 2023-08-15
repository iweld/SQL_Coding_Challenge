#!/bin/bash

echo "Drop All Tables"
psql sql_coding_challenge -f drop_all_tables.sql
echo "Executing build_tables.sql"
psql sql_coding_challenge -f build_tables.sql
echo "Executing normalize_tables.sql"
psql sql_coding_challenge -f normalize_tables.sql
echo "Executing remove_duplicates.sql"
psql sql_coding_challenge -f remove_duplicates.sql
echo "Executing cleanup_db.sql"
psql sql_coding_challenge -f cleanup_db.sql
echo "Executing create_relationships.sql"
psql sql_coding_challenge -f create_relationships.sql
echo "Build Process Complete"