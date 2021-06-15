#!/bin/bash

pass=agora
passmd5=$(printf '%s' "$pass" | md5sum | cut -d ' ' -f 1)

function mysql_import_db {
    dbname=$1
    sql=$2

    echo "Importing DB  $dbname..."
    create_mysql_db $dbname
    cat $sql | sudo mysql -uroot -p$pass $dbname &> /dev/null
    echo 'Done'
}

function mkdir_777 {
    folder=$1

    sudo mkdir -p $folder
    chown_777 $folder
}

function chown_777 {
    folder=$1

    sudo chown -R vagrant:apache $folder
    sudo chmod -R 777 $folder
}

function execute_in_mysql {
    sudo mysql -uroot -p$pass -e "$1" &> /dev/null
}


function create_mysql_db {
    dbname=$1
    execute_in_mysql "CREATE DATABASE IF NOT EXISTS $dbname"
}
