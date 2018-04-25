#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/utils-env-defaults.sh
source $BASE_DIR/utils.sh cluster-manager

DTF=$(datetimefmtd)

logInfo "Tearing down the cluster ..."
cd vagrant && vagrant destroy -f && cd ..

logInfo "==================================================="
