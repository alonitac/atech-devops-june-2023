#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Please provide private ec2 IP address"
  exit 5
fi

PRIVATE=$1
export NEW="new_key"

if [ -f $NEW ]
then
  export KEY_PATH1=$NEW
else
  export KEY_PATH1=Nasimob-private-ec2.pem
fi

if [ $# -eq 1 ]
then
  ssh -i $KEY_PATH1 ubuntu@$PRIVATE 
else
  COMMAND=$2
  ssh -i$KEY_PATH1 ubuntu@$PRIVATE "$COMMAND"
fi
