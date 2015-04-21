#!/bin/bash

source "/vagrant/provision/functions.sh"

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

sudo cp $wwwdir/wp-config-dist.php $wwwdir/wp-config.php
sudo chmod 664 $wwwdir/wp-config.php

sudo cp /vagrant/xtecblocs/wp-cache-config.php $wwwdir/wp-content/wp-cache-config.php
sudo chmod 777 $wwwdir/wp-content/wp-cache-config.php

mysql_import_db "xtec_blocs_global" /vagrant_git/xtecblocs/sql/xtec_blocs_global.sql

/vagrant/xtecblocs/create_bloc.sh 3

