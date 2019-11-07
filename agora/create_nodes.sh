#!/bin/bash

source "/vms/provision/functions.sh"

usu=$1
nompropi=$2
rootdir=$3
template=master$4
datadir=$rootdir/data/wpdata

mysql_import_db $usu /git/agora/sql/$template.sql

mkdir_777 $datadir/$usu

pushd $datadir/$usu
sudo unzip -q /git/agora/sql/$template.zip
chmod -R 777 $datadir/$usu/
popd

sudo -E php /dades/agora/html/wordpress/wp-includes/xtec/scripts/cli.php -s=script_enable_service --ccentre=$nompropi --password=6142bfd56a583d891f0b1dcdbb2a9ef8 --clientName="$usu VM dev" --clientCode=$usu --clientAddress=Test clientCity=ciutat --clientDNS=$nompropi --clientPC=000000 --origin_url=http://pwc-int.educacio.intranet/agora/$template/ --origin_bd=$5
