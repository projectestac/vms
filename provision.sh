#!/bin/bash

source "/vagrant/provision/functions.sh"

/vagrant/provision/base.sh
/vagrant/provision/php5.sh
/vagrant/provision/memcache.sh
/vagrant/provision/mysql.sh $pass
/vagrant/provision/oracle-xe.sh

/vagrant/agora/provision.sh
/vagrant/alexandria/provision.sh
/vagrant/odissea/provision.sh
/vagrant/xtecblocs/provision.sh
#/vagrant/prestatgeria/provision.sh
#/vagrant/mps/provision.sh

sudo service oracle-xe restart
