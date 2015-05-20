#!/bin/bash

wwwdir=/vms/web

echo 'Install PHP 5.4'

sudo add-apt-repository -y ppa:ondrej/php5-oldstable > /dev/null

sudo apt-get update > /dev/null

sudo apt-get install -y --force-yes apache2 php5 php5-curl php5-tidy php5-gd php5-xmlrpc php5-intl php5-mcrypt php5-cli php-pear php5-dev php5-ldap libapache2-mod-php5 > /dev/null

sudo mkdir /etc/apache2/sites-agora
sudo cp -R /vms/provision/php/* /etc/apache2/sites-agora

echo "Include sites-agora/" | sudo tee -a /etc/apache2/apache2.conf

sudo sed -i "s#DocumentRoot .*#DocumentRoot "$wwwdir"#" /etc/apache2/sites-available/default
sudo sed -i "s#<Directory /var/www/>#<Directory "$wwwdir">#" /etc/apache2/sites-available/default
sudo sed -i "s/AllowOverride .*/AllowOverride All/" /etc/apache2/sites-available/default

sudo sed -i "s#DocumentRoot .*#DocumentRoot "$wwwdir"#" /etc/apache2/sites-available/default-ssl
sudo sed -i "s#<Directory /var/www/>#<Directory "$wwwdir">#" /etc/apache2/sites-available/default-ssl
sudo sed -i "s/AllowOverride .*/AllowOverride All/" /etc/apache2/sites-available/default-ssl

echo "ServerName localhost" | sudo tee /etc/apache2/conf.d/fqdn

sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2ensite default-ssl

#PHP Configuration
sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php5/apache2/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sudo sed -i "s/display_startup_errors = .*/display_startup_errors = On/" /etc/php5/apache2/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php5/apache2/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php5/apache2/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = Off/" /etc/php5/apache2/php.ini
sudo sed -i "s/;error_log = php_errors.log/error_log = \/var\/log\/apache2\/php_errors.log/" /etc/php5/apache2/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php5/apache2/php.ini

sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php5/cli/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/cli/php.ini
sudo sed -i "s/display_startup_errors = .*/display_startup_errors = On/" /etc/php5/cli/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = Off/" /etc/php5/cli/php.ini
sudo sed -i "s/;error_log = php_errors.log/error_log = \/var\/log\/apache2\/php_errors.log/" /etc/php5/cli/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php5/cli/php.ini
#sudo sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini

#Log
sudo sed -i "s/create 640.*/create 777 vagrant vagrant/" /etc/logrotate.d/apache2
sudo chmod -R 777 /var/log/apache2/
sudo chown -R vagrant:vagrant /var/log/apache2/


# Make Vagrant execute apache
sudo sed -i "s/export APACHE_RUN_USER=.*/export APACHE_RUN_USER=vagrant/" /etc/apache2/envvars
sudo chown -R vagrant /var/lock/apache2
sudo adduser vagrant www-data

echo 'Install ZendOpache'

yes "" | sudo pecl install Zendopcache > /dev/null

place=`sudo find / -name 'opcache.so'`

echo "zend_extension=$place" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.enable=1" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.memory_consumption=256" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.max_accelerated_files=4000" | sudo tee -a /etc/php5/mods-available/opcache.ini
#0 for development, 60 for production
echo "opcache.revalidate_freq=0" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.interned_strings_buffer=8" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.fast_shutdown=1" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.enable_cli=1" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "; Required for Moodle" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.use_cwd = 1" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.validate_timestamps = 1" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.save_comments = 1" | sudo tee -a /etc/php5/mods-available/opcache.ini
echo "opcache.enable_file_override = 0" | sudo tee -a /etc/php5/mods-available/opcache.ini

sudo ln -s /etc/php5/mods-available/opcache.ini /etc/php5/apache2/conf.d/20-opcache.ini

echo 'Install memcache'
sudo apt-get install -y php5-memcache memcached > /dev/null

sudo service apache2 restart > /dev/null

echo 'Install XDebug'

sudo apt-get install -y php5-xdebug > /dev/null

echo "xdebug.default_enable=1" | sudo tee -a /etc/php5/conf.d/20-xdebug.ini
echo "xdebug.idekey=\"vagrant\"" | sudo tee -a /etc/php5/conf.d/20-xdebug.ini
echo "xdebug.remote_enable=1" | sudo tee -a /etc/php5/conf.d/20-xdebug.ini
echo "xdebug.remote_autostart=0" | sudo tee -a /etc/php5/conf.d/20-xdebug.ini
echo "xdebug.remote_port=9000" | sudo tee -a /etc/php5/conf.d/20-xdebug.ini
echo "xdebug.remote_handler=dbgp" | sudo tee -a /etc/php5/conf.d/20-xdebug.ini
echo "xdebug.remote_host=10.0.2.2 " | sudo tee -a /etc/php5/conf.d/20-xdebug.ini
