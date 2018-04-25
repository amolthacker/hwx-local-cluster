#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/utils-env-defaults.sh
source $BASE_DIR/utils.sh cluseter-manager


logInfo "Cleaning up ..."
logInfo ""
./$BASE_DIR/cluster-cleanup.sh
exitOnErr ""

logInfo "Destroying Cluster ..."
logInfo ""
./$BASE_DIR/cluster-destroy.sh
exitOnErr ""

