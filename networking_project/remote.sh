#! /bin/bash

PRIVATE_IP=$1
COMMAND=$2

if [ -z "$COMMAND" ]; then
        # ssh using the new generated key - new_key1
        ssh -tt -i ~/new_key ubuntu@$PRIVATE_IP
else
        ssh -i ~/new_key ubuntu@$PRIVATE_IP $COMMAND
fi