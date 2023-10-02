#!/bin/bash

if [[ -n $KEY_PATH ]]; then
  if [[ -z $1]]
  echo "R"
  exit 5
  else
    ssh -i $KEY_PATH ubuntu@$1
    ssh -i $KEY_PATH ubuntu@$1 -t "bash ./connectPrivate"
  fi
else
  echo "f"
  exit 5
fi