#!/bin/bash

wwwdir=$1

sudo apt-get install -y apache2

if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -s $wwwdir /var/www/html
fi

sudo service apache2 restart