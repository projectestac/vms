#!/bin/bash

source "/vms/provision/functions.sh"

datadir=/dades/data

mysql_import_db moodle35 /vms/moodle/moodle-35.sql
mysql_import_db moodle310 /vms/moodle/moodle-310.sql

echo "Importing moodledata 3.5..."
mkdir_777 $datadir/moodledata35
pushd $datadir/moodledata35 > /dev/null || exit
sudo tar -zxvf /vms/moodle/moodledata-35.tar.gz > /dev/null
popd > /dev/null || exit
echo "Done"

echo "Importing moodledata 3.10..."
mkdir_777 $datadir/moodledata310
pushd $datadir/moodledata310 > /dev/null || exit
sudo tar -zxvf /vms/moodle/moodledata-310.tar.gz > /dev/null
popd > /dev/null || exit
echo "Done"

chown_777 $datadir
