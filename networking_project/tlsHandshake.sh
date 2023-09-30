#!/bin/bash

ClientHello=$(curl -X POST -H "Content-Type: application/json" -d '{"version": "1.3","ciphersSuites": ["TLS_AES_128_GCM_SHA256","TLS_CHACHA20_POLY1305_SHA256"], "message": "Client Hello"}' 127.0.0.1:8080/clienthello)

# Parse the JSON response with jq
sessionID=$(echo "$ClientHello" | jq -r '.sessionID')
echo $ClientHello | jq -r '.serverCert' > cert.pem

#erify the certificate
wget https://raw.githubusercontent.com/alonitac/atech-devops-june-2023/main/networking_project/tls_webserver/cert-ca-aws.pem
openssl verify -CAfile cert-ca-aws.pem cert.pem
if [ $? -ne 0 ]; then
    echo "Server Certificate is invalid."
    exit 5
fi

openssl rand -base64 32 > master_key

MASTER_KEY=(openssl smime -encrypt -aes-256-cbc -in master_key -outform DER cert.pem | base64 -w 0)


# Send the encrypted master-key to the server
response=$(curl -X POST -H "Content-Type: application/json" -d '{"sessionID": "'$SESSION_ID'","masterKey": "'$MASTER_KEY'","sampleMessage": "Hi server, please encrypt me and send to client!"}' 127.0.0.1:8080/keyexchange)

# Parse the JSON response
serverSessionID=$(echo "$response" | jq -r '.sessionID')
encryptedSampleMessage=$(echo "$response" | jq -r '.encryptedSampleMessage')

# Decode the base64-encoded message
echo $encryptedSampleMessage | base64 -d > encSampleMsgReady.txt

# Decrypt the message using OpenSSL
decryptedSampleMessage=$(openssl enc --aes-256-cbc -d -in encSampleMsgReady.txt -Kfile master_key -pbkdf2)

# Compare the decrypted message with the original
if [ "$decryptedSampleMessage" == "Hi server, please encrypt me and send to client!" ]; then
    echo "Client-Server TLS handshake has been completed successfully."
else
    echo "Server symmetric encryption produced incorrect result."
    exit 6
fi
