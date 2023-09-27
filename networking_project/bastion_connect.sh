#!/bin/bash

if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi

case "$#" in

  1)
    ssh -i $KEY_PATH  ubuntu@$1
    ;;
  2)
    ssh -t -i $KEY_PATH  ubuntu@$1 "ssh -i  ~/authorized-keys.pem ubuntu@$2 "
    ;;
  3)
    ssh -t -i $KEY_PATH  ubuntu@$1 "./run_command.sh $2 $3"
    ;;
esac



# TODO your solution here