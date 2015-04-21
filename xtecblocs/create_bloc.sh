#!/bin/bash

source "/vagrant/provision/functions.sh"

dbnum=$1

mysql_import_db "xtec_blocs_0" /vagrant_git/xtecblocs/sql/xtec_blocs_0.sql
mysql_import_db "xtec_blocs_1" /vagrant_git/xtecblocs/sql/xtec_blocs_1.sql
mysql_import_db "xtec_blocs_2" /vagrant_git/xtecblocs/sql/xtec_blocs_2.sql

