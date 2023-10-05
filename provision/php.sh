#!/bin/bash

echo 'Installing PHP 8.1...'

#sudo add-apt-repository ppa:ondrej/php &> /dev/null
sudo apt-get update &> /dev/null

sudo apt-get install -qq apache2 php8.1 php8.1-curl php8.1-tidy php8.1-gd php8.1-xml php8.1-xmlrpc php8.1-intl php8.1-cli php-pear php8.1-dev php8.1-ldap libapache2-mod-php8.1 php-codesniffer php8.1-mbstring php8.1-pgsql php8.1-mysql php8.1-gettext php8.1-zip php8.1-soap php8.1-tokenizer &> /dev/null

sudo mkdir /etc/apache2/sites-agora
sudo cp -R /vms/provision/conf/agora.conf /etc/apache2/sites-agora/agora.conf

echo "Include sites-agora/" | sudo tee -a /etc/apache2/apache2.conf
echo "Mutex flock" | sudo tee -a /etc/apache2/apache2.conf
echo "AddType application/wasm .wasm" | sudo tee -a /etc/apache2/apache2.conf

sudo rm /etc/apache2/sites-enabled/*.conf
sudo ln -s /etc/apache2/sites-agora/agora.conf /etc/apache2/sites-enabled/agora.conf

echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf

sudo a2enconf fqdn
sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2ensite default-ssl

sudo service apache2 start

#PHP Configuration
sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php/8.1/apache2/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/;max_input_vars = .*/max_input_vars = 6000/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = On/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 600/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/display_startup_errors = .*/display_startup_errors = On/" /etc/php/8.1/apache2/php.ini
sudo sed -i "s/;error_log = php_errors.log/error_log = \/var\/log\/apache2\/php_errors.log/" /etc/php/8.1/apache2/php.ini

sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php/8.1/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/8.1/cli/php.ini
sudo sed -i "s/;max_input_vars = .*/max_input_vars = 6000/" /etc/php/8.1/cli/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = On/" /etc/php/8.1/cli/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/8.1/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.1/cli/php.ini
sudo sed -i "s/display_startup_errors = .*/display_startup_errors = On/" /etc/php/8.1/cli/php.ini
sudo sed -i "s/;error_log = php_errors.log/error_log = \/var\/log\/apache2\/php_errors.log/" /etc/php/8.1/cli/php.ini

# Log
sudo sed -i "s/create 640.*/create 777 vagrant vagrant/" /etc/logrotate.d/apache2
sudo chmod -R 777 /var/log/apache2/
sudo chown -R vagrant:vagrant /var/log/apache2/

# Make Vagrant execute apache
sudo sed -i "s/export APACHE_RUN_USER=.*/export APACHE_RUN_USER=vagrant/" /etc/apache2/envvars
sudo chown -R vagrant /var/lock/apache2
sudo adduser vagrant www-data

# Configure opcache
echo "opcache.enable=1" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "opcache.memory_consumption=256" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "opcache.max_accelerated_files=4000" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
# 0 for development, 60 for production
echo "opcache.revalidate_freq=0" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "opcache.interned_strings_buffer=8" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "opcache.enable_cli=1" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "; Required for Moodle" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "opcache.use_cwd = 1" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "opcache.validate_timestamps = 1" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "opcache.save_comments = 1" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini
echo "opcache.enable_file_override = 0" | sudo tee -a /etc/php/8.1/mods-available/opcache.ini

echo 'Installing memcached and redis...'
sudo apt-get install -qq php8.1-memcached php-redis memcached redis-server &> /dev/null

#echo 'Installing XDebug...'
#sudo apt-get install -qq php8.1-xdebug &> /dev/null

#echo "xdebug.mode=debug" | sudo tee -a /etc/php/8.1/apache2/conf.d/20-xdebug.ini
#echo "xdebug.idekey=\"vagrant\"" | sudo tee -a /etc/php/8.1/apache2/conf.d/20-xdebug.ini
#echo "xdebug.cli_color=0" | sudo tee -a /etc/php/8.1/apache2/conf.d/20-xdebug.ini
#echo "xdebug.start_with_request=no" | sudo tee -a /etc/php/8.1/apache2/conf.d/20-xdebug.ini
#echo "xdebug.client_port=9003" | sudo tee -a /etc/php/8.1/apache2/conf.d/20-xdebug.ini
#echo "xdebug.client_host=10.0.2.15 " | sudo tee -a /etc/php/8.1/apache2/conf.d/20-xdebug.ini

echo 'Installing and configuring supervisor...'
sudo apt-get install -qq supervisor &> /dev/null
sudo cp /vms/provision/conf/portal_cron.conf /etc/supervisor/conf.d/portal_cron.conf
sudo systemctl enable supervisor &> /dev/null
sudo systemctl start supervisor &> /dev/null

sudo service apache2 restart
