#!/bin/bash

pass=agora

function oracle_import_db {
    from=$1 #Nom de la db original
    file=$2 #Path i nom dle fitxer
    dbname=$3 #Nom de la nova BD

    echo "Creating DB  $dbname..."
    create_oracle_db $dbname

    execute_in_oracle "@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catexp.sql"

    sudo chmod 666 $file
    echo "Importing DB  $dbname..."
    sudo su - oracle --command "imp system/$pass@XE fromuser=$from touser=$dbname file=$file log=/tmp/logfile.log" &> /tmp/logfile_$dbname.log
    echo 'Done'

    sudo service oracle-xe restart > /dev/null
}

function oracle_export_db {
    dbname=$1
    destination=$2

    execute_in_oracle "@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catexp.sql"

    sudo su - oracle --command "exp system/$pass@XE owner=$dbname file=/tmp/$dbname.dmp log=/tmp/logfile.log"
    sudo cp /tmp/$dbname.dmp $destination/$dbname.dmp
    sudo chmod 666 $destination/$dbname.dmp
}

function mysql_import_db {
    dbname=$1
    sql=$2

    create_mysql_db $dbname
    cat $sql | sudo mysql -uroot -p$pass $dbname
}

function mkdir_777 {
    folder=$1

    sudo mkdir -p $folder
    chown_777 $folder
}

function chown_777 {
    folder=$1

    sudo chown -R www-data:www-data $folder
    sudo chmod -R 777 $folder
}

function execute_in_oracle {
    echo $1 | sudo su - oracle -c "sqlplus -S / as sysdba" > /dev/null
}

function execute_in_mysql {
    sudo mysql -uroot -p$pass -e "$1"
}

function create_oracle_db {
    dbname=$1

    sudo su - oracle --command "sqlplus -S / as sysdba << EOM
    CREATE USER $dbname IDENTIFIED BY $pass DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;
    GRANT ALL PRIVILEGES TO $dbname;
    GRANT execute ON DBMS_LOCK to $dbname;
    exit;
EOM" > /dev/null
}

function create_mysql_db {
    dbname=$1
    execute_in_mysql "CREATE DATABASE IF NOT EXISTS $dbname"
}

function load_version {
    if [ ! -f /vm_version ]; then
        #First version ever
        version=2015040100
        save_version $version
    else
        version=`cat /vm_version`
    fi
}


function save_version {
    echo 'Upgraded to '$1
    echo $1 | sudo tee /vm_version > /dev/null
}


