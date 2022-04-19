#!/bin/bash

source "/vms/provision/functions.sh"

datadir=/dades/data

mysql_import_db moodle /vms/moodle/moodle.sql

echo "Importing moodledata..."
mkdir_777 $datadir/moodledata
pushd $datadir/moodledata > /dev/null || exit
sudo tar -zxvf /vms/moodle/moodledata.tar.gz > /dev/null
popd > /dev/null || exit
echo "Done"

chown_777 $datadir
