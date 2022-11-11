#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php.sh
/vms/provision/mysql.sh "$pass"
/vms/provision/postgresql.sh "$pass"

/vms/agora/provision.sh

sudo service apache2 restart
