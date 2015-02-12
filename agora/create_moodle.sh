#!/bin/bash

usu=$1
password=$2
rootdir=$3
datadir=$rootdir/docs

sudo su - oracle --command "sqlplus / as sysdba << EOF
CREATE USER $usu IDENTIFIED BY $password DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;
GRANT ALL PRIVILEGES TO $usu;
GRANT execute ON DBMS_LOCK to $usu;
exit;
EOF"

#php $rootdir/html/moodle2/admin/cli/install_database.php --ccentre=$usu --agree-license --shortname=$usu --fullname="Àgora $usu" --adminuser=xtecadmin --adminpass=$password

#/vagrant/provision/oracle/importdb.sh usu1 /vagrant/agora/usu1.dmp $usu $password

sudo mkdir $rootdir/cache_ins/$usu
sudo chown -R www-data:www-data $rootdir/cache_ins/$usu
sudo chmod -R 777 $rootdir/cache_ins/$usu


sudo mkdir $datadir/moodle2/$usu
sudo chown -R www-data:www-data $datadir/moodle2/$usu
sudo chmod -R 777 $datadir/moodle2/$usu
