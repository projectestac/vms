#!/usr/bin/env bash

rm /vms/moodle/moodle.sql

mysqldump -u root -h localhost --set-gtid-purged=OFF -p moodle > moodle.sql

pushd /dades/data/moodledata
tar czfp /vms/moodle/moodledata.tar.gz *
popd
