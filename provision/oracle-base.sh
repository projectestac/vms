#!/bin/bash

source "/vms/provision/functions.sh"

host=$1

echo 'Install Oracle'
#http://www.oracle.com/technetwork/articles/technote-php-instant-084410.html

sudo apt-get install -y --force-yes alien bc libaio1 unzip > /dev/null

sudo cp /vms/provision/oracle/S01shm_load /etc/rc2.d/S01shm_load
sudo chmod 777 /etc/rc2.d/S01shm_load
sudo /etc/rc2.d/S01shm_load start


echo 'Install Oracle Server'
pushd /vms/provision/oracle/
if [ ! -f oracle-xe_11.2.0-2_amd64.deb ]; then
    if [ ! -f oracle-xe-11.2.0-1.0.x86_64.rpm ]; then
        if [ ! -f oracle-xe-11.2.0-1.0.x86_64.rpm.zip ]; then
            echo 'Download oracle-xe-11.2.0-1.0.x86_64 and save it on provision folder'
            exit -1
        fi
        sudo unzip -q oracle-xe-11.2.0-1.0.x86_64.rpm.zip -d /tmp > /dev/null
    fi
    pushd /tmp/Disk1
    sudo alien --scripts oracle-xe-11.2.0-1.0.x86_64.rpm > /dev/null
    popd
    cp /tmp/Disk1/oracle-xe_11.2.0-2_amd64.deb /vms/provision/oracle/
    rm -Rf /tmp/Disk1
fi
sudo dpkg -i oracle-xe_11.2.0-2_amd64.deb > /dev/null
popd

sudo cp /vms/provision/oracle/oracle-env.sh /etc/profile.d/
sudo chmod 777 /etc/profile.d/oracle-env.sh
cat /etc/profile.d/oracle-env.sh | sudo tee -a /etc/bash.bashrc

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export ORACLE_BASE=/u01/app/oracle
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib/:$LD_LIBRARY_PATH
export NLS_CHARACTERSET=AL32UTF8
export NLS_NUMERIC_CHARACTERS='.,'
export TNS_ADMIN=$ORACLE_HOME/network/admin

# http://www.len.ro/work/oracle-11g-release-2-xe-on-ubuntu-12-04/
#sudo rm -rf /dev/shm
#sudo mkdir /dev/shm
#sudo mount -t tmpfs shmfs -o size=2048m /dev/shm
sudo sysctl kernel.shmmax=1073741824 #also edit /etc/sysctl.conf and set the same value to persist the change
sudo cp /vms/provision/oracle/60-oracle.conf /etc/sysctl.d/60-oracle.conf

sudo cp /vms/provision/oracle/oracle-xe /etc/init.d/oracle-xe

sudo cp /vms/provision/oracle/tnsnames.ora $TNS_ADMIN
sudo chmod 777 $TNS_ADMIN/tnsnames.ora
sudo cp /vms/provision/oracle/listener.ora $TNS_ADMIN
sudo chmod 777 $TNS_ADMIN/listener.ora
sudo sed -i "s:nom_maquina:$host:g"  $TNS_ADMIN/listener.ora


echo 'Configure Oracle server'
sudo service oracle-xe configure responseFile=/vms/provision/oracle/oracle.conf >> /tmp/xe-install.log

sudo update-rc.d oracle-xe defaults 80 01

sudo service oracle-xe restart > /dev/null

echo  'Install Oracle basic client'
pushd /vms/provision/oracle/
if [ ! -f oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb ]; then
    if [ ! -f oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm ]; then
        echo 'Download oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64 and save it on provision folder'
        exit -1
    fi
    sudo alien --scripts oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm > /dev/null
fi
sudo dpkg -i oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb > /dev/null
popd

#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib/:$LD_LIBRARY_PATH
#export ORACLE_HOME=/usr/lib/oracle/12.1/client64

sudo ldconfig

echo 'Install Oracle Client with SDK'
pushd /vms/provision/oracle/
if [ ! -f oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb ]; then
    if [ ! -f oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm ]; then
        echo 'Download oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64 and save it on provision folder'
        exit -1
    fi
    sudo alien --scripts oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm > /dev/null
fi
sudo dpkg -i oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb > /dev/null
popd
echo $ORACLE_HOME
sudo ln -s /usr/include/oracle/12.1/client64 $ORACLE_HOME/include

# echo 'Instalacio de SQL*Plus'
# pushd /vms/provision/oracle/
# if [ ! -f oracle-instantclient12.1-sqlplus_12.1.0.2.0-2_amd64.deb ]; then
#     if [ ! -f oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm ]; then
#         echo 'Download  oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64 and save it on provision folder'
#         exit -1
#     fi
#     sudo alien --scripts  oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
# fi
# sudo dpkg -i oracle-instantclient12.1-sqlplus_12.1.0.2.0-2_amd64.deb
# popd

sudo su - oracle --command "sqlplus -S / as sysdba << EOM
ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK;
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY agora;
SELECT DBMS_XDB.GETHTTPPORT FROM DUAL;
EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);
exit;
EOM" > /dev/null

sudo su - oracle --command "sqlplus -S / as sysdba << EOM
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
ALTER PROFILE MONITORING_PROFILE LIMIT PASSWORD_LIFE_TIME UNLIMITED;
exit;
EOM" > /dev/null

sudo su - oracle --command "sqlplus -S sys/agora as sysdba << EOM
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
ALTER PROFILE MONITORING_PROFILE LIMIT PASSWORD_LIFE_TIME UNLIMITED;
exit;
EOM" > /dev/null

sudo service oracle-xe restart > /dev/null