#!/bin/bash

clienthello=$(curl -X POST -H "Content-Type: application/json" -d '{"version": "1.3","ciphersSuites": ["TLS_AES_128_GCM_SHA256","TLS_CHACHA20_POLY1305_SHA256" ], "message": "Client Hello"}' 3.73.119.203:8080/clienthello)
#echo $clienthello

SESSION_ID=$(echo $clienthello | jq -r '.sessionID')
#echo $SESSION_ID

#save cert
echo "$clienthello" | jq -r '.serverCert' > cert.pem


openssl verify -CAfile cert-ca-aws.pem cert.pem
if [ $? -ne 0 ]; then
        echo "Server Certificate is invalid."
        exit 5
fi

#Generate master-key
openssl rand -base64 32 > master_key

#encrypt the master_key with the server certificate
MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in master_key -outform DER cert.pem | base64 -w 0)

enc_key_req=$(curl -X POST -H "Content-Type: application/json" -d '{"sessionID": "'$SESSION_ID'","masterKey": "'$MASTER_KEY'","sampleMessage": "Hi server, Please encrypt me and send to client!"}' 3.73.119.203:8080/keyexchange)

msg=$(echo $enc_key_req | jq -r '.encryptedSampleMessage')
echo $msg | base64 -d > enc_msg.txt

#decrypt the sample msg
decrypt_msg=$(openssl enc --aes-256-cbc -d -in enc_msg.txt -kfile master_key -pbkdf2)
#echo $decrypt_msg

#check if decryption was successful
if [[ "$decrypt_msg" == "" || "$decrypt_msg" == "Server bad message" ]]; then
        echo "Server symmetric encryption using the exchanged master-key has failed."
        exit 6
else
        echo "Client-Server TLS handshake has been completed successfully"
fi


# TODO Your solution here