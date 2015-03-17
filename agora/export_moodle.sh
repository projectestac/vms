#!/usr/bin/env bash

source "/vagrant/provision/functions.sh"

oracle_export_db usu1 /vagrant/agora/

pushd /dades/agora/docs/moodle2/usu1
tar czfp /vagrant/agora/usu1.tgz *
popd

