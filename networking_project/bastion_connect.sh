#!/bin/bash



if [[ -v $KEY_PATH ]]; then
    ssh-agent bash
    ssh-add $KEY_PATH
else
    echo "KEY_PATH env var is expected"
    exit 5
fi

if [[ -v $1]]; then
  ssh -A ubuntu@$1
  else
  echo "Please provide bastion IP address"
  exit 5

    fi




if [[ -v $]]; then
  ssh ubuntu@$2
else


fi

if [[ -v $3]]; then

eval "$3"
   fi