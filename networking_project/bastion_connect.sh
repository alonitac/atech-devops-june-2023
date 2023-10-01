#!/bin/bash

if [ -z $KEY_PATH ]
then 
  echo "KEY_PATH var is expected"
  exit 5
fi

if [ $# -lt 1 ]
then
  echo "Please provide bastion IP address"
  exit 5
fi
PUBLIC=$1
PRIVATE=$2
COMMAND=$3
if [ $# -eq 1 ]
then 
  ssh -i $KEY_PATH ubuntu@$PUBLIC
else
  ssh -t -i $KEY_PATH ubuntu@$PUBLIC "./remote_connect.sh ${PRIVATE} ${COMMAND}"
fi 
