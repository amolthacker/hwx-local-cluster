#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/utils-env-defaults.sh
source $BASE_DIR/utils.sh cluster-provisioner

rm -rf ansible-hortonworks
rm -f  ansible-hortonworks-staging/inventory/static
rm -f  ansible-hortonworks-staging/playbooks/group_vars/all
rm -f  ansible-hortonworks-staging/playbooks/group_vars/ambari-server
