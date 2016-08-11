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
    sudo sed -i "s#DocumentRoot .*#DocumentRoot "$wwwdir"#" /etc/apache2/sites-available/000-default.conf
    sudo sed -i "s#<Directory /var/www/>#<Directory "$wwwdir">#" /etc/apache2/sites-available/000-default.conf
    sudo sed -i "s#DocumentRoot .*#DocumentRoot "$wwwdir"#" /etc/apache2/sites-available/default-ssl.conf
    sudo sed -i "s#<Directory /var/www/>#<Directory "$wwwdir">#" /etc/apache2/sites-available/default-ssl.conf
    sudo service apache2 restart &> /dev/null

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
    sudo service apache2 restart &> /dev/null

    save_version 2015042301
fi

if [ "$version" -lt 2015042400 ]; then
    sudo sed -i '/^.*open_basedir/ s/$/:\/tmp\//' /etc/apache2/conf-available/phpmyadmin.conf

    save_version 2015042400
fi


if [ "$version" -lt 2015042900 ]; then
    sudo sed -i "s#opcache.memory_consumption=.*#opcache.memory_consumption=256#" /etc/php/5.6/mods-available/opcache.ini
    sudo service apache2 restart &> /dev/null

    save_version 2015042900
fi

if [ "$version" -lt 2015042901 ]; then
    sudo sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php/5.6/apache2/php.ini
    sudo sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php/5.6/cli/php.ini
    sudo service apache2 restart &> /dev/null

    save_version 2015042901
fi


if [ "$version" -lt 2015043000 ]; then
    mkdir_777 /dades/agora/docs/ubr_uploads/
    mkdir_777 /dades/agora/docs/ubr_uploads/tmp/


    echo "Configure CGI"
    sudo sed -i "s#ScriptAlias /cgi-bin/ .*#ScriptAlias /cgi-bin/ /dades/agora/cgi/#" /etc/apache2/sites-available/000-default.conf
    sudo sed -i "s#<Directory \"/usr/lib/cgi-bin\">#<Directory \"/dades/agora/cgi\">#" /etc/apache2/sites-available/000-default.conf
    sudo sed -i "s#ScriptAlias /cgi-bin/ .*#ScriptAlias /cgi-bin/ /dades/agora/cgi/#" /etc/apache2/sites-available/default-ssl.conf
    sudo sed -i "s#<Directory \"/usr/lib/cgi-bin\">#<Directory \"/dades/agora/cgi\">#" /etc/apache2/sites-available/default-ssl.conf

    sudo service apache2 restart

    save_version 2015043000
fi

if [ "$version" -lt 2015052000 ]; then
    echo 'Install Tidy PHP'
    sudo apt-get install -y --force-yes php5.6-tidy &> /dev/null

    save_version 2015052000
fi


if [ "$version" -lt 2015052001 ]; then
    echo 'Install Xdebug for PHP'
    sudo apt-get install -y php5.6-xdebug &> /dev/null
    echo "xdebug.default_enable=1" | sudo tee -a /etc/php/5.6/apache2/conf.d/20-xdebug.ini
    echo "xdebug.idekey=\"vagrant\"" | sudo tee -a /etc/php/5.6/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_enable=1" | sudo tee -a /etc/php/5.6/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_autostart=0" | sudo tee -a /etc/php/5.6/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_port=9000" | sudo tee -a /etc/php/5.6/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_handler=dbgp" | sudo tee -a /etc/php/5.6/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_host=10.0.2.2 " | sudo tee -a /etc/php/5.6/apache2/conf.d/20-xdebug.ini

    save_version 2015052001
fi

if [ "$version" -lt 2015061000 ]; then
    chmod +x /dades/agora/html/config/sync.sh /dades/agora/html/config/sync-config.sh

    save_version 2015061000
fi

if [ "$version" -lt 2015061000 ]; then
    chmod +x /dades/agora/html/config/sync.sh /dades/agora/html/config/sync-config.sh

    save_version 2015061000
fi

if [ "$version" -lt 2015101600 ]; then
    sudo cp /vms/xtecblocs/wp-cache-config.php /dades/blocs/src/wp-content/wp-cache-config.php

    save_version 2015101600
fi

if [ "$version" -lt 2015110202 ]; then
    sudo su - oracle --command "sqlplus -S / as sysdba << EOM
ALTER PROFILE default LIMIT PASSWORD_LIFE_TIME UNLIMITED;
exit;
EOM"

    sudo su - oracle --command "sqlplus -S / as sysdba << EOM
ALTER PROFILE MONITORING_PROFILE LIMIT PASSWORD_LIFE_TIME UNLIMITED;
exit;
EOM"

    save_version 2015110202
fi

if [ "$version" -lt 2015112300 ]; then
    sudo sed -i 's/\[mysqld\]/\[mysqld\]\nwait_timeout = 100\nmax_connections=500/g' /etc/mysql/my.cnf

    save_version 2015112300
fi


if [ "$version" -lt 2015121000 ]; then
    sudo su - oracle --command "sqlplus -S sys/agora as sysdba << EOM
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
ALTER USER usu1 IDENTIFIED BY agora;
ALTER USER usu1 ACCOUNT UNLOCK;
ALTER USER usu2 IDENTIFIED BY agora;
ALTER USER usu2 ACCOUNT UNLOCK;
ALTER USER usu3 IDENTIFIED BY agora;
ALTER USER usu3 ACCOUNT UNLOCK;
ALTER USER usu4 IDENTIFIED BY agora;
ALTER USER usu4 ACCOUNT UNLOCK;
ALTER USER odissea IDENTIFIED BY agora;
ALTER USER odissea ACCOUNT UNLOCK;
exit;
EOM"

    save_version 2015121000
fi



echo 'All updated!'
