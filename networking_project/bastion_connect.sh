#!/usr/bin/ssh-agent bash


if [[ -n $KEY_PATH ]]; then
  ssh-add $KEY_PATH
  ssh -A  ubuntu@$1 " ssh ubuntu@$2 ls "

fi