#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php5.sh
/vms/provision/mysql.sh $pass
/vms/provision/oracle-extended.sh default
#/vms/provision/moodlemobile.sh

/vms/agora/provision.sh
/vms/alexandria/provision.sh
/vms/odissea/provision.sh
/vms/xtecblocs/provision.sh
/vms/prestatgeria/provision.sh
/vms/mps/provision.sh

sudo service apache2 restart
sudo service oracle-xe restart

#Here we must write the latest version number
save_version 2017011700
