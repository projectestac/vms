#!/bin/bash

echo 'Install Angular packages'

sudo apt-get install -qq npm rsync ng-common nodejs python-pip &> /dev/null

pip install pomerge &> /dev/null
