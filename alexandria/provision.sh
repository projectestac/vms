#!/bin/bash

wwwdir=/vagrant_git/html
pass=agora
dbname=alexandria
datadir=/moodledata

/vagrant/provision/base.sh
/vagrant/provision/php5.sh $wwwdir
/vagrant/provision/memcache.sh
/vagrant/provision/mysql.sh $pass

echo 'Data Provisioning'
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS $dbname"
zcat /vagrant_git/alexandria.sql.gz | mysql -uroot -p$pass $dbname

sudo cp -R /vagrant_git/moodledata-dist "${datadir}"
sudo chown -R www-data:www-data "${datadir}"
sudo chmod -R 777 "${datadir}"

cd /var/www/html/web
cp /vagrant/alexandria/config.php config.php

#cd /vagrant_git