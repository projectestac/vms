#!/bin/bash
#Script d'actualització de la MV

source "/vms/provision/functions.sh"

echo "Upgrade VM"

load_version

if [ "$version" -lt 2015042201 ]; then
    echo 'Upgrade example'
    #Put here the code
    save_version 2015042201
fi

if [ "$version" -lt 2015042204 ]; then
    wwwdir=/vms/web
    sudo sed -i "s#DocumentRoot .*#DocumentRoot "$wwwdir"#" /etc/apache2/sites-available/default
    sudo sed -i "s#<Directory /var/www/>#<Directory "$wwwdir">#" /etc/apache2/sites-available/default
    sudo sed -i "s#DocumentRoot .*#DocumentRoot "$wwwdir"#" /etc/apache2/sites-available/default-ssl
    sudo sed -i "s#<Directory /var/www/>#<Directory "$wwwdir">#" /etc/apache2/sites-available/default-ssl
    sudo service apache2 restart > /dev/null

    save_version 2015042204
fi



#Don't forget to write the latest version on provision.sh

echo 'All updated!'
