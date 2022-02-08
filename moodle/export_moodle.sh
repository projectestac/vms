#!/usr/bin/env bash

rm /vms/moodle/moodle-35.sql
rm /vms/moodle/moodle-310.sql
mysqldump -u root -h localhost --set-gtid-purged=OFF -p moodle35 > moodle-35.sql
mysqldump -u root -h localhost --set-gtid-purged=OFF -p moodle310 > moodle-310.sql

pushd /dades/data/moodledata35
tar czfp /vms/moodle/moodledata-35.tar.gz *
popd
pushd /dades/data/moodledata310
tar czfp /vms/moodle/moodledata-310.tar.gz *
popd
