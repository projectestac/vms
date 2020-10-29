#!/bin/bash

function mkdir_777 {
    folder=$1

    sudo mkdir -p $folder
    chown_777 $folder
}

function chown_777 {
    folder=$1

    sudo chown -R vagrant:www-data $folder
    sudo chmod -R 777 $folder
}
