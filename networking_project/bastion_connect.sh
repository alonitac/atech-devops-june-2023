#!/bin/bash

if [[ -z KEY_PATH ]]; then
    echo "KEY_PATH env var is expected"
    exit 5
else

    if [[ -z $1 ]]; then
          echo "Please provide bastion IP address"
          exit 5
    else


      ssh-agent bash
           ssh-add KEY_PATH
           ssh -A ubuntu@$1

          if [[ -z $2 ]]; then
            else
            ssh ubuntu@$2

             if [[ -z $3 ]]; then
               else
                eval "$3"
             fi

          fi
    fi
fi





