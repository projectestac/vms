#!/bin/bash

sudo apt-get update

sudo apt-get install -y --force-yes  ia32-libs texlive ghostscript imagemagick

sudo chmod -R 777 /var/log

sudo locale-gen ca_ES
sudo locale-gen ca_ES.UTF-8
sudo locale-gen es_ES
sudo locale-gen es_ES.UTF-8
