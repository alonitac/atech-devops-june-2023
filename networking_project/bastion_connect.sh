#!/usr/bin/ssh-agent bash


if [[ -n $KEY_PATH ]]; then
  ssh-add $KEY_PATH
  ssh -i $KEY_PATH ubuntu@$1 -t ssh ubuntu@$2

fi