#!/bin/bash

source "/vagrant/provision/functions.sh"

rootdir=/dades/prestatgeria
wwwdir=$rootdir/html
datadir=$rootdir/docs
git=/vagrant_git/prestatgeria


echo 'Provision Prestatgeria'

mysql_import_db "presta" /vagrant/prestatgeria/presta.sql