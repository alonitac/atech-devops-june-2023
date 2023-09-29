##!/bin/bash
#exit_state(){
#  local var1=$1
#  if [[ "$var1" == 0 ]] ; then
#    echo "exite succ"
#  fi
#}
#url="ec2-54-78-48-90.eu-west-1.compute.amazonaws.com:8080/clienthello"
#details='{"version": "1.3", "ciphersSuites": ["TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305_SHA256"], "message": "Client Hello" }'
#client_hello="$( curl -X POST -H "Content-Type: application/json" -d "$details"  "$url" )" ; exit_state "$?"
#SESSION_ID=$(echo $client_hello | jq -r '.sessionID')
#server_cert1=$(echo "$client_hello" | jq -r '.serverCert')
#echo $server_cert1
#
#
