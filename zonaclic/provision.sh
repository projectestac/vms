#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Zona Clic'

rootdir=/dades/zonaclic
gitdir=/git/zonaclic

echo "Creating role R_CLIC_LECTURA..."
create_oracle_role R_CLIC_LECTURA

oracle_impdp clic /vms/zonaclic ts_clic clic

pushd $rootdir
ant dev
popd
