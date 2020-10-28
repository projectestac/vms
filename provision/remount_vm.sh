#!/bin/bash

echo "Remounting all synced filesystem..."
cd /
sudo mount -o remount git_odissea
sudo mount -o remount dades_odissea_html
sudo mount -o remount vms

echo "Done"