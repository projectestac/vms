#!/bin/bash

pass=$1
PG_VERSION=15

echo "PostgreSQL: Installing version $PG_VERSION..."
sudo dnf install -y postgresql${PG_VERSION}-server postgresql${PG_VERSION} php-pgsql > /dev/null 2>&1

echo "PostgreSQL: Initializing database..."
sudo /usr/bin/postgresql-setup --initdb > /dev/null 2>&1

# Allow remote connection
echo "PostgreSQL: Configuring remote connection..."
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
sudo sed -i "s#127.0.0.1/32            ident#0.0.0.0/0               trust#g" /var/lib/pgsql/data/pg_hba.conf

# Change master password
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$pass';" &> /dev/null

echo "PostgreSQL: Activating and initializing as a service..."
sudo systemctl daemon-reload
sudo systemctl enable postgresql > /dev/null 2>&1
sudo systemctl restart postgresql
