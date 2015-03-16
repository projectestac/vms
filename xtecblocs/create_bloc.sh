#!/bin/bash

source "/vagrant/provision/functions.sh"

dbnum=$1
password=$2

sudo mysql -uroot -p$password -e "CREATE DATABASE IF NOT EXISTS xtec_blocs_$dbnum"