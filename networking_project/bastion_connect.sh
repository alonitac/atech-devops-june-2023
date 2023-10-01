#!/bin/bash

cat $KEY_PATH > priKEY
scp priKEY ubuntu@$1:~/
ssh -i $KEY_PATH ubuntu@$1 "ssh -i ~/priKEY ubuntu@$2 "
