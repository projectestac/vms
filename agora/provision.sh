#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Àgora'

rootdir=/dades
wwwdir=$rootdir/html
datadir=$rootdir/data
localdatadir=$rootdir/localdata
git=/git/agora

# Laravel-based Portal
create_mysql_db "portal"

cp $wwwdir/portal/.env.example $wwwdir/portal/.env
sudo sed -i "s/DB_PASSWORD=/DB_PASSWORD=agora/" $wwwdir/portal/.env

pushd $wwwdir/portal > /dev/null || exit
sudo /usr/bin/bash -c "php artisan key:generate" &> /dev/null
sudo /usr/bin/bash -c "php artisan migrate:fresh --seed" &> /dev/null
sudo /usr/bin/bash -c "php artisan optimize:clear" &> /dev/null
sudo /usr/bin/bash -c "php artisan config:cache" &> /dev/null
popd > /dev/null || exit

# Data docs
mkdir_777 $datadir
sudo cp -R $git/data/* $datadir
chown_777 $datadir

# Temporal directory for uploading large files.
mkdir_777 $datadir/portaldata/tmp

mkdir_777 $localdatadir/syncdata
mkdir_777 $localdatadir/localmuc

# Program local crons
sudo cp $git/crons/moodle_webserver /etc/cron.d/

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
/vms/agora/create_moodle.sh usu1 centre-1 $rootdir pri
/vms/agora/create_moodle.sh usu2 centre-2 $rootdir sec
/vms/agora/create_moodle.sh usu3 centre-3 $rootdir pri
/vms/agora/create_moodle.sh usu4 centre-4 $rootdir sec

/vms/agora/create_nodes.sh usu1 centre-1 $rootdir pri usu6
/vms/agora/create_nodes.sh usu2 centre-2 $rootdir sec usu7
/vms/agora/create_nodes.sh usu3 centre-3 $rootdir cfa usu8
/vms/agora/create_nodes.sh usu4 centre-4 $rootdir eoi usu9
/vms/agora/create_nodes.sh usu5 centre-5 $rootdir zer usu10
/vms/agora/create_nodes.sh usu6 centre-6 $rootdir creda usu11
/vms/agora/create_nodes.sh usu7 centre-7 $rootdir cda usu4
/vms/agora/create_nodes.sh usu8 centre-8 $rootdir ssee usu5
/vms/agora/create_nodes.sh usu9 centre-9 $rootdir pro usu3

# Copy index file
cp /vms/web/index.php /$wwwdir

# Finish installing portal
mkdir_777 $datadir/portaldata
mkdir_777 $datadir/portaldata/data
mkdir_777 $datadir/portaldata/data/nodes
sudo cp /git/agora/dump/masternodes*.sql $datadir/portaldata/data/nodes
sudo cp /git/agora/dump/masternodes*.zip $datadir/portaldata/data/nodes
mkdir_777 $datadir/portaldata/data/moodle
sudo cp /git/agora/dump/mastermoodle*.sql $datadir/portaldata/data/moodle
sudo cp /git/agora/dump/mastermoodle*.zip $datadir/portaldata/data/moodle
mkdir_777 $datadir/portaldata/data/moodle2
mkdir_777 $datadir/moodledata/usu1/repository/files
mkdir_777 $datadir/moodledata/usu2/repository/files
mkdir_777 $datadir/moodledata/usu3/repository/files
mkdir_777 $datadir/moodledata/usu4/repository/files
