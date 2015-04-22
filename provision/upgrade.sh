#!/bin/bash
#Script d'actualització de la MV

source "/vms/provision/functions.sh"

echo "Upgrade VM"

load_version

if [ "$version" -lt 2015042201 ]; then
    echo 'Upgrade example'
    #Put here the code
    save_version 2015042201
fi

if [ "$version" -lt 2015042202 ]; then
    echo 'Next Upgrade example'
    #Put here the code
    save_version 2015042202
fi

#Don't forget to write the latest version on provision.sh

echo 'All updated!'
