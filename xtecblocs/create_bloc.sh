#!/bin/bash

source "/vagrant/provision/functions.sh"

dbnum=$1

mysql_import_db "xtec_blocs_$dbnum" /vagrant/xtecblocs/xtec_blocs_0.sql
