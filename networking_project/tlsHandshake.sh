#!/bin/bash

client_hello=$(curl -X POST -H "Content-Type: application/json" -d '{"version": "1.3", "ciphersSuites": ["TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305_SHA256"], "message": "Client Hello" }'  13.53.186.104:8080/clienthello)
echo $client_hello
exit

SESSION_ID=$(echo $client_hello | jq -r '.sessionID')
server_cert1=$(echo "$client_hello" | jq -r '.serverCert')
echo "$server_cert1" > server_cert.pem

openssl verify -CAfile cert-ca-aws.pem server_cert.pem
if [ "$?" -ne 0 ]; then
	echo "Server Certificate is invalid."
	exit 5
fi

#step4 - Matser-Key Exchange
openssl rand -base64 32 > master_key.txt
MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in master_key.txt -outform DER server_cert.pem | base64 -w 0)
echo $MASTER_KEY > encoded_master.txt
server_encrypted=$(curl -X POST -H "Content-Type: application/json" -d '{"sessionID": "'$SESSION_ID'", "masterKey": "'$MASTER_KEY'", "sampleMessage": "Hi server, please encrypt and send to client!"}' 13.53.186.104:8080/keyexchange)

encrypted_message=$(echo $server_encrypted | awk '{print $4}' | sed 's/.\{2\}$//' | sed -e '1s/^.//')
#echo ""
#echo ""
#echo ""

#encoded in base 64
echo $encrypted_message | base64 -d > encoded.txt

decrypted=$(openssl enc --aes-256-cbc -d -in encoded.txt -kfile master_key.txt -pbkdf2)
echo ""
echo $decrypted
echo ""
if [[ "$decrypted" == "" || "$decrypted" == "Server bad message" ]]; then
	echo "Server symmetric encryption using the exchanged master-key has failed."
	exit 6
else
	echo "Client-Server TLS handshake has been completed successfully"
fi

echo ""