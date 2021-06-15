#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Àgora'

rootdir=/dades
wwwdir=$rootdir/html
datadir=$rootdir/data
localdatadir=$rootdir/localdata
git=/git/agora

# Portal
create_mysql_db "adminagora"
cat "$git/sql/adminagora.sql" | sudo mysql -uroot -p"$pass" adminagora &> /dev/null

chmod 444 $wwwdir/portal/config/config.php

# Data docs
mkdir_777 $datadir
sudo cp -R $git/data/* $datadir
chown_777 $datadir

mkdir_777 $localdatadir/syncdata
mkdir_777 $localdatadir/localmuc

# Program local crons
sudo cp $git/crons/moodle_webserver /etc/cron.d/
sudo sed -i "s/www-data/apache/" /etc/cron.d/moodle_webserver

sudo cp $wwwdir/config/.htaccess-dist $wwwdir/config/.htaccess
sudo cp $wwwdir/config/env-config-dist.php $wwwdir/config/env-config.php
sudo cp $wwwdir/config/sync-config-dist.sh $wwwdir/config/sync-config.sh
chmod +x $wwwdir/config/sync.sh $wwwdir/config/sync-config.sh
htpasswd -nbB xtecadmin "$pass" > $wwwdir/config/.htpasswd
sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess

# Set password
sudo sed -i "s/\['userpwd'\] = ''/\['userpwd'\] = '$pass'/" $wwwdir/config/env-config.php
sudo sed -i "s/\['password'\] = ''/\['password'\] = '$passmd5'/" $wwwdir/config/env-config.php

# Update wordpress/.htaccess if it exists (vagrant up using existing code)
if [ -f "$wwwdir/wordpress/.htaccess" ]; then sudo chmod 666 $wwwdir/wordpress/.htaccess; fi
sudo cp $wwwdir/wordpress/.htaccess-dist $wwwdir/wordpress/.htaccess
chmod 444 $wwwdir/wordpress/.htaccess

# Create the sites
/vms/agora/create_moodle.sh usu1 usu1 $rootdir pri
/vms/agora/create_moodle.sh usu2 usu2 $rootdir sec
/vms/agora/create_moodle.sh usu3 usu3 $rootdir pri
/vms/agora/create_moodle.sh usu4 usu4 $rootdir sec

/vms/agora/create_nodes.sh usu1 usu1 $rootdir pri usu6
/vms/agora/create_nodes.sh usu2 usu2 $rootdir sec usu7
/vms/agora/create_nodes.sh usu3 usu3 $rootdir cfa usu8
/vms/agora/create_nodes.sh usu4 usu4 $rootdir eoi usu9
/vms/agora/create_nodes.sh usu5 centre-5 $rootdir zer usu10
/vms/agora/create_nodes.sh usu6 centre-6 $rootdir creda usu11
/vms/agora/create_nodes.sh usu7 centre-7 $rootdir cda usu4
/vms/agora/create_nodes.sh usu8 centre-8 $rootdir ssee usu5
/vms/agora/create_nodes.sh usu9 centre-9 $rootdir pro usu3

# Copy index file
cp /vms/web/index.php /$wwwdir

# Finish installing portal
mkdir_777 $datadir/portaldata
mkdir_777 $datadir/portaldata/pnTemp
mkdir_777 $datadir/portaldata/pnTemp/purifierCache
mkdir_777 $datadir/portaldata/pnTemp/view_cache
mkdir_777 $datadir/portaldata/pnTemp/Theme_cache
mkdir_777 $datadir/portaldata/data
mkdir_777 $datadir/portaldata/data/nodes
mkdir_777 $datadir/portaldata/data/moodle2
sudo cp /git/agora/sql/master*.sql $datadir/portaldata/data/nodes
sudo cp /git/agora/sql/master*.zip $datadir/portaldata/data/nodes
mkdir_777 $datadir/moodledata/usu1/repository
mkdir_777 $datadir/moodledata/usu1/repository/files
