#!/bin/bash
# Step 1 - Client Hello
CLIENT_HELLO='{
   "version": "1.3",
   "ciphersSuites": [
      "TLS_AES_128_GCM_SHA256",
      "TLS_CHACHA20_POLY1305_SHA256"
    ],
   "message": "Client Hello"
}'

SERVER_RESPONSE=$(curl -X POST http://$PUBLIC_IP:8080/clienthello -H "Content-Type: application/json" -d "$CLIENT_HELLO")
echo $SERVER_RESPONSE
SESSION_ID=$(echo "$SERVER_RESPONSE" | jq -r '.sessionID')
SERVER_CERT=$(echo "$SERVER_RESPONSE" | jq -r '.serverCert')

# Step 2 - Server Certificate Verification
#wget https://raw.githubusercontent.com/alonitac/atech-devops-june-2023/main/networking_project/tls_webserver/cert-ca-aws.pem
openssl verify -CAfile cert-ca-aws.pem <<< "$SERVER_CERT"
echo "$SERVER_CERT" > server_cert.pem
VERIFY_RESULT=$?

if [ $VERIFY_RESULT -ne 0 ]; then
    echo "Server Certificate is invalid."
    exit 5
fi

# Step 3 - Generate Master Key
openssl rand -base64 32 > master_key.txt
# Step 4 - Encrypt Master Key and Send to Server
ENCRYPTED_MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in master_key.txt -outform DER server_cert.pem | base64 -w 0)
# Step 5 - Send Encrypted Master Key to Server
ENCRYPTEDMASTER='{
    "sessionID": "'$SESSION_ID'",
    "masterKey": "'$ENCRYPTED_MASTER_KEY'",
    "sampleMessage": "Hi server, please encrypt me and send to client!"
}'
RESPONSE=$(curl -X POST http://$PUBLIC_IP:8080/keyexchange -H "Content-Type: application/json" -d "$ENCRYPTEDMASTER")
# Step 6 - Decrypt Sample Message
ENCRYPTEDSAMPLEMESSAGE=$(echo "$RESPONSE" | jq -r '.encryptedSampleMessage')
echo ENCRYPTEDSAMPLEMESSAGE | base64 -d > encSampleMsgReady.txt
MASTER_KEY=$(<master_key.txt)
DECRYPTED_MESSAGE=$(echo "$ENCRYPTEDSAMPLEMESSAGE" | base64 -d | openssl enc -d -aes-256-cbc -pbkdf2 -k $MASTER_KEY)
SAMPLE_MESSAGE="Hi server, please encrypt me and send to client!"
if [ "$DECRYPTED_MESSAGE" != "$SAMPLE_MESSAGE" ]; then
    echo "Server symmetric encryption using the exchanged master-key has failed."
    exit 6
fi

echo "Client-Server TLS handshake has been completed successfully"