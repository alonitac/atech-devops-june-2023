#!/bin/bash


if [ -z "$KEY_PATH" ];
then
  echo "KEY_PATH env var is expected"
  exit 5

else
  if [[ $# -eq 0 ]];
  then
     echo "provide IP adresses"
     exit 5

  elif [[ $# -eq 1 ]];
  then
    ssh -ti $KEY_PATH ubuntu@$1
  elif [[ $# -eq 2 ]];
  then
    ssh -ti $KEY_PATH ubuntu@$1 ssh -ti test_key.pem ubuntu@$2
  elif [[ $# -eq 3 ]];
  then
    ssh -i $KEY_PATH ubuntu@$1 ssh -i test_key.pem ubuntu@$2 $3
  fi
fi

# TODO your solution here