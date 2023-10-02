#!/bin/bash

if[[ -n $KEY_PATH ]];then


ssh -i $KEY_PATH ubuntu@$1


ssh -i $KEY_PATH ubuntu@$1 -t "bash ./connectPrivate"
else
  echo "f"
  exit 5
  fi