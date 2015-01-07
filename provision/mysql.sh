#!/bin/bash

pass=$1
dbname=$2

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $pass"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $pass"

sudo apt-get install -y mysql-server-5.5
sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS $dbname"
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
sudo service mysql restart

sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $pass"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $pass"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $pass"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get install -y phpmyadmin