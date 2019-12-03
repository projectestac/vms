#!/bin/bash

pass=$1

echo 'Install PostgreSQL'

sudo apt-get install -qq postgresql postgresql-contrib &> /dev/null

sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.5/main/postgresql.conf
sudo echo "host   all all 0.0.0.0/0   md5" >> /etc/postgresql/9.5/main/pg_hba.conf

sudo service postgresql restart

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$pass';"
sudo -u postgres psql -c "CREATE USER usu1 WITH ENCRYPTED PASSWORD '$pass';"
sudo -u postgres psql -c "CREATE USER usu2 WITH ENCRYPTED PASSWORD '$pass';"
sudo -u postgres psql -c "CREATE USER usu3 WITH ENCRYPTED PASSWORD '$pass';"
sudo -u postgres psql -c "CREATE USER usu4 WITH ENCRYPTED PASSWORD '$pass';"

export PGPASSWORD="$pass"
#pg_dump -U usu1 usu1 < /git/agora/sql/usu1-moodle.sql | sudo -u postgres