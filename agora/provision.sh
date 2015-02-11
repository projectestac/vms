#!/usr/bin/env bash

rootdir=/dades/agora
wwwdir=$rootdir/html
pass=agora
dbname=agora
datadir=$rootdir/docs
git=/vagrant_git

#wwwdir=/vagrant_www

/vagrant/provision/base.sh
/vagrant/provision/php5.sh $wwwdir
/vagrant/provision/memcache.sh
/vagrant/provision/mysql.sh $pass
/vagrant/provision/oracle-xe.sh


echo 'Data Provisioning'
#  Portal
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS adminagora"
cat $git/sql/adminagora.sql | mysql -uroot -p$pass adminagora

#  Intranets
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu1"
cat $git/sql/intranet_mostra_zk13.sql | mysql -uroot -p$pass usu1
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu2"
cat $git/sql/intranet_mostra_zk13.sql | mysql -uroot -p$pass usu2
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu3"
cat $git/sql/intranet_mostra_zk13.sql | mysql -uroot -p$pass usu3
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu4"
cat $git/sql/intranet_mostra_zk13.sql | mysql -uroot -p$pass usu4

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

sudo cp $wwwdir/config/config-dist.php $wwwdir/config/config.php
sudo cp $wwwdir/config/env-config-dist.php $wwwdir/config/env-config.php
sudo cp $wwwdir/config/config-restricted-dist.php $wwwdir/config/config-restricted.php
sudo cp $wwwdir/config/sync-config-dist.sh $wwwdir/config/sync-config.sh
sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess

sudo chmod -R 777 $wwwdir/moodle2/local/agora/muc


sudo mkdir $rootdir/cache_ins
sudo chmod -R 777 $rootdir/cache_ins

sudo su - oracle --command "sqlplus / as sysdba << EOF
@/dades/agora/html/moodle2//lib/dml/oci_native_moodle_package.sql
@/vagrant/agora/agora.sql
exit;
EOF"

#sqlplus usu1/agora@XE

sudo mkdir $rootdir/cache_ins/usu1
sudo chmod -R 777 $rootdir/cache_ins/usu1
sudo mkdir $datadir/usu1
sudo chmod -R 777 $datadir/usu1

sudo sed -i "s#RewriteBase .*#RewriteBase /#" $wwwdir/.htaccess
sudo sed -i "s#\$agora\['server'\]\['server'\] .*#\$agora\['server'\]\['server'\] = 'http://agora-vm';#" $wwwdir/config/env-config.php
sudo sed -i "s#\$agora\['server'\]\['base'\] .*#\$agora\['server'\]\['base'\] = '/';#" $wwwdir/config/env-config.php
