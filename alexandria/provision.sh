#!/bin/bash

wwwdir=/dades/alexandria/html/web
pass=agora
dbname=alexandria
datadir=/dades/alexandria/docs
git=/vagrant_git

/vagrant/provision/base.sh
/vagrant/provision/php5.sh $wwwdir
/vagrant/provision/memcache.sh
/vagrant/provision/mysql.sh $pass

echo 'Data Provisioning'
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS $dbname"
zcat $git/alexandria.sql.gz | mysql -uroot -p$pass $dbname

sudo mkdir $datadir
sudo cp -R $git/moodledata-dist/* $datadir
sudo chown -R www-data:www-data $datadir
sudo chmod -R 777 $datadir

sudo cp /vagrant/alexandria/config.php $wwwdir/config.php
sudo chmod -R 777 $wwwdir/local/agora/muc
