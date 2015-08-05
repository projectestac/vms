#!/bin/bash

sudo npm update -g cordova
sudo npm update -g ionic

cd /dades/moodlemobile2
ionic platform update android
ionic platform update ios
ionic serve
