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
        ssh -i $KEY_PATH ubuntu@$1 -t "bash ./connectPrivate"
      else
        ssh -i $KEY_PATH ubuntu@$1 -t "export commnad=$3; ./connectPrivateRun "
      fi
    fi
  fi

else
  echo "f"
  exit 5
fi