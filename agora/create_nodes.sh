#!/bin/bash

source "/vms/provision/functions.sh"

usu=$1
rootdir=$2
template=master$3
datadir=$rootdir/docs

mysql_import_db $usu /git/agora/sql/$template.sql

mkdir_777 $datadir/wpdata/$usu

pushd $datadir/wpdata/$usu
sudo unzip -q /git/agora/sql/$template.zip
popd

sudo -E php /dades/agora/html/wordpress/wp-includes/xtec/scripts/cli.php -s=script_enable_service --ccentre=$usu --password=6142bfd56a583d891f0b1dcdbb2a9ef8 --clientName="$usu VM dev" --clientCode=$usu --clientAddress=Test clientCity=ciutat --clientDNS=$usu --clientPC=000000 --URLNodesModelBase=http://pwc-int.educacio.intranet/agora/master --shortcodes=cfa,pri,sec,zer --DBNodesModel=usu6,usu7,usu8,usu9,usu10