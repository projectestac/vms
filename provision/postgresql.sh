#!/bin/bash

pass=$1

echo 'Installing PostgreSQL...'

sudo apt-get install -qq postgresql postgresql-contrib &> /dev/null

sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/12/main/postgresql.conf
sudo sed -i '$ a\host   all all 0.0.0.0/0   md5' /etc/postgresql/12/main/pg_hba.conf

sudo service postgresql restart

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$pass';" &> /dev/null
