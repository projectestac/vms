#!/bin/bash

echo 'Update packages'

sudo apt-get update &> /dev/null
sudo apt-get autoremove -qq &> /dev/null

echo 'Log permissions'
sudo chmod -R 777 /var/log

echo 'Install locales'
sudo locale-gen ca_ES &> /dev/null
sudo locale-gen ca_ES.utf8 &> /dev/null
sudo locale-gen es_ES &> /dev/null
sudo locale-gen es_ES.utf8 &> /dev/null

# Set default locale
sudo update-locale LANG=ca_ES.utf8

echo 'Set Timezone'
sudo timedatectl set-timezone Europe/Madrid

echo 'Increase swapsize'
# size of swapfile in megabytes
swapsize=2000

# does the swap file already exist?
grep -q "swapfile" /etc/fstab

# if not then create it
if [ $? -ne 0 ]; then
  echo 'swapfile not found. Adding swapfile.'
  fallocate -l ${swapsize}M /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
  echo 'swapfile found. No changes made.'
fi
