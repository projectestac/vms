#!/bin/bash

pass=$1

echo "MySQL: Installing official repository..."
sudo dnf install -y https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm > /dev/null 2>&1

echo "MySQL: Installing server..."
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023 > /dev/null 2>&1
sudo dnf install -y mysql-community-server php-mysqli > /dev/null 2>&1

echo "MySQL: Configuring..."

# Start the server to configure it
sudo systemctl start mysqld

# Get the temporary password created during installation (mysql service must be running)
temp_pass="$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')"

# Disable history expansion to avoid problems with special characters in the password
set +H

# Execute ALTER USER because is required to remove the password policy
mysql --connect-expired-password -u root -p"$temp_pass" -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$temp_pass'" > /dev/null 2>&1

# Remove password policy to be able to set an insecure password for development
mysql --connect-expired-password -u root -p"$temp_pass" -e "UNINSTALL COMPONENT 'file://component_validate_password'" > /dev/null 2>&1

# Set the insecure password
mysql --connect-expired-password -u root -p"$temp_pass" -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$pass'" > /dev/null 2>&1

# Allow remote connection
mysql --connect-expired-password -u root -p"$pass" mysql -e "UPDATE user SET Host = '%' WHERE user.Host = 'localhost' AND user.User = 'root'" > /dev/null 2>&1
sudo sed -i '$ a\bind-address = 0.0.0.0' /etc/php.ini
sudo systemctl restart php-fpm

# Set some configuration parameters
sudo sed -i 's/\[mysqld\]/\[mysqld\]\nwait_timeout = 100\nmax_connections=500/g' /etc/my.cnf

echo "MySQL: Activating and initializing as a service..."
sudo systemctl daemon-reload
sudo systemctl enable mysqld > /dev/null 2>&1
sudo systemctl restart mysqld

echo "MySQL installed and running."

echo 'phpMyAdmin: Installing...'
pushd /opt/ &> /dev/null || exit
sudo wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz &> /dev/null
sudo mkdir phpmyadmin && sudo tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpmyadmin --strip-components=1 &> /dev/null
sudo rm phpMyAdmin-latest-all-languages.tar.gz &> /dev/null

echo 'phpMyAdmin: Configuring...'
sudo cp phpmyadmin/config.sample.inc.php phpmyadmin/config.inc.php
sudo sed -i "s/.*\['auth_type'\].*/\$cfg['Servers'][\$i]['auth_type'] = 'config';\n\$cfg['Servers'][\$i]['user'] = 'root';\n\$cfg['Servers'][\$i]['password'] = 'agora';/" phpmyadmin/config.inc.php
popd &> /dev/null || exit
