#!/bin/bash

echo 'Updating packages...'
sudo apt-get update &> /dev/null
sudo apt-get autoremove -qq &> /dev/null

echo 'Installing base packages...'
sudo apt-get install -qq gcc-multilib texlive ghostscript poppler-utils unzip imagemagick unoconv aspell aspell-ca aspell-es graphviz &> /dev/null

echo 'Installing locales...'
sudo locale-gen ca_ES &> /dev/null
sudo locale-gen ca_ES.utf8 &> /dev/null
sudo locale-gen es_ES &> /dev/null
sudo locale-gen es_ES.utf8 &> /dev/null
sudo locale-gen fr_FR &> /dev/null
sudo locale-gen fr_FR.utf8 &> /dev/null
sudo locale-gen eu_ES &> /dev/null
sudo locale-gen eu_ES.utf8 &> /dev/null
sudo locale-gen gl_ES &> /dev/null
sudo locale-gen gl_ES.utf8 &> /dev/null
sudo locale-gen it_IT &> /dev/null
sudo locale-gen it_IT.utf8 &> /dev/null
sudo locale-gen nl_NL &> /dev/null
sudo locale-gen nl_NL.utf8 &> /dev/null
sudo locale-gen pt_PT &> /dev/null
sudo locale-gen pt_PT.utf8 &> /dev/null
sudo locale-gen sv_SE &> /dev/null
sudo locale-gen sv_SE.utf8 &> /dev/null
sudo locale-gen el_GR &> /dev/null
sudo locale-gen el_GR.utf8 &> /dev/null
sudo locale-gen ru_RU &> /dev/null
sudo locale-gen ru_RU.utf8 &> /dev/null
sudo locale-gen ur_IN &> /dev/null
sudo locale-gen ur_IN.utf8 &> /dev/null
sudo locale-gen ar_MA &> /dev/null
sudo locale-gen ar_MA.utf8 &> /dev/null
sudo locale-gen ko_KR &> /dev/null
sudo locale-gen ko_KR.utf8 &> /dev/null
sudo locale-gen ja_JP &> /dev/null
sudo locale-gen ja_JP.utf8 &> /dev/null
sudo locale-gen zh_CN &> /dev/null
sudo locale-gen zh_CN.utf8 &> /dev/null

echo 'Setting locale...'
sudo update-locale LANG=ca_ES.utf8

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
