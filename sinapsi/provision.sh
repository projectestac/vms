#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Dossier'

rootdir=/dades/sinapsi
wwwdir=$rootdir/public

sudo chmod -R 664 $wwwdir

sudo cp $rootdir/.env-dist $wwwdir/.env
sudo cp $rootdir/config/services-dist.php $wwwdir/config/services.php

/vms/dossier/import_db.sh sinapsi

