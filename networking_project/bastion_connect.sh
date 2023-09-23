#!/usr/bin/ssh-agent bash

if [[ -z KEY_PATH ]]; then
    echo "KEY_PATH env var is expected"
    exit 5
else

    if [[ -z $1 ]]; then
          echo "Please provide bastion IP address"
          exit 5
    else
     if [[ -z $2 ]]; then
       ssh-add KEY_PATH
       ssh -A ubuntu@$1
     else

          if [[ -z $3 ]]; then
            ssh -A ubuntu@$1 -t ssh ubuntu@$2
            else
            ssh -A ubuntu@$1 -t ssh ubuntu@$2 -t eval "$3"
             fi

          fi
    fi
fi





