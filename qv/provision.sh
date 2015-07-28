#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision QV'

rootdir=/dades/qv

oracle_impdp qv /vms/qv ts_e13_qv

mkdir_777 $rootdir/qv_biblio/work
mkdir_777 $rootdir/qv_editor/work
mkdir_777 $rootdir/qv_viewer/work
mkdir_777 $rootdir/qv_admin/work


