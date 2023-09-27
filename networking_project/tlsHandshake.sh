#!/bin/bash

res=$(curl -X POST -H "Content-Type: application/json" -d '{
   "version": "1.3",
   "ciphersSuites": [
      "TLS_AES_128_GCM_SHA256",
      "TLS_CHACHA20_POLY1305_SHA256"
    ],
   "message": "Client Hello"
}' 13.51.159.51:8080/clienthello)

SESSION_ID=$(echo "$res" | jq -r '.sessionID')
echo "$res" | jq -r '.serverCert' > cert.pem

if ! openssl verify -CAfile cert-ca-aws.pem cert.pem; then
  echo "Server Certificate is invalid."
  exit 5
fi

openssl rand -base64 32 > key_master.txt
MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in key_master.txt -outform DER cert.pem | base64 -w 0)

res_1=$(curl -X POST -H "Content-Type: application/json" -d '{
    "sessionID": "'$SESSION_ID'",
    "masterKey": "'$MASTER_KEY'",
    "sampleMessage": "Hi server, please encrypt me and send to client!"
}' http://13.51.159.51:8080/keyexchange)


massage=$(echo "$res_1" | jq -r '.encryptedSampleMessage')

echo $massage | base64 -d > encSampleMsgReady.txt

decrepted=$(openssl enc --aes-256-cbc -d -in encSampleMsgReady.txt -kfile key_master.txt -pbkdf2)


if [ "$decrepted" == "" ]; then
   echo "Server symmetric encryption using the exchanged master-key has failed."
   exit 6
else
   echo "Client-Server TLS handshake has been completed successfully"
fi


# TODO Your solution here