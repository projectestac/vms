#!/usr/bin/env bash

source "/vagrant/provision/functions.sh"

rootdir=/dades/odissea
wwwdir=$rootdir/html
datadir=$rootdir/docs
git=/vagrant_git/odissea
pass=agora
dbname=odissea

echo 'Data Provisioning'

#Data docs
mkdir_777 $datadir

sudo cp /vagrant/odissea/config.php $wwwdir/config.php
chown_777 $wwwdir/local/agora/muc

sudo su - oracle --command "sqlplus / as sysdba << EOF
@/dades/odissea/html/lib/dml/oci_native_moodle_package.sql
exit;
EOF"

sudo su - oracle --command "sqlplus / as sysdba << EOF
CREATE USER $dbname IDENTIFIED BY $pass DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;
GRANT ALL PRIVILEGES TO $dbname;
GRANT execute ON DBMS_LOCK to $dbname;
exit;
EOF"

#oracle_import_db usu1 /vagrant/odissea/odissea.dmp $dbname $pass

#pushd $datadir
#sudo tar xfzp /vagrant/odissea/data.tgz
#popd

