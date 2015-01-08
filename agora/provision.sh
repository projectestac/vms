#!/usr/bin/env bash

wwwdir=/vagrant_git/html
pass=agora

sudo apt-get update

/vagrant/provision/apache2.sh $wwwdir
/vagrant/provision/php5.sh
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
sudo chown -R www-data:www-data /docs
sudo chmod -R 777 /docs

sudo cp -R /vagrant_git/zkdata "/var/www/zkdata"
sudo chown -R www-data:www-data /zkdata
sudo chmod -R 777 /zkdata

sudo cp -R /vagrant_git/syncdata "/var/www/syncdata"
sudo chown -R www-data:www-data /syncdata
sudo chmod -R 777 /syncdata