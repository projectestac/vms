#!/bin/bash

source "/vms/provision/functions.sh"

usu=$1
rootdir=$2

mysql_import_db $usu /git/agora/sql/intranet_mostra_zk13.sql

mkdir_777 $rootdir/zkdata/$usu
mkdir_777 $rootdir/zkdata/$usu/pnTemp
mkdir_777 $rootdir/zkdata/$usu/pnTemp/purifierCache

wget http://agora/agora/$usu/intranet/upgradeModules.php -O /dev/null -o /dev/null
