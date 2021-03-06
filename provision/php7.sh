#!/bin/bash

wwwdir=/vms/web

echo 'Install PHP 7.3'

sudo add-apt-repository ppa:ondrej/php &> /dev/null
sudo apt-get update &> /dev/null

sudo apt-get install -qq apache2 php7.3 php7.3-curl php7.3-tidy php7.3-gd php7.3-xml php7.3-xmlrpc php7.3-intl php7.3-cli php-pear php7.3-dev php7.3-ldap libapache2-mod-php7.3 php-codesniffer php7.3-mbstring php7.3-pgsql php7.3-mysql php-gettext php7.3-zip php7.3-soap &> /dev/null

sudo mkdir /etc/apache2/sites-agora
sudo cp -R /vms/provision/php/* /etc/apache2/sites-agora

echo "Include sites-agora/" | sudo tee -a /etc/apache2/apache2.conf

sudo sed -i "s#DocumentRoot .*#DocumentRoot "$wwwdir"#" /etc/apache2/sites-available/000-default.conf
#sudo sed -i "s#<Directory /var/www/>#<Directory "$wwwdir">#" /etc/apache2/sites-available/000-default.conf
#sudo sed -i "s/AllowOverride .*/AllowOverride All/" /etc/apache2/sites-available/000-default.conf

sudo sed -i "s#DocumentRoot .*#DocumentRoot "$wwwdir"#" /etc/apache2/sites-available/default-ssl.conf
#sudo sed -i "s#<Directory /var/www/>#<Directory "$wwwdir">#" /etc/apache2/sites-available/default-ssl.conf
#sudo sed -i "s/AllowOverride .*/AllowOverride All/" /etc/apache2/sites-available/default-ssl.conf

echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf

sudo a2enconf fqdn
sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2ensite default-ssl

sudo service apache2 restart

#PHP Configuration
sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php/7.3/apache2/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/display_startup_errors = .*/display_startup_errors = On/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = Off/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/;error_log = php_errors.log/error_log = \/var\/log\/apache2\/php_errors.log/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php/7.3/apache2/php.ini

sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php/7.3/cli/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/display_startup_errors = .*/display_startup_errors = On/" /etc/php/7.3/cli/php.ini
# Next line is commented on cli to allow composer install
#sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = Off/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/;error_log = php_errors.log/error_log = \/var\/log\/apache2\/php_errors.log/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php/7.3/cli/php.ini
#sudo sed -i "s/disable_functions = .*/disable_functions = /" /etc/php/7.3/cli/php.ini

# Log
sudo sed -i "s/create 640.*/create 777 vagrant vagrant/" /etc/logrotate.d/apache2
sudo chmod -R 777 /var/log/apache2/
sudo chown -R vagrant:vagrant /var/log/apache2/

# Make Vagrant execute apache
sudo sed -i "s/export APACHE_RUN_USER=.*/export APACHE_RUN_USER=vagrant/" /etc/apache2/envvars
sudo chown -R vagrant /var/lock/apache2
sudo adduser vagrant www-data

# Configure opcache
echo "opcache.enable=1" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.memory_consumption=256" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.max_accelerated_files=4000" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
# 0 for development, 60 for production
echo "opcache.revalidate_freq=0" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.interned_strings_buffer=8" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.fast_shutdown=1" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.enable_cli=1" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "; Required for Moodle" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.use_cwd = 1" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.validate_timestamps = 1" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.save_comments = 1" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini
echo "opcache.enable_file_override = 0" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini

echo 'Install memcached and redis'
sudo apt-get install -qq php7.3-memcached php-redis memcached redis-server &> /dev/null

sudo service apache2 restart

echo 'Install XDebug'

sudo apt-get install -qq php7.3-xdebug &> /dev/null

echo "xdebug.default_enable=1" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
echo "xdebug.idekey=\"vagrant\"" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_enable=1" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_autostart=0" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_port=9000" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_handler=dbgp" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_host=10.0.2.2 " | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini

