#!/usr/bin/env bash

source "/vms/provision/functions.sh"

oracle_export_db usu1 /vms/agora/

pushd /dades/agora/data/moodle2/usu1
tar czfp /vms/agora/usu1.tgz *
popd

