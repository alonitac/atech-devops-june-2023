#!/bin/bash
if [ $# -lt 1 ]
then
  echo "Enter an IP address"
  exit 5
fi

IP=$1
export Client_hello=$(curl -X POST -H "Content-Type: application/json" -d '{"version": "1.3", "ciphersSuites": ["TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305_SHA256"], "message": "Client Hello" }'  ${IP}:8080/clienthello)
SessionID=$(echo $Client_hello | jq -r '.sessionID')
ServerCert=$(echo $Client_hello | jq -r '.serverCert')

cat <<EOF > ServerCert.pem
$ServerCert
EOF

if ! openssl verify -CAfile cert-ca-aws.pem ServerCert.pem
then
  echo "Server Certificate is invalid "
  exit 5
fi

openssl rand -base64 32 > master_key.txt

MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in master_key.txt -outform DER ServerCert.pem | base64 -w 0)

cat <<EOF > encoded_master_key.txt
$MASTER_KEY
EOF

export server_encrypted=$(curl -X POST -H "Content-Type: application/json" -d '{"sessionID": "'$SessionID'", "masterKey": "'$MASTER_KEY'", "sampleMessage": "Hi server, please encrypt and send to client!"}' ${IP}:8080/keyexchange)
encrypted_sample_msg=$(echo $server_encrypted | jq -r '.encryptedSampleMessage') 
echo $encrypted_sample_msg | base64 -d > encSampleMsgReady.txt

if openssl enc --aes-256-cbc -d -in encSampleMsgReady.txt -kfile master_key.txt -pbkdf2
then
  echo "Client-Server TLS handshake has been completed successfully"
else
  echo "Server symmetric encryption using the exchanged master-key has failed"
  exit 6
fi
