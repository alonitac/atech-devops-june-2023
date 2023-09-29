#!/bin/bash


#Implement abash script in bastion_connect.sh that connects to the private instance using the public instance.
#Your script should not use an explicit path to the .pem ssh key file, instead, it reads an environment variable
#called KEY_PATH. If the variable doesn’t exist, print an error message and exit with code 5.

if [ -z $KEY_PATH ]; then
	echo "KEY_PATH envioment variable is expected   " >> /dev/stderr
	exit 5
fi


if [ "$#" -eq 0 ]; then
	echo "Please provide bastion IP address" >> /dev/stderr
	exit 5
fi

if [ "$#" -eq 1 ]; then
	ssh -ti $KEY_PATH ubuntu@$1

elif [ "$#" -eq 2 ]; then
	PUBLIC_EC2_IP=$1
	PRIVATE_EC2_IP=$2
	ssh -i $KEY_PATH ubuntu@$PUBLIC_EC2_IP "./ssh_pv_ec2.sh $PRIVATE_EC2_IP"

elif [ "$#" -gt 2 ]; then
	PUBLIC_EC2_IP=$1
	PRIVATE_EC2_IP=$2
	CMD=$3
	ssh -i $KEY_PATH ubuntu@$PUBLIC_EC2_IP  "./ssh_pv_ec2.sh $PRIVATE_EC2_IP '$CMD'"
fi