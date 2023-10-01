#!/bin/bash

scp $KEY_PATH ubuntu@$1:~/
ssh -i $KEY_PATH ubuntu@$1 "ssh -i ~/ ubuntu@$2 "
