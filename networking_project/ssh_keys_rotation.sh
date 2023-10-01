#!/bin/bash

if [ $# -lt 1 ]
then 
  echo "Provide IP Address"
  exit 5
fi

PRIVATE=$1
export NEW="new_key"

if [ -f "$NEW" ] || [ -f "${NEW}.pub" ]
then
  mv "$NEW" "${NEW}_old"
  mv "${NEW}.pub" "${NEW}_old.pub"
  export KEY_PATH="${NEW}_old"
fi

if [ -z $KEY_PATH ]
then
  echo "KEY_PATH var is expected"
  exit 5
fi

ssh-keygen -t rsa -f "${NEW}" -N "" 
scp -i $KEY_PATH "${NEW}.pub" ubuntu@$PRIVATE:~/.ssh/authorized_keys
