#!/bin/bash

echo "Supervisor: Installing via pip..."
sudo pip install supervisor > /dev/null 2>&1

echo "Supervisor: Configuring..."
echo_supervisord_conf > /tmp/supervisord.conf
sudo mv /tmp/supervisord.conf /etc/supervisord.conf
sudo tee -a /etc/supervisord.conf > /dev/null <<EOF
[include]
files = /etc/supervisord.d/*.ini
EOF
sudo mkdir -p /etc/supervisord.d/
sudo cp /vms/provision/conf/portal.ini /etc/supervisord.d/portal.ini

echo "Supervisor: Creating service systemd..."
sudo tee /etc/systemd/system/supervisord.service > /dev/null <<EOF
[Unit]
Description=Process Monitoring and Control Daemon
After=rc-local.service nss-user-lookup.target network.target remote-fs.target
Requires=remote-fs.target

[Service]
Type=forking
ExecStart=/usr/local/bin/supervisord -c /etc/supervisord.conf

[Install]
WantedBy=multi-user.target
EOF

echo "Supervisor: Activating and initializing as a service..."
sudo systemctl daemon-reload
sudo systemctl enable supervisord > /dev/null 2>&1
sudo systemctl start supervisord

echo "Supervisor installed and running."
