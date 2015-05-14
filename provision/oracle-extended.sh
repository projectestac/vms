#!/bin/bash

source "/vms/provision/functions.sh"

/vms/provision/oracle-base.sh

#http://www.oracle.com/technetwork/articles/technote-php-instant-084410.html

sudo apt-get install -y --force-yes php5-dev > /dev/null

echo 'Install OCI8'
echo instantclient,/usr/lib/oracle/12.1/client64/lib | sudo pecl install oci8  > /dev/null

echo "extension=oci8.so" | sudo tee -a /etc/php5/mods-available/oci8.ini

sudo ln -s /etc/php5/mods-available/oci8.ini /etc/php5/apache2/conf.d/30-oci8.ini

sudo service apache2 restart > /dev/null

sudo su - oracle --command "sqlplus -S / as sysdba << EOM
ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK;
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY agora;
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY agora;
SELECT DBMS_XDB.GETHTTPPORT FROM DUAL;
EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);
exit;
EOM" > /dev/null

sudo service oracle-xe restart > /dev/null