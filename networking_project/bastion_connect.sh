#!/bin/bash

key=$(cat $KEY_PATH)



ssh -t -i $key ubunte@$1 "$key; ssh -i key ubuntu@$2 \$key"
