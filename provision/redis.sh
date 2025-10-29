#!/bin/bash

# Variables
REDIS_VERSION="7.4.3"
REDIS_USER="redis"
REDIS_GROUP="redis"

echo "Redis: Installing redis dependencies..."
sudo dnf groupinstall "Development Tools" -y > /dev/null 2>&1
sudo dnf install gcc jemalloc-devel tcl -y > /dev/null 2>&1

echo "Redis: Downloading redis $REDIS_VERSION..."
curl -O http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz > /dev/null 2>&1
tar xzf redis-${REDIS_VERSION}.tar.gz > /dev/null 2>&1

echo "Redis: Compiling..."
pushd redis-${REDIS_VERSION} > /dev/null || exit
make > /dev/null 2>&1
sudo make install > /dev/null 2>&1
popd > /dev/null || exit

echo "Redis: Creating user and folders..."
sudo adduser --system --no-create-home $REDIS_USER || true
sudo mkdir -p /etc/redis /var/lib/redis > /dev/null 2>&1
sudo chown $REDIS_USER:$REDIS_GROUP /var/lib/redis > /dev/null 2>&1
sudo chmod 770 /var/lib/redis > /dev/null 2>&1

echo "Redis: Setting configuration file..."
sudo cp redis-${REDIS_VERSION}/redis.conf /etc/redis/ > /dev/null 2>&1
sudo sed -i "s/^# supervised auto/supervised systemd/" /etc/redis/redis.conf
sudo sed -i "s|^dir .*|dir /var/lib/redis|" /etc/redis/redis.conf
sudo sed -i "s/^bind 127.0.0.1 -::1/# bind 127.0.0.1 -::1/" /etc/redis/redis.conf
sudo sed -i "s/^protected-mode yes/protected-mode no/" /etc/redis/redis.conf

echo "Redis: Adding service systemd..."
sudo tee /etc/systemd/system/redis.service > /dev/null <<EOF
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=$REDIS_USER
Group=$REDIS_GROUP
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "Redis: Deleting source files..."
sudo rm -rf redis-* > /dev/null 2>&1

echo "Redis: Activating and initializing as a service..."
sudo systemctl daemon-reload
sudo systemctl enable redis > /dev/null 2>&1
sudo systemctl start redis

echo "Redis $REDIS_VERSION installed and running."
