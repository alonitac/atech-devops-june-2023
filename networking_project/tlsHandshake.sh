#!/bin/bash

# TODO Your solution here

response=$(curl localhost:8080/clienthello -X POST -H "Content-Type: application/json" -d'{
   "version": "1.3",
   "ciphersSuites": [
      "TLS_AES_128_GCM_SHA256",
      "TLS_CHACHA20_POLY1305_SHA256"
    ], 
   "message": "Client Hello"
}')

export SESSION_ID=echo "$response" | jq '.sessionID'

echo "$response" | jq '.serverCert'>cert.pem

wget https://raw.githubusercontent.com/alonitac/atech-devops-june-2023/main/networking_project/tls_webserver/cert-ca-aws.pem 

openssl verify -CAfile cert-ca-aws.pem cert.pem


if [ $? -ne 0 ]
then
	echo "Server Certificate is invalid."
	exit 5
fi

echo "cert.pem: OK"

# openssl rand -out Master_key -base64 32

openssl rand -base64 32
openssl rand -base64 32 > Master_key.txt


MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in Master_key.txt -outform DER cert.pem | base64 -w 0)

response2=$(curl localhost:8080/keyexchange -X POST -H "Content-Type: application/json" -d'
{
    "sessionID": "'$SESSION_ID'",
    "masterKey": "'$MASTER_KEY'",
    "sampleMessage": "Hi server, please encrypt me and send to client!"
}')

encryptedSample=$response2 | jq '.encryptedSampleMessage'

echo $encryptedSample | base64 -d > encSampleMsgReady.txt

openssl enc -d -aes-256-cbc -salt -in encSampleMsgReady.txt -out original_message.txt -pass file:Master_key.txt

original_message=$(<original_message.txt)

if [ "$original_message" = "Hi server, please encrypt me and send to client!" ]; then
  echo "Client-Server TLS handshake has been completed successfully"

else
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 6
fi