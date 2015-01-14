#!/bin/bash

if [ ! -f /vagrant/provision/oracle/oracle-xe-11.2.0-1.0.x86_64.rpm.zip ]; then
    echo 'Download oracle-xe-11.2.0-1.0.x86_64 and save it on provision folder'
    exit -1
fi

# http://www.len.ro/work/oracle-11g-release-2-xe-on-ubuntu-12-04/
sudo apt-get install -y alien bc libaio1 unzip
sudo apt-get install -y php5-dev

sudo unzip /vagrant/provision/oracle/oracle-xe-11.2.0-1.0.x86_64.rpm.zip -d /tmp

pushd /tmp/Disk1
sudo alien --scripts oracle-xe-11.2.0-1.0.x86_64.rpm
sudo dpkg -i oracle-xe_11.2.0-2_amd64.deb
popd

rm -Rf /tmp/Disk1

sudo update-rc.d oracle-xe defaults 80 01

sudo rm /dev/shm
sudo mkdir /dev/shm
sudo mount -t tmpfs shmfs -o size=2048m /dev/shm
sudo sysctl kernel.shmmax=1073741824 #also edit /etc/sysctl.conf and set the same value to persist the change
sudo cp /vagrant/provision/oracle/60-oracle.conf /etc/sysctl.d/60-oracle.conf

sudo cp /vagrant/provision/oracle/oracle-xe /etc/init.d/oracle-xe

sudo service oracle-xe configure responseFile=/vagrant/provision/oracle/oracle.conf >> /tmp/xe-install.log


if [ ! -f /vagrant/provision/oracle/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm ]; then
    echo 'Download oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64 and save it on provision folder'
    exit -1
fi

sudo cp /vagrant/provision/oracle/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp

pushd /tmp
sudo alien --scripts oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
sudo dpkg -i oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb
sudo rm -f oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
popd

export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib/:$LD_LIBRARY_PATH
export ORACLE_HOME=/usr/lib/oracle/12.1/client64

sudo ldconfig

if [ ! -f /vagrant/provision/oracle/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm ]; then
    echo 'Download oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64 and save it on provision folder'
    exit -1
fi

sudo cp /vagrant/provision/oracle/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /tmp

pushd /tmp
sudo alien --scripts oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
sudo dpkg -i oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb
sudo rm -f oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb
popd

sudo ln -s /usr/include/oracle/12.1/client64 $ORACLE_HOME/include

echo instantclient,/usr/lib/oracle/12.1/client64/lib | sudo pecl install oci8

echo "extension=oci8.so" | sudo tee -a /etc/php5/mods-available/oci8.ini

sudo ln -s /etc/php5/mods-available/oci8.ini /etc/php5/apache2/conf.d/30-oci8.ini
sudo ln -s /etc/php5/mods-available/oci8.ini /etc/php5/cli/conf.d/30-oci8.ini

sudo service apache2 restart