#!/bin/bash

if [ -z $KEY_PATH ]; then
	echo "KEY_PATH env vat is expected"
	exit 5
fi

if [ "$#" -lt 1 ]; then
	echo "please provied arguments  (bastion IP address) "
	exit 5
fi

BASTION_IP=$1
if [ "$#" -eq 1 ]; then
	ssh -i $KEY_PATH ubuntu@$BASTION_IP
elif [ "$#" -eq 2 ]; then
	PRIVATE_IP= $2
	ssh -tt -i $KEY_PATH ubuntu@$BASTION_IP "./remote.sh $PRIVATE_IP"
elif [ "$#" -gt 2 ]; then
	PRIVATE_IP=$2
	COMMAND=$3
	ssh -i $KEY_PATH ubuntu@$BASTION_IP "./remote.sh $PRIVATE_IP '$COMMAND'"
fi