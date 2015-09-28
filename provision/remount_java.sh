#!/bin/bash

echo "Remounting all synced filesystem..."
cd /
sudo mount -o remount vms
sudo mount -o remount git_qv
sudo mount -o remount vagrant
sudo mount -o remount git_zonaclic
sudo mount -o remount dades_zonaclic
sudo mount -o remount dades_qv_qv_web
sudo mount -o remount dades_qv_qv_admin_web
sudo mount -o remount dades_qv_qv_biblio_web
sudo mount -o remount dades_qv_qv_editor_web
sudo mount -o remount dades_qv_qv_viewer_web
echo "Done"
