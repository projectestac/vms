#!/bin/bash

rootdir=/dades/xtecblocs
wwwdir=$rootdir/html
pass=agora
dbname=xtecblocs
git=/vagrant_git

/vagrant/provision/base.sh
/vagrant/provision/php5.sh $wwwdir
/vagrant/provision/memcache.sh
/vagrant/provision/mysql.sh $pass

sudo mkdir $rootdir/blogs.dir
sudo chown -R www-data:www-data $rootdir/blogs.dir
sudo chmod -R 777 $rootdir/blogs.dir

sudo mkdir $rootdir/cache
sudo chown -R www-data:www-data $rootdir/cache
sudo chmod -R 777 $rootdir/cache

sudo rm -Rf $wwwdir/wp-content/blogs.dir
sudo ln -s $rootdir/blogs.dir $wwwdir/wp-content/blogs.dir

sudo rm -Rf $wwwdir/wp-content/cache
sudo ln -s $rootdir/cache $wwwdir/wp-content/cache

sudo cp $wwwdir/htaccess.dist $wwwdir/.htaccess
sudo cp $wwwdir/wp-config.dist.php $wwwdir/wp-config.php
#sudo cp $wwwdir/wp-content/wp-cache-config.php $wwwdir/wp-content/wp-cache-config.php



