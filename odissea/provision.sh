#!/bin/bash

source "/vagrant/provision/functions.sh"

echo 'Provision Odissea'

rootdir=/dades/odissea
wwwdir=$rootdir/html/moodle2
datadir=$rootdir/docs
dbname=odissea

#Data docs
mkdir_777 $datadir

sudo cp /vagrant/odissea/config.php $wwwdir/config.php
chown_777 $wwwdir/local/agora/muc
mkdir_777 $rootdir/cache_ins

#execute_in_oracle "@/dades/odissea/html/moodle2/lib/dml/oci_native_moodle_package.sql"

oracle_import_db odissea /vagrant/odissea/odissea.dmp $dbname

pushd $datadir
sudo tar xfzp /vagrant/odissea/data.tgz
popd

