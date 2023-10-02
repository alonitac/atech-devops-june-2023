#!/bin/bash




      ssh -i $KEY_PATH ubuntu@$1


 ssh -i $KEY_PATH ubuntu@$1 -t "bash ./connectPrivate"
