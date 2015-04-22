#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision XTECBlocs'

rootdir=/dades/blocs
wwwdir=$rootdir/src

mkdir_777 $rootdir/blogs.dir
mkdir_777 $rootdir/cache

sudo rm -Rf $wwwdir/wp-content/blogs.dir
sudo ln -s $rootdir/blogs.dir $wwwdir/wp-content/blogs.dir
sudo chmod -R 777 $wwwdir/wp-content/blogs.dir

sudo rm -Rf $wwwdir/wp-content/cache
sudo ln -s $rootdir/cache $wwwdir/wp-content/cache
sudo chmod -R 777 $wwwdir/wp-content/cache

sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess
sudo chmod 664 $wwwdir/.htaccess

sudo cp /vms/xtecblocs/wp-config-vagrant.php $wwwdir/wp-config.php
sudo chmod 664 $wwwdir/wp-config.php

sudo cp /vms/xtecblocs/wp-cache-config.php $wwwdir/wp-content/wp-cache-config.php
sudo chmod 777 $wwwdir/wp-content/wp-cache-config.php

/vms/xtecblocs/create_bloc.sh global
/vms/xtecblocs/create_bloc.sh 0
/vms/xtecblocs/create_bloc.sh 1
/vms/xtecblocs/create_bloc.sh 2

