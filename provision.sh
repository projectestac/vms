#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php7.sh
/vms/provision/postgresql.sh agora

/vms/alexandria/provision.sh

sudo service apache2 restart
