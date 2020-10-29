#!/bin/bash

echo "Remounting all synced filesystem..."
cd /
sudo mount -o remount git_alexandria
sudo mount -o remount dades_alexandria_html
sudo mount -o remount vms

echo "Done"