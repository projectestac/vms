#!/bin/bash

pass=$1
dbname=$2

echo 'Installing MySQL...'

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $pass"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $pass"

sudo apt-get install -qq mysql-server-5.7 &> /dev/null
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
sudo sed -i 's/\[mysqld\]/\[mysqld\]\nwait_timeout = 100\nmax_connections=500/g' /etc/mysql/my.cnf

# Download phpMyAdmin from the web instead of using system package to avoid dependencies issues.
echo 'Installing phpMyAdmin...'
pushd /dades/html/config &> /dev/null || exit
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz &> /dev/null
sudo rm -rf phpmyadmin &> /dev/null
mkdir phpmyadmin && tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpmyadmin --strip-components 1 &> /dev/null
rm phpMyAdmin-latest-all-languages.tar.gz &> /dev/null

# Configure phpMyAdmin
cp phpmyadmin/config.sample.inc.php phpmyadmin/config.inc.php
sudo sed -i "s/.*\['auth_type'\].*/\$cfg['Servers'][\$i]['auth_type'] = 'config';\n\$cfg['Servers'][\$i]['user'] = 'root';\n\$cfg['Servers'][\$i]['password'] = 'agora';/" phpmyadmin/config.inc.php
popd &> /dev/null || exit

sudo service mysql restart
