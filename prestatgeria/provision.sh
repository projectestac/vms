#!/bin/bash

source "/vms/provision/functions.sh"

rootdir=/dades/prestatgeria
wwwdir=$rootdir/html
datadir=$rootdir/docs
git=/git/prestatgeria

echo 'Provision Prestatgeria'

mysql_import_db "presta" /git/prestatgeria/sql/presta.sql
mysql_import_db "presta1" /git/prestatgeria/sql/presta1.sql

sudo cp $wwwdir/config/env-config-dist.php $wwwdir/config/env-config.php
sudo cp $wwwdir/config/config-restricted-dist.php $wwwdir/config/config-restricted.php
sudo cp $wwwdir/htaccess.dist $wwwdir/.htaccess

mkdir_777 $rootdir/centres
sudo cp -R $git/centres/* $rootdir/centres
chown_777 $rootdir/centres

mkdir_777 $rootdir/images
sudo cp -R $git/images/* $rootdir/images
chown_777 $rootdir/images

mkdir_777 $rootdir/rss
sudo cp -R $git/rss/* $rootdir/rss
chown_777 $rootdir/rss

mkdir_777 $rootdir/templates_c
sudo cp -R $git/templates_c/* $rootdir/templates_c
chown_777 $rootdir/templates_c

mkdir_777 $rootdir/ztemp
sudo cp -R $git/ztemp/* $rootdir/ztemp
chown_777 $rootdir/ztemp

chown 444 $wwwdir/prestatgeria/config/config.php