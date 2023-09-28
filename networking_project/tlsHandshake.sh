#!/bin/bash

clienthello=$(curl -X POST -H "Content-Type: application/json" -d '{"version": "1.3","ciphersSuites": ["TLS_AES_128_GCM_SHA256","TLS_CHACHA20_POLY1305_SHA256" ], "message": "Client Hello"}' 18.194.208.240:8080/clienthello)
#echo $clienthello

SESSION_ID=$(echo $clienthello | jq -r '.sessionID')
#echo $SESSION_ID

#save cert
certificate=$(echo $clienthello | jq -r '.serverCert')
#echo $certificate
echo "$certificate" > cert.pem

openssl verify -CAfile cert-ca-aws.pem cert.pem
if [ $? -ne 0 ]; then
        echo "Server Certificate is invalid."
        exit 5
fi

#Generate master-key
openssl rand -base64 32 > master_key

#encrypt the master_key with the server certificate
MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in master_key -outform DER cert.pem | base64 -w 0)
#echo $masterkey

enc_key_req=$(curl -X POST -H "Content-Type: application/json" -d '{"sessionID": "'$SESSION_ID'","masterKey": "'$MASTER_KEY'","sampleMessage": "Hi server, Please encrypt me and send to client!"}' 18.194.208.240:8080/keyexchange)
#echo $enc_key_req
echo $enc_key_req | jq -r '.encryptedSampleMessage' | base64 -d > enc_msg.txt

#decrypt the sample msg
decrypt_msg=$(openssl enc -d -aes-256-cbc -in enc_msg.txt -out decrypted_msg.txt -pbkdf2 -kfile master_key)
#echo $decrypt_msg

#check if secryption was successful
if [ $? -eq 0 ]; then
        echo "Client-Server TLS handshake has been completed successfully"
else
        echo "Server symmetric encryption using the exchanged master-key has failed."
        exit 6
fi


# TODO Your solution here