#!/usr/bin/ssh-agent bash

ssh-add $KEY_PATH
ssh ubuntu@$1
