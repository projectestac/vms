#!/usr/bin/env bash

wwwdir=/vagrant_git/html
pass=agora

/vagrant/provision/base.sh
/vagrant/provision/php5.sh $wwwdir
/vagrant/provision/memcache.sh
/vagrant/provision/mysql.sh $pass
/vagrant/provision/oracle-xe.sh


echo 'Data Provisioning'
#  Portal
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS adminagora"
cat /vagrant_git/sql/adminagora.sql | mysql -uroot -p$pass adminagora

#  Intranets
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu1"
cat /vagrant_git/sql/usu1.sql | mysql -uroot -p$pass usu1
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu2"
cat /vagrant_git/sql/usu2.sql | mysql -uroot -p$pass usu2
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu3"
cat /vagrant_git/sql/usu3.sql | mysql -uroot -p$pass usu3
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS usu4"
cat /vagrant_git/sql/usu4.sql | mysql -uroot -p$pass usu4

#Data docs
sudo cp -R /vagrant_git/docs "/var/www/docs"
sudo chown -R www-data:www-data /var/www/docs
sudo chmod -R 777 /var/www/docs

sudo cp -R /vagrant_git/zkdata "/var/www/zkdata"
sudo chown -R www-data:www-data /var/www/zkdata
sudo chmod -R 777 /var/www/zkdata

sudo cp -R /vagrant_git/syncdata "/var/www/syncdata"
sudo chown -R www-data:www-data /var/www/syncdata
sudo chmod -R 777 /var/www/syncdata

cp /var/www/html/config/config-dist.php /var/www/html/config/config.php
cp /var/www/html/config/env-config-dist.php /var/www/html/config/env-config.php
cp /var/www/html/config/config-restricted-dist.php /var/www/html/config/config-restricted.php
cp /var/www/html/config/sync-config-dist.sh /var/www/html/config/sync-config.sh
cp /var/www/html/.htaccess-dist /var/www/html/.htaccess