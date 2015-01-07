#!/bin/bash

wwwdir=/vagrant_git/html
pass=agora
dbname=alexandria
datadir=/moodledata

sudo apt-get update

/vagrant/provision/apache2.sh $wwwdir
/vagrant/provision/php5.sh
/vagrant/provision/memcache.sh
/vagrant/provision/mysql.sh $pass $dbname

#DB Provisioning
zcat /vagrant_git/alexandria.sql.gz | mysql -uroot -p$pass $dbname

sudo cp -R /vagrant_git/moodledata-dist "${datadir}"
sudo chown -R www-data:www-data "${datadir}"
sudo chmod -R 777 "${datadir}"

cd /var/www/html/web
cp /vagrant/alexandria/config.php config.php

#cd /vagrant_git