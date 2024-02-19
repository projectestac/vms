#!/bin/bash

pass=$1
dbname=$2

echo 'Installing MySQL...'

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $pass"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $pass"

sudo apt-get install -qq mysql-server-8.0 &> /dev/null

# Update authentication method.
mysql --connect-expired-password -u root -p"$pass" -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$pass'" &> /dev/null

# Allow remote connection.
mysql --connect-expired-password -u root -p"$pass" mysql -e "UPDATE user SET Host = '%' WHERE user.Host = 'localhost' AND user.User = 'root'" &> /dev/null
sudo sed -i '$ a\bind-address = 0.0.0.0' /etc/mysql/mysql.conf.d/mysqld.cnf

# Configure MySQL.
sudo sed -i 's/\[mysqld\]/\[mysqld\]\nwait_timeout = 100\nmax_connections=500/g' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql restart

# Download phpMyAdmin from the web instead of using system package to avoid dependencies issues.
echo 'Installing phpMyAdmin...'
pushd /var/www &> /dev/null || exit
sudo wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz &> /dev/null
sudo rm -rf phpmyadmin &> /dev/null
sudo mkdir phpmyadmin && sudo tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpmyadmin --strip-components 1 &> /dev/null
sudo rm phpMyAdmin-latest-all-languages.tar.gz &> /dev/null

# Configure phpMyAdmin
sudo cp phpmyadmin/config.sample.inc.php phpmyadmin/config.inc.php
sudo sed -i "s/.*\['auth_type'\].*/\$cfg['Servers'][\$i]['auth_type'] = 'config';\n\$cfg['Servers'][\$i]['user'] = 'root';\n\$cfg['Servers'][\$i]['password'] = '$pass';/" phpmyadmin/config.inc.php
popd &> /dev/null || exit

sudo service mysql restart
