#!/bin/bash

usu=$1
password=$2
rootdir=$3
datadir=$rootdir/docs

/vagrant/provision/importdb.sh usu1 /vagrant/agora/usu1.dmp $usu $password

sudo mkdir $rootdir/cache_ins/$usu
sudo chmod -R 777 $rootdir/cache_ins/$usu
sudo mkdir $datadir/$usu
sudo chmod -R 777 $datadir/$usu