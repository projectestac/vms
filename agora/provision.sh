#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Àgora'

rootdir=/dades/agora
wwwdir=$rootdir/html
datadir=$rootdir/docs
git=/git/agora

#  Portal
create_mysql_db "adminagora"
cat $git/sql/adminagora.sql | sudo mysql -uroot -p$pass adminagora

chmod 444 $wwwdir/portal/config/config.php

#Data docs
mkdir_777 $rootdir/docs
sudo cp -R $git/docs/* $rootdir/docs
chown_777 $rootdir/docs

mkdir_777 $rootdir/syncdata
mkdir_777 $rootdir/syncdata/temp

mkdir_777 $rootdir/adminInfo

mkdir_777 $rootdir/cache_ins
chown_777 $wwwdir/moodle2/local/agora/muc

sudo cp $wwwdir/config/.htaccess-dist $wwwdir/config/.htaccess
sudo cp $wwwdir/config/config-dist.php $wwwdir/config/config.php
sudo cp $wwwdir/config/env-config-dist.php $wwwdir/config/env-config.php
sudo cp $wwwdir/config/config-restricted-dist.php $wwwdir/config/config-restricted.php
sudo cp $wwwdir/config/sync-config-dist.sh $wwwdir/config/sync-config.sh
chmod +x $wwwdir/config/sync.sh $wwwdir/config/sync-config.sh
sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess
sudo cp $wwwdir/wordpress/.htaccess-dist $wwwdir/wordpress/.htaccess
chmod -x-w $wwwdir/wordpress/.htaccess

execute_in_oracle "@/dades/agora/html/moodle2/lib/dml/oci_native_moodle_package.sql"

source /etc/profile.d/oracle-env.sh

/vms/agora/create_moodle.sh usu1 $rootdir
/vms/agora/create_moodle.sh usu2 $rootdir
/vms/agora/create_moodle.sh usu3 $rootdir
/vms/agora/create_moodle.sh usu4 $rootdir

/vms/agora/create_nodes.sh usu1 usu1 $rootdir pri usu6
/vms/agora/create_nodes.sh usu2 usu2 $rootdir sec usu7
/vms/agora/create_nodes.sh usu3 usu3 $rootdir cfa usu8
/vms/agora/create_nodes.sh usu4 usu4 $rootdir eoi usu9
/vms/agora/create_nodes.sh usu5 centre-5 $rootdir zer usu10
/vms/agora/create_nodes.sh usu6 centre-6 $rootdir creda usu11
/vms/agora/create_nodes.sh usu7 centre-7 $rootdir cda usu4
/vms/agora/create_nodes.sh usu8 centre-8 $rootdir ssee usu5
/vms/agora/create_nodes.sh usu9 centre-9 $rootdir pro usu3

# Finish installing portal
mkdir_777 $datadir/portaldata
mkdir_777 $datadir/portaldata/pnTemp
mkdir_777 $datadir/portaldata/pnTemp/purifierCache
mkdir_777 $datadir/portaldata/pnTemp/view_cache
mkdir_777 $datadir/portaldata/pnTemp/Theme_cache
mkdir_777 $datadir/portaldata/data
mkdir_777 $datadir/portaldata/data/nodes
mkdir_777 $datadir/portaldata/data/moodle2
sudo cp -R /git/agora/sql/master*.sql $datadir/portaldata/data/nodes
mkdir_777 $datadir/moodle2/usu1/repository
mkdir_777 $datadir/moodle2/usu1/repository/files
sudo cp -R /git/agora/sql/master*.zip $datadir/moodle2/usu1/repository/files
