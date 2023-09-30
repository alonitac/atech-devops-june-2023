#!/bin/bash



# TODO your solution here

if [[-z "${KEY_PATH}" ]]; then
    echo "KEY_PATH env var is expected"
    exit 5 
else
    if ["$#" -eq 0]
    then 
        echo "Please provide bastion IP address"
        exit 5
    elif ["$#" -eq 1]
    then
        ssh -i $KEY_PATH ubuntu@$1
    elif ["$#" -eq 2]
    then
        ssh -tt -i $KEY_PATH ubuntu@$1 ssh -i $KEY_PATH ubuntu@$2
    elif ["$#" -gt 2]
    then
        ssh -tt -i $KEY_PATH ubuntu@$1 ssh -i $KEY_PATH ubuntu@$2 ${@:3}
    fi
    
fi
