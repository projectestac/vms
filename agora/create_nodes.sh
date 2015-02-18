#!/bin/bash

usu=$1
password=$2
rootdir=$3
template=master$4
datadir=$rootdir/docs

sudo mysql -uroot -p$password -e "CREATE DATABASE IF NOT EXISTS $usu"
cat /vagrant_git/sql/$template.sql | sudo mysql -uroot -p$password $usu

sudo mkdir $datadir/wpdata/$usu
sudo chown -R www-data:www-data $datadir/wpdata/$usu
sudo chmod -R 777 $datadir/wpdata/$usu
pushd $datadir/wpdata/$usu
sudo unzip /vagrant_git/sql/$template.zip
popd