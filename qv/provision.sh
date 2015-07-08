#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision QV'

rootdir=/dades/qv


mkdir_777 $rootdir/qv_biblio/work
mkdir_777 $rootdir/qv_editor/work
mkdir_777 $rootdir/qv_viewer/work
mkdir_777 $rootdir/qv_admin/work
