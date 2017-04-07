#!/bin/bash

source "/vms/provision/functions.sh"

mysql_import_db "sinapsi" /git/sinapsi/sql/sinapsi.sql

