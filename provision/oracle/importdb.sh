#!/bin/bash

from=$1 #Nom de la db original
file=$2 #Path i nom dle fitxer
dbname=$3 #Nom de la nova BD
password=$4 #Password de la nova BD

sudo su - oracle --command "sqlplus / as sysdba << EOF
@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catexp.sql
exit;
EOF"

sudo chmod 666 $file

sudo su - oracle --command "imp system/$password@XE fromuser=$from touser=$dbname file=$file"
