#!/bin/bash

EXIFTOOL_VERSION="13.44"

echo 'Updating packages...'
sudo dnf update -y > /dev/null 2>&1

echo 'Upgrading system...'
sudo dnf upgrade -y > /dev/null 2>&1

echo 'Installing base packages...'
sudo dnf install -y texlive ghostscript texlive-dvisvgm poppler-utils unzip ImageMagick aspell graphviz git python3 python3-pip telnet > /dev/null 2>&1

echo 'Installing exiftool...'
wget https://exiftool.org/Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz > /dev/null 2>&1
tar -zxf Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz > /dev/null 2>&1
pushd Image-ExifTool-${EXIFTOOL_VERSION}/ > /dev/null || exit
perl Makefile.PL > /dev/null
sudo make install > /dev/null
popd > /dev/null || exit
rm -rf Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz Image-ExifTool-${EXIFTOOL_VERSION}/

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
