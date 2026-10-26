#!/bin/bash

pass=$1
dbname=$2

echo 'Install MySQL'

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $pass"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $pass"

sudo apt-get install -qq mysql-server-8.0 &> /dev/null
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/\[mysqld\]/\[mysqld\]\nwait_timeout = 100\nmax_connections=500\nsql_mode = NO_ENGINE_SUBSTITUTION/g' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql restart

# MySQL 8.0 in Ubuntu uses auth_socket for root. Set the password so phpMyAdmin can log in.
sudo mysql -uroot -p$pass -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$pass'; FLUSH PRIVILEGES;"

sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $pass"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $pass"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $pass"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"

sudo apt-get install -qq phpmyadmin &> /dev/null

sudo sed -i "s/.*\['auth_type'\].*/\$cfg['Servers'][\$i]['auth_type'] = 'config';\n\$cfg['Servers'][\$i]['user'] = 'root';\n\$cfg['Servers'][\$i]['password'] = 'agora';/" /etc/phpmyadmin/config.inc.php
sudo sed -i '/^.*open_basedir/ s/$/:\/tmp\//' /etc/apache2/conf-available/phpmyadmin.conf
