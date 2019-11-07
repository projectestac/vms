#!/bin/bash

source "/vms/provision/functions.sh"

usu=$1
rootdir=$2
datadir=$rootdir/data

#php $rootdir/html/moodle2/admin/cli/install_database.php --ccentre=$usu --agree-license --shortname=$usu --fullname="Àgora $usu" --adminuser=xtecadmin --adminpass=$password

oracle_import_db usu1 /vms/agora/usu1.dmp $usu

mkdir_777 $rootdir/cache_ins/$usu
mkdir_777 $datadir/moodle2/$usu

pushd $datadir/moodle2/$usu
sudo tar xfzp /vms/agora/usu1.tgz
popd

sudo -E php /dades/agora/html/moodle2/local/agora/scripts/cli.php -s=script_enable_service --ccentre=$usu --password=6142bfd56a583d891f0b1dcdbb2a9ef8 --clientName="$usu VM dev" --clientCode=$usu --clientAddress=Test --clientCity=ciutat --clientDNS=$usu
