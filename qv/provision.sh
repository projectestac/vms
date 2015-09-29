#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision QV'

rootdir=/dades/qv
gitdir=/git/qv

echo "Creating role R_QUADERNS_VIRTUALS_LECTURA..."
create_oracle_role R_QUADERNS_VIRTUALS_LECTURA

oracle_impdp qv /vms/qv ts_e13_qv e13_qv

mkdir_777 $rootdir/qv_biblio/work
cd $gitdir/qv_biblio/
ant dev

mkdir_777 $rootdir/qv_editor/work
cd $gitdir/qv_editor/
ant dev

mkdir_777 $rootdir/qv_viewer/work
cd $gitdir/qv_viewer/
ant dev

mkdir_777 $rootdir/qv_admin/work
cd $gitdir/qv_admin/
ant dev


sudo cp $gitdir/qv_editor/src/editor/edu/xtec/resources/properties/*.properties /usr/share/tomcat7