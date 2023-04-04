#!/bin/bash

pass=$1

echo 'Installing PostgreSQL...'

# Add repository
sudo amazon-linux-extras install -y postgresql13 &> /dev/null

# Install packages
sudo yum install -y postgresql-server postgresql-devel php-pgsql &> /dev/null

# Initialize postgres
sudo /usr/bin/postgresql-setup --initdb &> /dev/null

# Load on start up
sudo systemctl enable postgresql &> /dev/null

# Start service now
sudo systemctl start postgresql &> /dev/null

# Restart Apache
sudo systemctl restart httpd > /dev/null 2>&1


# Allow remote connection
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
sudo sed -i "s#127.0.0.1/32            ident#0.0.0.0/0               trust#g" /var/lib/pgsql/data/pg_hba.conf
#echo "host   all all 0.0.0.0/0   md5" | sudo tee --append /var/lib/pgsql/data/pg_hba.conf &> /dev/null

sudo service postgresql restart &> /dev/null

# Change master password
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$pass';" &> /dev/null
