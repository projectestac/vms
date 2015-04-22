#!/bin/bash

source "/vms/provision/functions.sh"

dbnum=$1

mysql_import_db "xtec_blocs_$dbnum" /git/xtecblocs/sql/xtec_blocs_$dbnum.sql

