#!/bin/bash

wwwdir=/vagrant_git/html
pass=prestatgeria
dbname=prestatgeria
datadir=/moodledata

/vagrant/provision/base.sh
/vagrant/provision/php5.sh $wwwdir
/vagrant/provision/mysql.sh $pass

#cd /vagrant_git