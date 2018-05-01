#!/bin/bash

# Settings for starting minial OS ISO and the bake VM
export PACKER_BAKEVM_PROVIDER="virtualbox-iso"
export PACKER_BAKEVM_NAME="hwx-base-centos7"
export PACKER_BAKEVM_CPU="2"
export PACKER_BAKEVM_MEM="2048"
export PACKER_BAKEVM_DISK_SIZE="40960"
export PACKER_BAKEVM_OS_TYPE="RedHat_64"
export PACKER_BAKEVM_OS="centos7"
export PACKER_BAKEVM_OS_ISO="CentOS-7-x86_64-Minimal-1708.iso"
export PACKER_BAKEVM_OS_ISO_MIRROR_BASEURL="http://centos.unixheads.org/7.4.1708/isos/x86_64"
export PACKER_BAKEVM_OS_ISO_CHECKSUM_TYPE="sha256"
export PACKER_BAKEVM_OS_ISO_CHECKSUM="bba314624956961a2ea31dd460cd860a77911c1e0a56e4820a12b9c5dad363f5"


export VAGRANT_CLUSTER_FILE="vagrant/cluster.yml"

#-----------------------------------------------------------
# Should not have to modify the following VAGRANT settings
#-----------------------------------------------------------
# These are just the defaults for the Vagrant cluster VMs. Use the vagrant/cluster.yml to define 
# VM settings for each category and cluster level configs like VM prefix, base box to be used and network CIDR
export VAGRANT_CLUSTER_VM_DEFAULT_BASE_BOX='bento/centos-7.4'
export VAGRANT_CLUSTER_VM_DEFAULT_PREFIX='hdp'
export VAGRANT_CLUSTER_VM_DEFAULT_BASE_CIDR='192.168.10.0/24'
export VAGRANT_CLUSTER_VM_DEFAULT_CPU=2
export VAGRANT_CLUSTER_VM_DEFAULT_MEM=2048
export VAGRANT_CLUSTER_DEFAULT_NUM_GATEWAY=1
export VAGRANT_CLUSTER_DEFAULT_NUM_MASTER=1
export VAGRANT_CLUSTER_DEFAULT_NUM_WORKER=2
#-----------------------------------------------------------

# Ambari, HDP and HDF Versions and Cluster Name
export CLUSTER_NAME="hdp-local"
export CLUSTER_AMBARI_VERSION="2.6.1.5"
export CLUSTER_HDP_VERSION="2.6.4.0"
export CLUSTER_HDF_VERSION="3.1.1.0"
export CLUSTER_UTILS_VERSION="1.1.0.22"
export CLUSTER_HDF_AMBARI_MPACK_VERSION="3.1.1.0-35"

# ansible-hortonworks
export ANSIBLE_HORTONWORKS_GIT="https://github.com/amolthacker/ansible-hortonworks.git"
export CLOUD_TO_USE=static
