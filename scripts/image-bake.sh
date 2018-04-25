#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/utils-env-defaults.sh
source $BASE_DIR/utils.sh baker

#################################
# Functions
#################################

function bakeImage ()
{
    [[ -z $2 ]] && exitWithErr "Missing image name & provider"

    PACKER_TEMPLATE="packer/template-$1.json"

    logInfo "Validating Packer template for baking $1 image ..."
    packer validate ${PACKER_TEMPLATE}
    exitOnErr "Invalid Packer template"

    logInfo "Baking $1 image ..."
    packer build -only=${PACKER_BAKEVM_PROVIDER} -force ${PACKER_TEMPLATE} 2>&1 | tee "logs/baker.log"
    exitOnErr "Error baking image $1"
}

#################################


IMG_NAME="${PACKER_BAKEVM_NAME}-vagrant"

logInfo "HWX Base Image: ${IMG_NAME} for ${PACKER_BAKEVM_PROVIDER}"
bakeImage ${IMG_NAME} ${PACKER_BAKEVM_PROVIDER}

logInfo "Adding the Vagrant box ..."
vagrant box add -f --name "${PACKER_BAKEVM_NAME}" "vagrant_boxes/${PACKER_BAKEVM_NAME}-$(echo $PACKER_BAKEVM_PROVIDER | cut -d - -f1).box"
exitOnErr "Could not add the baked Vagrant box"

logInfo "==================================================="
