#!/bin/bash

source "/vms/provision/functions.sh"

rootdir=/dades/prestatgeria
wwwdir=$rootdir/html
datadir=$rootdir/docs
git=/git/prestatgeria


echo 'Provision Prestatgeria'

mysql_import_db "presta" /vms/prestatgeria/presta.sql