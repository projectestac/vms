#!/bin/bash

wwwdir=$1

sudo apt-get install -y apache2

if ! [ -L /var/www/html ]; then
  sudo rm -rf /var/www/html
  sudo ln -s $wwwdir /var/www/html
fi

sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2ensite default-ssl

sudo service apache2 restart

sudo chmod -R 777 /var/log