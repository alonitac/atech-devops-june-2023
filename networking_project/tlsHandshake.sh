#!/bin/bash



RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d '{"version": "1.3","ciphersSuites": ["TLS_AES_128_GCM_SHA256","TLS_CHACHA20_POLY1305_SHA256" ], "message": "Client Hello"}' 18.226.201.60:8080/clienthello)

SESSION_ID=$(echo $RESPONSE | jq -r '.sessionID')

echo $RESPONSE | jq -r '.serverCert' > cert.pem

openssl verify -CAfile cert-ca-aws.pem cert.pem

if [ ! $? ]
then 
	echo "Server Certificate is invalid."
	exit 5
fi

openssl rand -base64 32 > masterKey

MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in masterKey -outform DER cert.pem | base64 -w 0)

KEY_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d '{"sessionID": "'$SESSION_ID'","masterKey": "'$MASTER_KEY'","sampleMessage": "Hi server, please encrypt me and send to client!"}' 18.226.201.60:8080/keyexchange)

echo $KEY_RESPONSE | jq -r '.encryptedSampleMessage' | base64 -d > encSampleMsgReady.txt

openssl enc -d -aes-256-cbc -in encSampleMsgReady.txt -out decryptedMsg.txt -pbkdf2 -kfile masterKey

if [ ! $? ] 
then 
	echo "Server symmetric encryption using the exchanged master-key has failed."
	exit 6
else
	echo "Client-Server TLS handshake has been completed successfully"
fi
