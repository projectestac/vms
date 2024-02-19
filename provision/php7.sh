#!/bin/bash

echo 'Install PHP 7.3'

sudo add-apt-repository ppa:ondrej/php &> /dev/null
sudo apt-get update &> /dev/null

sudo apt-get install -qq apache2 php7.3 libapache2-mod-php7.3 php7.3-xml php7.3-cli php7.3-mbstring php7.3-mysql php7.3-tokenizer php7.3-zip php7.3-curl &> /dev/null

sudo mkdir /etc/apache2/sinapsi
sudo cp -R /vms/provision/conf/sinapsi.conf /etc/apache2/sinapsi

echo "Include sinapsi/" | sudo tee -a /etc/apache2/apache2.conf
echo "Mutex flock" | sudo tee -a /etc/apache2/apache2.conf
echo "ServerTokens Full" | sudo tee -a /etc/apache2/apache2.conf

sudo rm /etc/apache2/sites-enabled/*.conf
sudo ln -s /etc/apache2/sinapsi/sinapsi.conf /etc/apache2/sites-enabled/sinapsi.conf

echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf

sudo a2enconf fqdn
sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2ensite default-ssl

sudo service apache2 start

#PHP Configuration
sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php/7.3/apache2/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/;max_input_vars = .*/max_input_vars = 4000/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = On/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 600/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/display_startup_errors = .*/display_startup_errors = On/" /etc/php/7.3/apache2/php.ini
sudo sed -i "s/;error_log = php_errors.log/error_log = \/var\/log\/apache2\/php_errors.log/" /etc/php/7.3/apache2/php.ini

sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php/7.3/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/max_input_vars = .*/max_input_vars = 2000/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = On/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/display_startup_errors = .*/display_startup_errors = On/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/;error_log = php_errors.log/error_log = \/var\/log\/apache2\/php_errors.log/" /etc/php/7.3/cli/php.ini

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
echo "opcache.enable_cli=1" | sudo tee -a /etc/php/7.3/mods-available/opcache.ini

# echo 'Install XDebug'
# sudo apt-get install -qq php7.3-xdebug &> /dev/null
# echo "xdebug.mode=debug" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
# echo "xdebug.idekey=\"vagrant\"" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
# echo "xdebug.start_with_request=no" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
# echo "xdebug.client_port=9003" | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini
# echo "xdebug.client_host=10.0.2.15 " | sudo tee -a /etc/php/7.3/apache2/conf.d/20-xdebug.ini

sudo service apache2 restart

echo 'Install Composer'
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
sudo mv composer.phar /usr/local/bin/composer
RESULT=$?
rm composer-setup.php
exit $RESULT
