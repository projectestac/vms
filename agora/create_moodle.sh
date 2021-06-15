#!/bin/bash

source "/vms/provision/functions.sh"

usu=$1
nompropi=$2
rootdir=$3
template=mastermoodle$4
datadir=$rootdir/data

export PGPASSWORD=$pass

psql -U postgres -h localhost -c "CREATE USER $usu WITH ENCRYPTED PASSWORD '$pass';" &> /dev/null
psql -U postgres -h localhost -c "ALTER ROLE $usu Superuser;" &> /dev/null
psql -U postgres -h localhost -c "CREATE DATABASE $usu OWNER $usu LC_COLLATE ='ca_ES.UTF-8' LC_CTYPE = 'ca_ES.UTF-8' TEMPLATE template0;" &> /dev/null
psql -U "$usu" -h localhost -d "$usu" -1 -f "/vms/agora/$template.sql" &> /dev/null

mkdir_777 "$datadir/moodledata/$usu"
pushd "$datadir/moodledata/$usu" > /dev/null || exit
sudo unzip -q "/vms/agora/$template.zip"
popd > /dev/null || exit
chmod -R 777 "$datadir/moodledata/$usu"

sudo -E php /dades/html/moodle2/local/agora/scripts/cli.php \
                -s=script_enable_service \
                --ccentre="$nompropi" \
                --password="$passmd5" \
                --xtecadminPassword="$passmd5" \
                --clientName="$usu VM dev" \
                --clientCode="$usu" \
                --clientAddress=Address \
                --clientCity=City \
                --clientDNS="$nompropi"
