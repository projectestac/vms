#!/bin/bash

source "/vms/provision/functions.sh"

host=$1

/vms/provision/oracle-base.sh $host

#http://www.oracle.com/technetwork/articles/technote-php-instant-084410.html

sudo apt-get install -qq php7.3-dev &> /dev/null

cat /etc/profile.d/oracle-env.sh | sudo tee -a /etc/apache2/envvars

echo 'Install OCI8'
echo instantclient,/usr/lib/oracle/12.1/client64/lib | sudo pecl install oci8 &> /dev/null

echo "extension=oci8.so" | sudo tee -a /etc/php/7.3/mods-available/oci8.ini

sudo ln -s /etc/php/7.3/mods-available/oci8.ini /etc/php/7.3/apache2/conf.d/30-oci8.ini
sudo mv /etc/php/7.3/cli/conf.d/ /etc/php/7.3/cli/conf.d_old
sudo ln -s /etc/php/7.3/apache2/conf.d /etc/php/7.3/cli/conf.d

sudo service apache2 restart &> /dev/null
sudo service oracle-xe restart &> /dev/null
