#!/bin/bash

echo 'Install Java'

sudo apt-get install -y tomcat7 tomcat7-admin ant default-jdk > /dev/null
sudo update-rc.d tomcat7 defaults 80 01

sudo sed -i "s#<Connector port=\"8080\" protocol=\"HTTP/1.1\"#<Connector port=\"80\" protocol=\"HTTP/1.1\"#" /etc/tomcat7/server.xml
sudo sed -i "s/#AUTHBIND=no/AUTHBIND=yes/" /etc/default/tomcat7

sudo sed -i "/<tomcat-users>/a \
    <user username=\"admin\" password=\"agora\" roles=\"manager-gui,admin-gui\"\/>" /etc/tomcat7/tomcat-users.xml


sudo cp -R /vms/javavm/tomcat/* /etc/tomcat7/Catalina/localhost

sudo chmod -R 777 /var/log/tomcat7/
sudo chown -R vagrant:vagrant /var/log/tomcat7/

sudo service tomcat7 restart > /dev/null