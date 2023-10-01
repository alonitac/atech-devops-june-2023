#!/bin/bash


if [[ -n $KEY_PATH ]]; then

  ssh -A -i $KEY_PATH ubuntu@$1 " ssh ubuntu@$2 ls "

fi