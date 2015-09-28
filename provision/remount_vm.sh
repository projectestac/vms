#!/bin/bash

echo "Remounting all synced filesystem..."
cd /
sudo mount -o remount git_agora
sudo mount -o remount dades_agora_html
sudo mount -o remount dades_agora_cgi
sudo mount -o remount git_alexandria
sudo mount -o remount dades_alexandria_html
sudo mount -o remount git_prestatgeria
sudo mount -o remount dades_prestatgeria_html
sudo mount -o remount git_xtecblocs
sudo mount -o remount dades_blocs_src
sudo mount -o remount git_odissea
sudo mount -o remount dades_odissea_html
sudo mount -o remount git_mps
sudo mount -o remount dades_mps_src
sudo mount -o remount dades_moodlemobile2
sudo mount -o remount vms
echo "Done"