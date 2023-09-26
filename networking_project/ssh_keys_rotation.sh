#!/bin/bash

if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected">&2
        exit 5
fi

if [ "$#" -lt 1 ]; then
        echo "Please provide IP address">&2
        exit 5
fi

PRIVATE_IP=$1
#if [ -e new_key ]; then
        #exported path must be new_key so we regenerate on new_key1 
#       cp ~/new_key ~/tmp_key
#       cp ~/new_key.pub ~/tmp_key.pub
ssh-keygen -t rsa -f ~/tmp_key -N ""
#fi


#ssh-copy-id -i ~/new_key.pub ubuntu@$PRIVATE_IP
#NEW_PATH=~/new_key
#OLD_KEY=$(cat ~/key.pem)

#ssh -i ~/key.pem ubuntu@$PRIVATE_IP "sed -i '/$OLD_KEY/d' ~/.ssh/authorized_keys"

scp -i $KEY_PATH ~/tmp_key.pub ubuntu@$PRIVATE_IP:~/

ssh -i $KEY_PATH ubuntu@$PRIVATE_IP "cat ~/tmp_key.pub > ~/.ssh/authorized_keys && rm ~/tmp_key.pub"
cp ~/tmp_key ~/new_key && rm ~/tmp_key
cp ~/tmp_key.pub ~/new_key.pub && rm ~/tmp_key.pub

echo "Key rotation completed, use the new key to connect to the private instance"


