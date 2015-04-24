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

if [ "$version" -lt 2015042205 ]; then
    wget http://agora/agora/usu1/intranet/upgradeModules.php -O /dev/null -o /dev/null
    wget http://agora/agora/usu2/intranet/upgradeModules.php -O /dev/null -o /dev/null
    wget http://agora/agora/usu3/intranet/upgradeModules.php -O /dev/null -o /dev/null
    wget http://agora/agora/usu4/intranet/upgradeModules.php -O /dev/null -o /dev/null

    save_version 2015042205
fi

if [ "$version" -lt 2015042301 ]; then
    chmod +x /vms/mps/provision.sh
    sudo cp -R /vms/provision/php/mps.conf /etc/apache2/sites-agora/mps.conf
    sudo /vms/mps/provision.sh
    sudo service apache2 restart > /dev/null

    save_version 2015042301
fi

if [ "$version" -lt 2015042400 ]; then
    sudo sed -i '/^[ ]*/ s/$/:\/tmp\//' /etc/apache2/conf.d/phpmyadmin.conf

    save_version 2015042400
fi


#Don't forget to write the latest version on provision.sh

echo 'All updated!'
