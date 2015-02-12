#!/usr/bin/env bash

rootdir=/dades/agora
wwwdir=$rootdir/html
pass=agora
datadir=$rootdir/docs
git=/vagrant_git

/vagrant/provision/base.sh
/vagrant/provision/php5.sh $wwwdir
/vagrant/provision/memcache.sh
/vagrant/provision/mysql.sh $pass
/vagrant/provision/oracle-xe.sh


echo 'Data Provisioning'
#  Portal
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS adminagora"
cat $git/sql/adminagora.sql | mysql -uroot -p$pass adminagora

#Data docs
sudo mkdir $rootdir/docs
sudo cp -R $git/docs/* $rootdir/docs
sudo chown -R www-data:www-data $rootdir/docs
sudo chmod -R 777 $rootdir/docs

sudo mkdir $rootdir/zkdata
sudo cp -R $git/zkdata/* $rootdir/zkdata
sudo chown -R www-data:www-data $rootdir/zkdata
sudo chmod -R 777 $rootdir/zkdata

sudo mkdir $rootdir/syncdata
sudo cp -R $git/syncdata/* $rootdir/syncdata
sudo chown -R www-data:www-data $rootdir/syncdata
sudo chmod -R 777 $rootdir/syncdata

sudo mkdir $rootdir/cache_ins
sudo chmod -R 777 $rootdir/cache_ins

sudo chmod -R 777 $wwwdir/moodle2/local/agora/muc

sudo cp $wwwdir/config/config-dist.php $wwwdir/config/config.php
sudo cp $wwwdir/config/env-config-dist.php $wwwdir/config/env-config.php
sudo cp $wwwdir/config/config-restricted-dist.php $wwwdir/config/config-restricted.php
sudo cp $wwwdir/config/sync-config-dist.sh $wwwdir/config/sync-config.sh
sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess

sudo sed -i "s#RewriteBase .*#RewriteBase /#" $wwwdir/.htaccess
sudo sed -i "s#\$agora\['server'\]\['server'\] .*#\$agora\['server'\]\['server'\] = 'http://agora-vm';#" $wwwdir/config/env-config.php
sudo sed -i "s#\$agora\['server'\]\['base'\] .*#\$agora\['server'\]\['base'\] = '/';#" $wwwdir/config/env-config.php

sudo su - oracle --command "sqlplus / as sysdba << EOF
@/dades/agora/html/moodle2/lib/dml/oci_native_moodle_package.sql
exit;
EOF"

/vagrant/agora/create_moodle.sh usu1 $pass $rootdir
/vagrant/agora/create_intranet.sh usu1 $pass $rootdir $git
