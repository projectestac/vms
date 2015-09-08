#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/java.sh
/vms/provision/oracle-base.sh javatac


/vms/zonaclic/provision.sh
/vms/qv/provision.sh

echo 'Install Oracle Server'
pushd /vms/provision/oracle/
if [ ! -f ojdbc7.jar ]; then
    echo 'Download ojdbc7.jar and save it on provision folder'
    exit -1
fi
popd
sudo cp /vms/provision/oracle/ojdbc7.jar /usr/share/tomcat7/lib/
sudo chmod 777 /usr/share/tomcat7/lib/ojdbc7.jar

sudo service tomcat7 restart

#Here we must write the latest version number
save_version 2015043000
