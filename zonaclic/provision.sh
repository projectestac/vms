#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Zona Clic'

rootdir=/dades/zonaclic

oracle_impdp clic /vms/zonaclic ts_clic

pushd $rootdir
ant
popd

