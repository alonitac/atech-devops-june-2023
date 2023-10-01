#!/bin/bash -x

eval "$(ssh-agent -s)"


if [[ -n $KEY_PATH ]]; then
  ssh-add $KEY_PATH
  ssh -A  ubuntu@$1 -t << EOF
  ssh -vvv -o "StrictHostKeyChecking no" ubuntu@$2
EOF
fi