#!/bin/bash
if [[ -z $KEY_PATH ]] ; then
  echo 'KEY_PATH env var is expected'
  exit 2
fi
CMD="ssh -i $KEY_PATH"
if [[ -z $1 ]] ; then
  echo 'Please provide bastion IP address'
  exit 2
fi
if [[ -n $3 ]] ; then
  CMD="$CMD -o ProxyCommand=\"ssh -W %h:%p -i $KEY_PATH ubuntu@$1\"  ubuntu@$2 $3"
  else
    CMD="$CMD ubuntu@$1 $2"
fi
eval $CMD

