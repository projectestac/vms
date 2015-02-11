#!/bin/bash

usu=$1
password=$2
rootdir=$3
git=$4

sudo mysql -uroot -p$pass -e "CREATE DATABASE IF NOT EXISTS $usu"
cat $git/sql/intranet_mostra_zk13.sql | mysql -uroot -p$password $usu

sudo mkdir $rootdir/zkdata/$usu
sudo chown -R www-data:www-data $rootdir/zkdata/$usu
sudo chmod -R 777 $rootdir/zkdata/$usu