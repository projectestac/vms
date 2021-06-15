#!/bin/bash

pass=$1

echo 'Installing MySQL...'
sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm &> /dev/null
sudo yum install -y mysql-community-server php-mysqli &> /dev/null
sudo systemctl enable mysqld &> /dev/null
sudo systemctl start mysqld &> /dev/null
sudo systemctl restart httpd &> /dev/null

# Get the temporary password created during installation
temp_pass=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $11}')

# Execute ALTER USER because is required to remove the password policy
mysql --connect-expired-password -u root -p"$temp_pass" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$temp_pass'" &> /dev/null

# Remove password policy to be able to set an insecure password for development
mysql --connect-expired-password -u root -p"$temp_pass" -e "uninstall plugin validate_password" &> /dev/null

# Set the insecure password
mysql --connect-expired-password -u root -p"$temp_pass" -e "SET PASSWORD = PASSWORD('$pass')" &> /dev/null

# Allow remote connection
mysql --connect-expired-password -u root -p"$pass" mysql -e "UPDATE user SET Host = '%' WHERE user.Host = 'localhost' AND user.User = 'root'" &> /dev/null
sudo sed -i '$ a\bind-address = 0.0.0.0' /etc/php.ini

# Configure MySQL
sudo sed -i 's/\[mysqld\]/\[mysqld\]\nwait_timeout = 100\nmax_connections=500/g' /etc/my.cnf

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

sudo systemctl start mysqld.service
