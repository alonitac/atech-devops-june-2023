#!/bin/bash

#check if the KEY_PATH env is set
if [ -z $KEY_PATH ]; then
	echo "KEY_PATH env var is expected"
	exit 5
fi

#check if missing bastion IP address
if [ $# -lt 1 ]; then
	echo "Pleast provide bastion IP address"
	exit 5
fi

bastion_ip=$1
private_ip=$2

#case 1- connect to the private instance - gets 2 args
if [ $# -eq 2 ]; then
	ssh -i $KEY_PATH ubuntu@$bastion_ip "./private_connect.sh $private_ip"
	echo "case1 works"

#case 2- connect to the public instance - gets 1 arg
elif [ $# -eq 1 ]; then
	ssh -i $KEY_PATH ubuntu@$bastion_ip
	echo "case2 works"

#case 3- run a command in the private machine
elif [ $# -gt 2 ]; then
	command=${@:3}
	ssh -i $KEY_PATH ubuntu@$bastion_ip "./private_connect.sh $private_ip $command"
	echo "case3"

fi