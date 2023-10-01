#!/bin/bash


ssh-copy-id -i $KEY_PATH ubuntu@$1:~/
ssh -i $KEY_PATH ubuntu@$1 "ssh -i ~/ ubuntu@$2 "
