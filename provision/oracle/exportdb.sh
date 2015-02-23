#!/bin/bash

dbname=$1
password=$2


sudo su - oracle --command "sqlplus / as sysdba << EOF
@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catexp.sql
exit;
EOF"


sudo su - oracle --command "exp system/$password@XE owner=$dbname file=/tmp/$dbname.dmp log=/tmp/logfile.log"

sudo cp /tmp/$dbname.dmp /vagrant/agora/$dbname.dmp

sudo chmod 666 /vagrant/agora/$dbname.dmp