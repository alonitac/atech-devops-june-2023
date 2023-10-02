#!/bin/bash

if [[ -n $KEY_PATH ]]; then
  if [[ -z $1 ]]; then
    echo "R"
    exit 5
  else
    if [[ -z $2 ]]; then
      ssh -i $KEY_PATH ubuntu@$1
    else
    echo "r"
    fi
  fi
else
  echo "f"
  exit 5
fi