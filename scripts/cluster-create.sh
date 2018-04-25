#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/utils-env-defaults.sh
source $BASE_DIR/utils.sh cluster-manager

logInfo "Spinning up cluster ..."
cd vagrant && vagrant up 2>&1 | tee "../logs/vagrant.log"
exitOnErr "Error spinning up the cluster"

logInfo "==================================================="
logInfo "Cluster Info"
logInfo "==================================================="
vagrant status && cd ..

logInfo "==================================================="
