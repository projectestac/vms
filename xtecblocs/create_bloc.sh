#!/bin/bash

source "/vms/provision/functions.sh"

dbnum=$1
sql=/git/xtecblocs/dump/xtec_blocs_$dbnum.sql

if [ -f "$sql" ]; then
    mysql_import_db "xtec_blocs_$dbnum" "$sql"
else
    echo "Dump $sql not found. Creating empty DB xtec_blocs_$dbnum..."
    create_mysql_db "xtec_blocs_$dbnum"
fi
