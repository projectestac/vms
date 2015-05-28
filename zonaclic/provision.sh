#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Zona Clic'

rootdir=/dades/zonaclic


pushd $rootdir
ant
popd