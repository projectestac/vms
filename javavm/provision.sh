#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/java.sh
/vms/provision/oracle-base.sh

#Here we must write the latest version number
save_version 2015043000
