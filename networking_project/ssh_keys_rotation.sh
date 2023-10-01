#!/usr/bin/ssh-agent bash

ssh-add $KEY_PATH
ssh -A ubuntu@10.0.0.20 -t ubuntu@10.0.1.77