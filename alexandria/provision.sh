#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Alexandria'

rootdir=/dades
wwwdir=$rootdir/html
datadir=$rootdir/data
localdatadir=$rootdir/localdata
git=/git/alexandria
dbuser=alexandria
dbname=alexandria
pass=agora

export PGPASSWORD=$pass

psql -U postgres -h localhost -c "CREATE USER $dbuser WITH ENCRYPTED PASSWORD '$pass';" &> /dev/null
psql -U postgres -h localhost -c "ALTER ROLE $dbuser Superuser;" &> /dev/null
psql -U postgres -h localhost -c "CREATE DATABASE $dbuser OWNER $dbuser LC_COLLATE ='ca_ES.UTF-8' LC_CTYPE = 'ca_ES.UTF-8' TEMPLATE template0;" &> /dev/null
psql -U $dbuser -h localhost -d $dbuser -1 -f $git/dump/alexandria-38-pg.sql &> /dev/null

mkdir_777 $datadir
mkdir_777 $localdatadir

sudo cp /vms/alexandria/config.php $wwwdir/config.php

pushd $datadir
sudo tar xfzp $git/dump/alexandriadata.tar.gz
sudo chmod -R 777 .
popd
