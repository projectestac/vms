#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Dossier'

rootdir=/dades/dossier
wwwdir=$rootdir/html

sudo chmod -R 664 $wwwdir

mkdir_777 $rootdir/uploads
mkdir_777 $rootdir/cache

sudo rm -Rf $wwwdir/wp-content/uploads
sudo ln -s $rootdir/uploads $wwwdir/wp-content/uploads
sudo unzip /git/dossier/sql/files.zip -d $rootdir/uploads/
sudo chmod -R 777 $wwwdir/wp-content/uploads

sudo rm -Rf $wwwdir/wp-content/cache
sudo ln -s $rootdir/cache $wwwdir/wp-content/cache
sudo chmod -R 777 $wwwdir/wp-content/cache

sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess
sudo chmod 664 $wwwdir/.htaccess

sudo cp $wwwdir/wp-config-dist.php $wwwdir/wp-config.php
sudo chmod 664 $wwwdir/wp-config.php

sudo cp $wwwdir/wp-content/wp-cache-config-dist.php $wwwdir/wp-content/wp-cache-config.php
sudo chmod 777 $wwwdir/wp-content/wp-cache-config.php

/vms/dossier/import_db.sh global
/vms/dossier/import_db.sh 0
/vms/dossier/import_db.sh 1
/vms/dossier/import_db.sh 2

