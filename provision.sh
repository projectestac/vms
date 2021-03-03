#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php7.sh
/vms/provision/mysql.sh $pass sinapsi

sudo cp /vms/provision/conf/.env /dades/html/
sudo mkdir -p /dades/html/storage/framework/cache
sudo mkdir -p /dades/html/storage/framework/sessions
sudo mkdir -p /dades/html/storage/framework/views
sudo chmod -R 777 /dades/html/storage/

mysql_import_db sinapsi /dades/html/database/sinapsi-dev.sql

sudo service apache2 restart
