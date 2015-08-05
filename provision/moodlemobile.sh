#!/bin/bash

echo 'Install Node.js'
sudo apt-get install -y --force-yes npm > /dev/null
sudo apt-get install -y --force-yes python-software-properties python g++ make > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y --force-yes nodejs > /dev/null

sudo ln -s /usr/bin/nodejs /usr/local/bin/node
sudo npm config set strict-ssl false
sudo npm cache clean

echo 'Install Shifter'
sudo npm install shifter@0.4.6 -g

echo 'Install IONIC'
sudo npm install cordova ionic -g

pushd /dades/moodlemobile2
ionic state restore
ionic platform add ios
ionic platform add android
sudo npm install
sudo npm install -g bower
sudo npm install -g gulp
bower install
gulp

popd