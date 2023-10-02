#!/bin/bash


if [[ -n $KEY_PATH ]]; then

  if [[ -z $1 ]]; then
      echo "Please provide bastion IP address"
      exit 5
  else
    if [[ -z $2 ]]; then

      ssh -i $KEY_PATH ubuntu@$1
      else
 if [[ -z $3 ]]; then

 ssh -i $KEY_PATH ubuntu@$1 -t "bash ./connectPrivate"
else

               ssh -i $KEY_PATH ubuntu@$1 -t "bash ./connectPrivate&run "ls""
           fi

     fi



 fi
else
 echo "KEY_PATH env var is expected"
  exit 5

fi