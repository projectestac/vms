#!/bin/bash

source "/vagrant/provision/functions.sh"

usu=$1
password=$2
rootdir=$3
template=master$4
datadir=$rootdir/docs

mysql_import_db $usu $password /vagrant_git/agora/sql/$template.sql

mkdir_777 $datadir/wpdata/$usu

pushd $datadir/wpdata/$usu
sudo unzip /vagrant_git/agora/sql/$template.zip
popd