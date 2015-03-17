#!/bin/bash

source "/vagrant/provision/functions.sh"

usu=$1
rootdir=$2
template=master$3
datadir=$rootdir/docs

mysql_import_db $usu /vagrant_git/agora/sql/$template.sql

mkdir_777 $datadir/wpdata/$usu

pushd $datadir/wpdata/$usu
sudo unzip -q /vagrant_git/agora/sql/$template.zip
popd