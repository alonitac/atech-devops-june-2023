#!/bin/bash

#check if there is a key path
if [[ -n $KEY_PATH ]]; then
#check if there is a public ip
  if [[ -z $1 ]]; then
    echo "Please provide bastion IP address"
    exit 5
  else
#check if there is public ip and private ip or only private
    if [[ -z $2 ]]; then
      ssh -i $KEY_PATH ubuntu@$1
    else
#check if there is a command to run on private machine
      if [[ -z $3 ]]; then
        ssh -i $KEY_PATH ubuntu@$1 -t "ssh -i ~/new_key ubuntu@$2"
      else
        ssh -i $KEY_PATH ubuntu@$1 -t "ssh -i ~/new_key ubuntu@$2 -t  "${@:3}""
      fi
    fi
  fi

else
  echo "KEY_PATH env var is expected"
  exit 5
fi