#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php7.sh
/vms/provision/mysql.sh $pass
/vms/provision/postgresql.sh $pass
#/vms/provision/moodlemobile.sh

/vms/agora/provision.sh

sudo service apache2 restart
