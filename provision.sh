#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php.sh
/vms/provision/redis.sh
/vms/provision/postgresql.sh agora

/vms/odissea/provision.sh

/usr/bin/php /dades/html/admin/cli/upgrade.php --non-interactive
