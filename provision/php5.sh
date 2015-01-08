#!/bin/bash
sudo apt-get install -y php5 php5-curl php5-gd php5-xmlrpc php5-intl php5-mcrypt php5-cli

sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php5/apache2/php.ini
sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php5/cli/php.ini

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sudo sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini

