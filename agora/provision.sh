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
chown 444 $wwwdir/zikula2/config/config.php

#Data docs
mkdir_777 $rootdir/docs
sudo cp -R $git/docs/* $rootdir/docs
chown_777 $rootdir/docs

mkdir_777 $rootdir/zkdata
sudo cp -R $git/zkdata/* $rootdir/zkdata
chown_777 $rootdir/zkdata

mkdir_777 $rootdir/syncdata
sudo cp -R $git/syncdata/* $rootdir/syncdata
chown_777 $rootdir/syncdata

mkdir_777 $rootdir/cache_ins
chown_777 $wwwdir/moodle2/local/agora/muc

mkdir_777 $datadir/ubr_uploads/
mkdir_777 $datadir/ubr_uploads/tmp/

sudo cp $wwwdir/config/.htaccess-dist $wwwdir/config/.htaccess
sudo cp $wwwdir/config/config-dist.php $wwwdir/config/config.php
sudo cp $wwwdir/config/env-config-dist.php $wwwdir/config/env-config.php
sudo cp $wwwdir/config/config-restricted-dist.php $wwwdir/config/config-restricted.php
sudo cp $wwwdir/config/sync-config-dist.sh $wwwdir/config/sync-config.sh
chmod +x $wwwdir/config/sync.sh $wwwdir/config/sync-config.sh
sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess
sudo cp $wwwdir/wordpress/.htaccess-dist $wwwdir/wordpress/.htaccess

echo "Configure CGI"
sudo sed -i "s#ScriptAlias /cgi-bin/ .*#ScriptAlias /cgi-bin/ $rootdir/cgi/#" /etc/apache2/sites-available/000-default.conf
sudo sed -i "s#<Directory \"/usr/lib/cgi-bin\">#<Directory \"$rootdir/cgi\">#" /etc/apache2/sites-available/000-default.conf
sudo sed -i "s#ScriptAlias /cgi-bin/ .*#ScriptAlias /cgi-bin/ $rootdir/cgi/#" /etc/apache2/sites-available/default-ssl.conf
sudo sed -i "s#<Directory \"/usr/lib/cgi-bin\">#<Directory \"$rootdir/cgi\">#" /etc/apache2/sites-available/default-ssl.conf

execute_in_oracle "@/dades/agora/html/moodle2/lib/dml/oci_native_moodle_package.sql"

source /etc/profile.d/oracle-env.sh

/vms/agora/create_moodle.sh usu1 $rootdir
/vms/agora/create_moodle.sh usu2 $rootdir
/vms/agora/create_moodle.sh usu3 $rootdir
/vms/agora/create_moodle.sh usu4 $rootdir

/vms/agora/create_intranet.sh usu1 $rootdir
/vms/agora/create_intranet.sh usu2 $rootdir

/vms/agora/create_nodes.sh usu1 usu1 $rootdir pri usu6
/vms/agora/create_nodes.sh usu2 usu2 $rootdir sec usu7
/vms/agora/create_nodes.sh usu3 usu3 $rootdir cfa usu8
/vms/agora/create_nodes.sh usu4 usu4 $rootdir eoi usu9
/vms/agora/create_nodes.sh usu5 centre-5 $rootdir zer usu10
/vms/agora/create_nodes.sh usu6 centre-6 $rootdir creda usu11
/vms/agora/create_nodes.sh usu7 centre-7 $rootdir cda usu4
/vms/agora/create_nodes.sh usu8 centre-8 $rootdir ssee usu5
/vms/agora/create_nodes.sh usu9 centre-9 $rootdir sec usu7

#Finish instaling portal
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
