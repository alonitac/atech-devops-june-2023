#!/usr/bin/ssh-agent bash

if[[ -n $KEY_PATH]];then
 ssh-add $KEY_PATH
 if[[ -z $1]];then
  else
    if[[ -z $2]];then
       ssh ubuntu@1
       else
        if[[ -z $3]];then
          ssh -A ubuntu@$1 -t ubuntu@$2
        else
          ssh -A ubuntu@$1 -t ubuntu@$2 -t eval $3
        fi
    fi
 fi
fi