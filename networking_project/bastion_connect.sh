#!/bin/bash

if [ -z $KEY_PATH ]; then
	echo "KEY_PATH env var is expected">&2
	exit 5
fi

if [ "$#" -lt 1 ]; then
	echo "Please prodive bastion IP address">&2
	exit 5
fi
BASTION_IP=$1
if [ "$#" -eq 1 ]; then
	ssh -i $KEY_PATH ubuntu@$BASTION_IP
	echo "succesfully connected to bastion $BASTION_IP"
	#exit 0
elif [ "$#" -eq 2 ]; then
	PRIVATE_IP=$2
	ssh -tt -i $KEY_PATH ubuntu@$BASTION_IP "./remote.sh $PRIVATE_IP"
	#exit 0

elif [ "$#" -gt 2 ]; then
	PRIVATE_IP=$2
	COMMAND=$3
	ssh -i $KEY_PATH ubuntu@$BASTION_IP "./remote.sh $PRIVATE_IP '$COMMAND'"
	#exit 0
fi
