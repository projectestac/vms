#!/bin/bash

usu=$1
password=$2
rootdir=$3
datadir=$rootdir/docs

/vagrant/provision/oracle/importdb.sh usu1 /vagrant/agora/usu1.dmp $usu $password

sudo mkdir $rootdir/cache_ins/$usu
sudo chown -R www-data:www-data $rootdir/cache_ins/$usu
sudo chmod -R 777 $rootdir/cache_ins/$usu


sudo mkdir $datadir/$usu
sudo chown -R www-data:www-data $datadir/$usu
sudo chmod -R 777 $datadir/$usu
