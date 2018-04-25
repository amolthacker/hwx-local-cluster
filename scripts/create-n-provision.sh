#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/utils-env-defaults.sh
source $BASE_DIR/utils.sh cluster-manager


logInfo "---------------------------------"
logInfo "Creating Cluster ..."
logInfo "---------------------------------"
./$BASE_DIR/cluster-create.sh
exitOnErr ""
logInfo "---------------------------------"

logInfo "---------------------------------"
logInfo "Provisioning Cluster ..."
logInfo "---------------------------------"
./$BASE_DIR/cluster-provision.sh
exitOnErr ""
logInfo "---------------------------------"
