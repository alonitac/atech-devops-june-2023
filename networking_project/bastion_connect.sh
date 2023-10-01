#!/bin/bash


if [[ -n $KEY_PATH ]]; then

  ssh -i $KEY_PATH ubuntu@$1 "ssh ubuntu@$2"

fi