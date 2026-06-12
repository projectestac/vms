#!/bin/bash

source "/vms/provision/functions.sh"

dbnum=$1

mysql_import_db "dossier_$dbnum" /git/dossier/sql/dossier_$dbnum.sql

