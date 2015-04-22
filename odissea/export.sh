#!/usr/bin/env bash

source "/vms/provision/functions.sh"

oracle_export_db odissea /vms/odissea/

pushd /dades/odissea/docs
tar czfp /vms/odissea/data.tgz *
popd

