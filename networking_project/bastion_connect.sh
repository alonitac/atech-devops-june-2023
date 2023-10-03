#!/bin/bash

if [[ -n $KEY_PATH ]]; then
  if [[ -z $1 ]]; then
    echo "R"
    exit 5
  else
    if [[ -z $2 ]]; then
      ssh -i $KEY_PATH ubuntu@$1
    else
      if [[ -z $3 ]]; then
        ssh -i $KEY_PATH ubuntu@$1 -t "ssh -i ~/new_key ubuntu@$2"
      else
        ssh -i $KEY_PATH ubuntu@$1 -t "ssh -i ~/new_key ubuntu@10.0.1.192 -t  "${@:3}""
      fi
    fi
  fi

else
  echo "f"
  exit 5
fi