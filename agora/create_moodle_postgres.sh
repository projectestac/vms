#!/bin/bash

source "/vms/provision/functions.sh"

usu=$1
pass=agora
rootdir=$2
datadir=$rootdir/data

export PGPASSWORD=$pass

psql -U postgres -h localhost -c "CREATE USER $usu WITH ENCRYPTED PASSWORD '$pass';" &> /dev/null
psql -U postgres -h localhost -c "ALTER ROLE $usu Superuser;" &> /dev/null
psql -U postgres -h localhost -c "CREATE DATABASE $usu OWNER $usu LC_COLLATE ='ca_ES.UTF-8' LC_CTYPE = 'ca_ES.UTF-8' TEMPLATE template0;" &> /dev/null
psql -U $usu -h localhost -d $usu -1 -f /vms/agora/usu1-moodle.sql &> /dev/null

mkdir_777 $datadir/moodledata/$usu

pushd $datadir/moodledata/$usu
sudo tar xfzp /vms/agora/usu1.tgz
popd

sudo -E php /dades/agora/html/moodle2/local/agora/scripts/cli.php -s=script_enable_service --ccentre=$usu --password=6142bfd56a583d891f0b1dcdbb2a9ef8 --clientName="$usu VM dev" --clientCode=$usu --clientAddress=Test --clientCity=ciutat --clientDNS=$usu
