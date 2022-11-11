#!/bin/bash

pass=$1

echo 'Installing PostgreSQL...'

sudo apt-get install -qq postgresql postgresql-contrib &> /dev/null

sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/10/main/postgresql.conf
sudo echo "host   all all 0.0.0.0/0   md5" >> /etc/postgresql/10/main/pg_hba.conf

sudo service postgresql restart

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$pass';" &> /dev/null
