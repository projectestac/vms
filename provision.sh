#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php.sh
/vms/provision/redis.sh
/vms/provision/mysql.sh "$pass"
/vms/provision/postgresql.sh "$pass"

/vms/agora/provision.sh

# Program local crons
/vms/agora/cron.sh # allschools.php
/vms/provision/supervisor.sh # Laravel queue
