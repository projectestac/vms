#!/bin/bash

source "/vms/provision/functions.sh"

usu=$1
nompropi=$2
rootdir=$3
template=master$4
dump=masternodes$4
domain=$6
datadir=$rootdir/data/wpdata
passbcrypt=$(htpasswd -bnBC 10 "" $pass | tr -d ':\n')

# set -x

mysql_import_db "$usu" "/git/agora/dump/$dump.sql"

mkdir_777 "$datadir/$usu"

pushd "$datadir/$usu" > /dev/null || exit
sudo unzip -q "/git/agora/dump/$dump.zip"
chmod -R 777 "$datadir/$usu/"
popd > /dev/null || exit

sudo -E php /dades/html/wordpress/wp-includes/xtec/scripts/cli.php \
                -s=script_enable_service \
                --ccentre="$nompropi" \
                --password="$passbcrypt" \
                --xtecadminPassword="$passbcrypt" \
                --clientName="$usu VM dev" \
                --clientCode="$usu" \
                --clientAddress=Address \
                --clientCity=City \
                --clientDNS="$nompropi" \
                --clientPC=00000 \
                --origin_url="://$domain/$template/" \
                --origin_bd="$5"

# set +x
