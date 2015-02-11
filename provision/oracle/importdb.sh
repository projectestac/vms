#!/bin/bash

from=$1 #Nom de la db original
file=$2 #Path i nom dle fitxer
dbname=$3 #Nom de la nova BD
password=$4 #Password de la nova BD




sudo su - oracle --command "sqlplus / as sysdba << EOF
CREATE USER $dbname IDENTIFIED BY $password DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;
GRANT ALL PRIVILEGES TO $dbname;
GRANT execute ON DBMS_LOCK to $dbname;
@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catexp.sql
exit;
EOF"


sudo su - oracle --command "imp system/$password@XE fromuser=$from touser=$dbname file=$file"
