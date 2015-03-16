#!/bin/bash

source "/vagrant/provision/functions.sh"

rootdir=/dades/blocs
wwwdir=$rootdir/src
pass=agora

mkdir_777 $rootdir/blogs.dir
mkdir_777 $rootdir/cache

sudo rm -Rf $wwwdir/wp-content/blogs.dir
sudo ln -s $rootdir/blogs.dir $wwwdir/wp-content/blogs.dir

sudo rm -Rf $wwwdir/wp-content/cache
sudo ln -s $rootdir/cache $wwwdir/wp-content/cache

sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess
sudo cp $wwwdir/wp-config.dist.php $wwwdir/wp-config.php
#sudo cp $wwwdir/wp-content/wp-cache-config.php $wwwdir/wp-content/wp-cache-config.php

sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS xtec_blocs_global"

/vagrant/xtecblocs/create_bloc.sh 1 $pass

