#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php7.sh
/vms/provision/mysql.sh agora sinapsi
/vms/provision/angular.sh

pushd /git/sinapsi/
make root=/dades/html target=production version=2.1
popd

sudo service apache2 restart
