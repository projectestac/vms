#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php.sh
/vms/provision/postgresql.sh agora

/vms/alexandria/provision.sh

sudo service apache2 restart

/usr/bin/php /dades/html/admin/cli/upgrade.php --non-interactive
