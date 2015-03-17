#!/bin/bash

source "/vagrant/provision/functions.sh"

usu=$1
rootdir=$2

mysql_import_db $usu /vagrant_git/agora/sql/intranet_mostra_zk13.sql

mkdir_777 $rootdir/zkdata/$usu
mkdir_777 $rootdir/zkdata/$usu/pnTemp
mkdir_777 $rootdir/zkdata/$usu/pnTemp/purifierCache
