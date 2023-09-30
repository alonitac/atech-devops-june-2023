#!/bin/bash
#!/bin/bash

SESSION_ID=$(curl -d '{"version": "1.3","ciphersSuites": ["TLS_AES_128_GCM_SHA256","TLS_CHACHA20_POLY1305_SHA256"],"message": "Client Hello"}' -H "Content-Type: application/json" -X POST  44.210.20.184:8080/clienthello   | jq >

serverCert=$(curl -d '{"version": "1.3","ciphersSuites": ["TLS_AES_128_GCM_SHA256","TLS_CHACHA20_POLY1305_SHA256"],"message": "Client Hello"}' -H "Content-Type: application/json" -X POST  44.210.20.184:8080/clienthello   | jq >

openssl verify -CAfile cert-ca-aws.pem cert.pem

if [ $? -ne 0 ]; then
    echo "Server Certificate is invalid."
    exit 5
fi

 MASTER_KEY=$(openssl rand -base64 32)
echo "MasterKey :  $MASTER_KEY"
echo $MASTER_KEY > master_Key_File.txt
cat master_Key_File.txt


#openssl enc -e -aes-256-cbc -salt -in .Master_Key_File -out .encrypted_Master_key -pass file:cert-ca-aws.pem
Encrypt_Master_Key=$(openssl smime -encrypt -aes-256-cbc -in master_Key_File.txt -outform DER cert-ca-aws.pem | base64 -w 0)
echo $Encrypt_Master_Key > encrypt_Master_Key.txt
cat encrypt_Master_Key.txt

curl -d '{"sessionID": '$SESSION_ID', "masterKey":"'$Encrypt_Master_Key'", "sampleMessage": "Hi server how are you"}' -H "Content-Type: application/json" -X POST  44.210.20.184:8080/keyexchange

encryptedSampleMessage=$(curl -d '{"sessionID": '$SESSION_ID', "masterKey": "'$MASTER_KEY'", "sampleMessage": "Hi server how are you"}' -H "Content-Type: application/json" -X POST   44.210.20.184:8080/keyexchange  | jq '.encry>

echo $encryptedSampleMessage > encryptedSampleMessage.txt

echo $encryptedSampleMessage | base64 -d > encSampleMsgReady.txt
echo $MASTER_KEY | base64 -d > masterKey.txt

decrepted_Msg=$(openssl enc --aes-256-cbc -d -in encSampleMsgReady.txt -kfile masterKey.txt -pbkdf2)

if [ "$decrepted_Msg" == "Hi server how are you" ]; then
   echo "OK"

else
   echo "Server symmetric encryption using the exchanged master-key has failed."
   exit 6
fi

# TODO Your solution here