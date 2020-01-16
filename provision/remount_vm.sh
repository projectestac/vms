#!/bin/bash

echo "Remounting all synced filesystem..."
cd /
sudo mount -o remount git_agora
sudo mount -o remount dades_agora_html
sudo mount -o remount vms

echo "Done"