#!/bin/bash

source "/vagrant/provision/functions.sh"

echo 'Provision Alexandria'

wwwdir=/dades/alexandria/html
dbname=alexandria
datadir=/dades/alexandria/docs
git=/vagrant_git/alexandria

create_mysql_db $dbname
zcat $git/alexandria.sql.gz | mysql -uroot -p$pass $dbname


mkdir_777 $datadir
sudo cp -R $git/moodledata-dist/* $datadir
chown_777 $datadir

sudo cp /vagrant/alexandria/config.php $wwwdir/config.php
chown_777 $wwwdir/local/agora/muc
