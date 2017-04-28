#!/bin/bash

source "/vms/provision/functions.sh"

echo 'Provision Sinapsi'

rootdir=/dades/sinapsi
wwwdir=$rootdir/public
datadir=/dades/agora/docs/sinapsi

mkdir_777 $datadir
mkdir_777 $datadir/photos
mkdir_777 $datadir/files

sudo ln -s $datadir $wwwdir/storage

sudo cp $rootdir/.env-dist $rootdir/.env

# Instal·lació del composer
EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo "No s'ha pogut instal·lar el composer. La signatura de l'instal·lador no és vàlida"
    rm composer-setup.php
else
    sudo php composer-setup.php --install-dir=/bin --filename=composer --quiet
    RESULT=$?
    rm composer-setup.php
    >&2 echo "S'ha instal·lat el composer"
fi

# Instal·lació de git, nodejs i npm
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y --force-yes git nodejs

# Instal·lació dels vendors
pushd $rootdir
composer install

# Instal·lació npm, node_modules i gulp
sudo npm install
sudo npm install --global gulp-cli

# Creació de la base de dades
create_mysql_db sinapsi
php artisan migrate

# Addició de dades de prova a la base de dades
php artisan migrate --seed

# Creació de la clau d'accés a la base de dades
php artisan key:generate

# Actualització del fitxer public/js/app.js i public/css/style.min.css
# Per a producció: gulp --production
gulp

popd

