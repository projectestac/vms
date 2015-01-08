#!/bin/bash

if [ ! -f /vagrant/provision/oracle/oracle-xe-11.2.0-1.0.x86_64.rpm.zip ]; then
    echo 'Download oracle-xe-11.2.0-1.0.x86_64 and save it on provision folder'
    exit -1
fi

# http://www.len.ro/work/oracle-11g-release-2-xe-on-ubuntu-12-04/
sudo apt-get install -y alien bc libaio1 unzip

sudo unzip /vagrant/provision/oracle/oracle-xe-11.2.0-1.0.x86_64.rpm.zip -d /tmp

pushd /tmp/Disk1
sudo alien --scripts oracle-xe-11.2.0-1.0.x86_64.rpm
sudo dpkg -i oracle-xe_11.2.0-2_amd64.deb
popd

sudo update-rc.d oracle-xe defaults 80 01

sudo rm /dev/shm
sudo mkdir /dev/shm
sudo mount -t tmpfs shmfs -o size=2048m /dev/shm
sudo sysctl kernel.shmmax=1073741824 #also edit /etc/sysctl.conf and set the same value to persist the change
sudo cp /vagrant/provision/oracle/60-oracle.conf /etc/sysctl.d/60-oracle.conf

sudo cp /vagrant/provision/oracle/oracle-xe /etc/init.d/oracle-xe

sudo service oracle-xe configure responseFile=/vagrant/provision/oracle/oracle.conf >> /tmp/xe-install.log