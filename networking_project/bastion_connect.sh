#!/bin/bash

eval "$(ssh-agent -s)"


if [[ -n $KEY_PATH ]]; then
  ssh-add $KEY_PATH
  ssh -A  ubuntu@$1 << EOF
  ssh ubuntu@$2
EOF

fi