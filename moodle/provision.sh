#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Moodle - IOC'

rootdir=/dades
wwwdir=$rootdir/html
datadir=$rootdir/data
localdatadir=$rootdir/localdata

mkdir_777 $datadir
mkdir_777 $localdatadir

cp /vms/moodle/config-35.php $wwwdir/moodle35/config.php
cp /vms/moodle/config-310.php $wwwdir/moodle310/config.php

/vms/moodle/create_moodle.sh 
