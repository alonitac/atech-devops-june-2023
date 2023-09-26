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
        ssh -i $KEY_PATH ubuntu@$1 ssh -i $KEY_PATH ubuntu@$2
    elif ["$#" -eq 3]
    then
        args_string=""
        for ((i = 2; i <= $#; i++)); do
            args_string="${args_string}${i}"
        done
        args_string="${args_string%}"

        ssh -i $KEY_PATH ubuntu@$1 ssh -i $KEY_PATH ubuntu@$2 $args_string
fi