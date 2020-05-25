#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Alexandria'

dbname=alexandria
dbuser=alexandria
pass=agora
basedir=/dades
wwwdir=/dades/html
datadir=/dades/data
localdatadir=/dades/localdata
git=/git/alexandria

export PGPASSWORD=$pass

psql -U postgres -h localhost -c "CREATE USER $dbuser WITH ENCRYPTED PASSWORD '$pass';" &> /dev/null
psql -U postgres -h localhost -c "ALTER ROLE $dbuser Superuser;" &> /dev/null
psql -U postgres -h localhost -c "CREATE DATABASE $dbuser OWNER $dbuser LC_COLLATE ='ca_ES.UTF-8' LC_CTYPE = 'ca_ES.UTF-8' TEMPLATE template0;" &> /dev/null
psql -U $dbuser -h localhost -d $dbuser -1 -f $git/dump/alexandria-38-pg.sql &> /dev/null

mkdir_777 $localdatadir
chown_777 $localdatadir

pushd $basedir
sudo tar xfzp $git/dump/moodledata.tar.gz
popd
chmod -R 777 $datadir

sudo cp /vms/alexandria/config.php $wwwdir/config.php
