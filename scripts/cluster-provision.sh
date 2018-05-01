#!/bin/bash

BASE_DIR="$(dirname $0)"
source $BASE_DIR/utils-env-defaults.sh
source $BASE_DIR/utils.sh cluster-provisioner

DTF=$(datetimefmtd)

BASE_DIR_SRC="ansible-hortonworks-staging"
BASE_DIR_TGT="ansible-hortonworks"
INVENTORY_STATIC="inventory/static"
GRP_VARS_ALL="playbooks/group_vars/all"
GRP_VARS_AMBARI_SRV="playbooks/group_vars/ambari-server"

INVENTORY_STATIC_SRC="${BASE_DIR_SRC}/${INVENTORY_STATIC}"
GRP_VARS_ALL_SRC="${BASE_DIR_SRC}/${GRP_VARS_ALL}"
GRP_VARS_AMBARI_SRV_SRC="${BASE_DIR_SRC}/${GRP_VARS_AMBARI_SRV}"

INVENTORY_STATIC_TGT="${BASE_DIR_TGT}/${INVENTORY_STATIC}"
GRP_VARS_ALL_TGT="${BASE_DIR_TGT}/${GRP_VARS_ALL}"
GRP_VARS_AMBARI_SRV_TGT="${BASE_DIR_TGT}/${GRP_VARS_AMBARI_SRV}"

logInfo "Setting up bash YAML parser ..."
parse_yaml ${VAGRANT_CLUSTER_FILE}
create_variables ${VAGRANT_CLUSTER_FILE}

logInfo "Cloning ansible-hortonworks ..."
git clone ${ANSIBLE_HORTONWORKS_GIT}

logInfo "Generating Ansible static inventory file ..."
echo "[$prefix-gateway]" >> $INVENTORY_STATIC_SRC
for i in $(seq 1 $gateway_num)
do 
    echo "$prefix-gateway-$i ansible_host=$prefix-gateway-$i ansible_user=vagrant ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key ambari_server=true" >> $INVENTORY_STATIC_SRC
done
echo "[$prefix-master]" >> $INVENTORY_STATIC_SRC
for i in $(seq 1 $master_num)
do
    echo "$prefix-master-$i ansible_host=$prefix-master-$i ansible_user=vagrant ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key" >> $INVENTORY_STATIC_SRC
done
echo "[$prefix-worker]" >> $INVENTORY_STATIC_SRC
for i in $(seq 1 $worker_num)
do
    echo "$prefix-worker-$i ansible_host=$prefix-worker-$i ansible_user=vagrant ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key" >> $INVENTORY_STATIC_SRC
done

logInfo "Generate staging configs from templates ..."
sed -e "s/CLUSTER_NAME/${CLUSTER_NAME}/g" \
    -e "s/CLUSTER_AMBARI_VERSION/${CLUSTER_AMBARI_VERSION}/g" \
    -e "s/CLUSTER_HDP_VERSION/${CLUSTER_HDP_VERSION}/g" \
    -e "s/CLUSTER_HDF_VERSION/${CLUSTER_HDF_VERSION}/g" \
    -e "s/CLUSTER_UTILS_VERSION/${CLUSTER_UTILS_VERSION}/g" \
    -e "s/CLUSTER_HDF_AMBARI_MPACK_VERSION/${CLUSTER_HDF_AMBARI_MPACK_VERSION}/g" "${GRP_VARS_ALL_SRC}.template" > "${GRP_VARS_ALL_SRC}"
sed "s/PFX-/$prefix-/g" "${GRP_VARS_AMBARI_SRV_SRC}.template" > "${GRP_VARS_AMBARI_SRV_SRC}"

logInfo "Applying staging configs ..."
cp $INVENTORY_STATIC_SRC    $INVENTORY_STATIC_TGT
cp $GRP_VARS_ALL_SRC        $GRP_VARS_ALL_TGT
cp $GRP_VARS_AMBARI_SRV_SRC $GRP_VARS_AMBARI_SRV_TGT

rm -f $INVENTORY_STATIC_SRC
rm -f $GRP_VARS_ALL_SRC
rm -f $GRP_VARS_AMBARI_SRV_SRC

logInfo "-----------------------------------------------------------------"
logInfo "Initiating the setup of cluster ${CLUSTER_NAME} ..."
logInfo "-----------------------------------------------------------------"
cd ansible-hortonworks && bash install_cluster.sh && cd ..
exitOnErr "Error provisioning the cluster"

logInfo "==================================================="
