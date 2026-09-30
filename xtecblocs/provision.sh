#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision XTECBlocs'

rootdir=/dades/blocs
wwwdir=$rootdir/html

mkdir_777 $rootdir/blogs.dir

sudo rm -Rf $wwwdir/wp-content/blogs.dir
sudo ln -s $rootdir/blogs.dir $wwwdir/wp-content/blogs.dir

sudo cp $wwwdir/.htaccess-dist $wwwdir/.htaccess

sudo cp $wwwdir/wp-config-dist.php $wwwdir/wp-config.php

/vms/xtecblocs/create_bloc.sh global
/vms/xtecblocs/create_bloc.sh 0
/vms/xtecblocs/create_bloc.sh 1
/vms/xtecblocs/create_bloc.sh 2
