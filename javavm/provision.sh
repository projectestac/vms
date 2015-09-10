#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/base.sh
/vms/provision/java.sh
/vms/provision/oracle-base.sh javatac

sudo cp -R /vms/javavm/tomcat/* /etc/tomcat7/Catalina/localhost

/vms/zonaclic/provision.sh
/vms/qv/provision.sh

sudo service tomcat7 restart

#Here we must write the latest version number
save_version 2015043000
