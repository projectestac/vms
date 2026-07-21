#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php.sh
/vms/provision/redis.sh
/vms/provision/mysql.sh "$pass"

#/vms/xtecblocs/provision.sh
