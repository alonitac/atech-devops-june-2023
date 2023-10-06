#!/bin/bash
#check if the variable KEY_PATH exists
if [ -z "${KEY_PATH}" ]; then
  echo "KEY_PATH env variable is expected"
  exit 5
fi

# if no IP address was provided
if [ $# -eq 0 ]; then
  echo "Please provide bastion IP address"
  exit 5
#connect to the public instance1
elif [ $# -eq 1 ]; then
  PUBLIC_IP=$1
  ssh -i $KEY_PATH ubuntu@$PUBLIC_IP
# connect to the private instance from your local machine
elif [ $# -eq 2 ]; then
 PUBLIC_IP=$1
 PRIVATE_IP=$2
  ssh -i $KEY_PATH ubuntu@$PUBLIC_IP "./run_private_instance.sh $PRIVATE_IP"
# run a command in the private machine
elif [ $# -gt 2 ];then
  PUBLIC_IP=$1
  PRIVATE_IP=$2
  ssh -i $KEY_PATH ubuntu@$PUBLIC_IP "./run_private_instance.sh $PRIVATE_IP ${@:3}"
fi
