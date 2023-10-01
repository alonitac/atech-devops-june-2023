#!/bin/bash

key=$(cat $KEY_PATH)



ssh -t -i $key ubunte@34.244.57.66 "$key; ssh -i key ubuntu@10.0.1.77 \$key"
