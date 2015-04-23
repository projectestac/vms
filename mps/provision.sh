#!/bin/bash

source "/vms/provision/functions.sh"

rootdir=/dades/mps
wwwdir=$rootdir/src
datadir=$rootdir/docs
git=/git/mps

echo 'Provision MPS'

mysql_import_db "mps" /vms/mps/mps.sql

mkdir_777 $rootdir/mpsdata

sudo cp /vms/mps/config.php $rootdir/config.php