#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Zona Clic'

rootdir=/dades/zonaclic

oracle_impdp clic /vms/zonaclic ts_clic clic

pushd $rootdir
ant dev
popd

