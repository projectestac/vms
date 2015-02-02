#!/bin/bash

wwwdir=$1

sudo add-apt-repository -y ppa:ondrej/php5-oldstable

sudo apt-get update

sudo apt-get install -y --force-yes apache2 php5 php5-curl php5-gd php5-xmlrpc php5-intl php5-mcrypt php5-cli

#Apache Configuration
if ! [ -L /var/www ]; then
  sudo rm -rf /var/www
  sudo ln -s $wwwdir /var/www
fi

sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2ensite default-ssl

#PHP Configuration
sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php5/apache2/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php5/apache2/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php5/apache2/php.ini

sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php5/cli/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/cli/php.ini
sudo sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini

sudo service apache2 restart
