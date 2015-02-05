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
cat $git/sql/usu1.sql | mysql -uroot -p$pass usu1
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu2"
cat $git/sql/usu2.sql | mysql -uroot -p$pass usu2
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu3"
cat $git/sql/usu3.sql | mysql -uroot -p$pass usu3
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu4"
cat $git/sql/usu4.sql | mysql -uroot -p$pass usu4

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

cp $wwwdir/config/config-dist.php $wwwdir/config/config.php
cp $wwwdir/config/env-config-dist.php $wwwdir/config/env-config.php
cp $wwwdir/config/config-restricted-dist.php $wwwdir/config/config-restricted.php
cp $wwwdir/config/sync-config-dist.sh $wwwdir/config/sync-config.sh
cp $wwwdir/.htaccess-dist $wwwdir/.htaccess

chmod -R 777 $wwwdir/moodle2/local/agora/muc

sudo sed -i "s#RewriteBase .*#RewriteBase /#" $wwwdir/.htaccess
sudo sed -i "s#\$agora\['server'\]\['server'\] .*#\$agora\['server'\]\['server'\] = 'http://agora-vm';#" $wwwdir/config/env-config.php
sudo sed -i "s#\$agora\['server'\]\['base'\] .*#\$agora\['server'\]\['base'\] = '/';#" $wwwdir/config/env-config.php
