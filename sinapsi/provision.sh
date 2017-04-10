#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Dossier'

rootdir=/dades/sinapsi
wwwdir=$rootdir/public

sudo chmod -R 664 $wwwdir

sudo cp $rootdir/.env-dist $rootdir/.env
sudo cp $rootdir/config/services-dist.php $rootdir/config/services.php

/vms/sinapsi/import_db.sh sinapsi

