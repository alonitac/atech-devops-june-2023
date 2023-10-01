#!/bin/bash


if [[ -n $KEY_PATH ]]; then

  ssh -J -i $KEY_PATH ubuntu@$1 ubuntu@$2

fi