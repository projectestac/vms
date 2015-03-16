#!/bin/bash

function oracle_import_db {
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

}

function oracle_export_db {
    dbname=$1
    password=$2
    destination=$3

    sudo su - oracle --command "sqlplus / as sysdba << EOF
    @/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catexp.sql
    exit;
    EOF"

    sudo su - oracle --command "exp system/$password@XE owner=$dbname file=/tmp/$dbname.dmp log=/tmp/logfile.log"
    sudo cp /tmp/$dbname.dmp $destination/$dbname.dmp
    sudo chmod 666 $destination/$dbname.dmp
}

function mysql_import_db {
    dbname=$1
    password=$2
    sql=$3

    sudo mysql -uroot -p$password -e "CREATE DATABASE IF NOT EXISTS $dbname"
    cat $sql | sudo mysql -uroot -p$password $dbname
}

function mkdir_777 {
    folder=$1

    sudo mkdir $folder
    chown_777 $folder
}

function chown_777 {
    folder=$1

    sudo chown -R www-data:www-data $folder
    sudo chmod -R 777 $folder
}