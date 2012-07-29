#!/bin/bash -x
source ~/.bash_profile
# Synchronize the environments from HOST1 over to HOST2
CAP_HOST1=$1
CAP_HOST2=$2

if [[ -z $CAP_HOST1 ]]
then
	echo "Missing CAPISTRANO Deployment Environment 1"
	exit 1
fi

if [[ -z $CAP_HOST2 ]]
then
	echo "Missing CAPISTRANO Deployment Environment 2"
	exit 1
fi

cd ~/scripts/integration; cap $CAP_HOST1 mysql:create_synchronization_dump
cd ~/scripts/integration; cap $CAP_HOST2 mysql:use_synchronization_dump
cd ~/scripts/integration; cap $CAP_HOST2 synchronize:files -s remote_user=ashok -s remote_domain=$CAP_HOST1
