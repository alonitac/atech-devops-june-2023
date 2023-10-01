#!/bin/bash

cat $KEY_PATH > priKEY
chmod 600 priKEY
scp priKEY ubuntu@$1:~/
ssh -i $KEY_PATH ubuntu@$1 "ssh -i ~/priKEY ubuntu@$2 "
