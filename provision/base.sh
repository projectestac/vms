#!/bin/bash

sudo apt-get update

sudo apt-get install -y --force-yes  ia32-libs texlive ghostscript imagemagick

sudo chmod -R 777 /var/log

#Install locales
sudo locale-gen ca_ES
sudo locale-gen ca_ES.UTF-8
sudo locale-gen es_ES
sudo locale-gen es_ES.UTF-8

#Set Timezone
sudo echo "Europe/Madrid" | sudo tee /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata

#Increase swapsize

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

# output results to terminal
df -h
cat /proc/swaps
cat /proc/meminfo | grep Swap
