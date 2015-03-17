#!/usr/bin/env bash

source "/vagrant/provision/functions.sh"

pass=agora

oracle_export_db usu1 $pass /vagrant/agora/

pushd /dades/agora/docs/moodle2/usu1
tar czfp /vagrant/agora/usu1.tgz *
popd

