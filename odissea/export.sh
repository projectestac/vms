#!/usr/bin/env bash

source "/vagrant/provision/functions.sh"

oracle_export_db odissea /vagrant/odissea/

pushd /dades/odissea/docs
tar czfp /vagrant/odissea/data.tgz *
popd

