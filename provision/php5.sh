#!/bin/bash
sudo apt-get install -y php5 php5-curl php5-gd php5-xmlrpc php5-intl php5-mcrypt php5-cli

sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php5/apache2/php.ini
sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php5/cli/php.ini