#!/bin/bash

echo 'Updating packages...'
sudo yum update -y &> /dev/null

echo 'Installing base packages...'
sudo yum install -y texlive ghostscript poppler-utils unzip ImageMagick aspell graphviz git python3 telnet &> /dev/null

echo 'Setting locale...'
sudo localectl set-locale LANG=ca_ES.utf8

echo 'Setting system timezone...'
sudo timedatectl set-timezone Europe/Madrid

echo 'Setting log permissions...'
sudo chmod -R 777 /var/log

echo 'Setting swapsize...'
# Size of swapfile in megabytes
swapsize=2000

# Does the swap file already exist?
grep -q "swapfile" /etc/fstab

# If not, then create it
if [ $? -ne 0 ]; then
  echo 'swapfile not found. Adding swapfile...'
  fallocate -l ${swapsize}M /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
  echo 'swapfile found. No changes made.'
fi
