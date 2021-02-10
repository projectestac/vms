#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php7.sh
/vms/provision/mysql.sh $pass sinapsi

sudo cp /vms/provision/conf/.env /dades/html/

mysql_import_db sinapsi /git/sinapsi/database/sinapsi-dev.sql

sudo service apache2 restart
