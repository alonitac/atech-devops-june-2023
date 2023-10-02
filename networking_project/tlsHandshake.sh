#!/bin/bash

sudo apt update && apt-get install python3-pip jq -y
pip install aiohttp
python3 app.py

curl -H "Content-Type: application/json" -X POST -o serverHello.json --data '{
   "version": "1.3",
   "ciphersSuites": [
      "TLS_AES_128_GCM_SHA256",
      "TLS_CHACHA20_POLY1305_SHA256"
    ],
   "message": "Client Hello"
}' http://localhost:8080/clienthello


sessionID=$(jq -r ".sessionID" serverHello.json )
serverCert=$(jq -r ".serverCert" serverHello.json )
echo "$serverCert" > cert.pem

wget -O cert-ca-aws.pem https://raw.githubusercontent.com/alonitac/atech-devops-june-2023/main/networking_project/tls_webserver/cert-ca-aws.pem
isValid=$(openssl verify -CAfile cert-ca-aws.pem cert.pem)

if [[ "$isValid" == "cert.pem: OK" ]];then
echo $isValid
else
echo "Server Certificate is invalid"
exit 5
fi

openssl rand -base64 32 > masterkey
openssl smime -encrypt -aes-256-cbc -in masterkey -outform DER cert.pem | base64 -w 0 > masterkey.enc

curl -H "Content-Type: application/json" -X POST -o keyexchange.json -d '{
    "sessionID": "'$sessionID'",
    "masterKey": "'$(cat masterkey.enc)'",
    "sampleMessage": "Hi server, please encrypt me and send to client!"
}' http://localhost:8080/keyexchange




encryptedSampleMessage=$(jq -r ".encryptedSampleMessage" keyexchange.json )
echo $encryptedSampleMessage | base64 -d > encSampleMsgReady.txt


openssl enc -d -aes-256-cbc -in encSampleMsgReady.txt  -out original_message.txt -pbkdf2 -kfile masterkey


if [ $? -ne 0 ]; then
    echo "Server symmetric encryption using the exchanged master-key has failed."
    exit 6
    else
      echo "Client-Server TLS handshake has been completed successfully"
fi



