#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/php7.sh
/vms/provision/mysql.sh agora sinapsi
#/vms/provision/angular.sh

pushd /git/sinapsi/
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm i -g @angular/cli@8.3
sudo apt install python2.7 build-essential
pushd backend
composer update
popd
make root=/dades/html target=production version=2.1
popd

sudo service apache2 restart
