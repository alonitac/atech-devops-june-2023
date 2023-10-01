#!/usr/bin/ssh-agent bash

ssh-add $KEY_PATH
ssh -A ubuntu@$1