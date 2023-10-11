#!/bin/bash
clientHello=$(curl -X POST -H "Content-Type: application/json" -d '{"version": "1.3","ciphersSuites": ["TLS_AES_128_GCM_SHA256","TLS_CHACHA20_POLY1305_SHA256" ], "message": "Client Hello"}' 3.145.80.154:8080/clienthello)

SESSION_ID=$(echo $clientHello | jq -r '.sessionID')

echo "$clientHello" | jq -r '.serverCert' > cert.pem

wget https://raw.githubusercontent.com/alonitac/atech-devops-june-2023/main/networking_project/tls_webserver/cert-ca-aws.pem
openssl verify -CAfile cert-ca-aws.pem cert.pem

if [ "$?" -ne 0 ]; then
  echo "Server Certificate is invalid."
  exit 5
fi


# generate the master key
openssl rand -base64 32 > master_key

masterKey=$(openssl smime -encrypt -aes-256-cbc -in master_key -outform DER cert.pem | base64 -w 0)


responseKey=$(curl -X POST -H "Content-Type: application/json" -d '{"sessionID": "'$SESSION_ID'","masterKey": "'$masterKey'","sampleMessage": "Hi server, please encrypt me and send to client!"}' 3.145.80.154:8080/keyexchange)

msg=$(echo "$responseKey" | jq -r '.encryptedSampleMessage')

echo "$msg" | base64 -d > enc_massage



# Decrypt
decrypted=$(openssl enc -aes-256-cbc -d -in enc_message -kfile master_key -pbkdf2 )

## check

if [ $decrypted == "" || $decrypted == "Server bad message" ]
then
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 6
else
  echo "Client-Server TLS handshake has been completed successfully"
fi
