#!/usr/bin/ssh-agent bash

ssh-add $KEY_PATH
ssh -A -t ubuntu@$1  "ssh ubuntu@$2"
