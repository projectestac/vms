#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php7.sh
/vms/provision/mysql.sh agora sinapsi
#/vms/provision/angular.sh

pushd /git/sinapsi/ || exit
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -qq nodejs &> /dev/null
sudo apt-get install -qq python2.7 build-essential &> /dev/null
sudo npm i -g @angular/cli@8.3
pushd backend || exit
composer update
popd || exit

sudo mkdir -p /dades/html
sudo chown -R vagrant:vagrant /dades/html
make
make install
mysql_import_db sinapsi /git/sinapsi/database/sinapsi-full.sql
popd || exit

sudo service apache2 restart
