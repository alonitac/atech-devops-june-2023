#!/bin/bash

client_hello=$(curl -X POST -H "Content-Type: application/json" -d '{"version": "1.3", "ciphersSuites": ["TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305_SHA256"], "message": "Client Hello" }'  3.79.154.114:8080/clienthello)
# echo $client_hello
# Save Session id
#session_id=$(echo $client_hello | awk '{print $4}')
SESSION_ID=$(echo $client_hello | awk '{print $4}' | sed 's/.\{2\}$//' | sed -e '1s/^.//')
#echo $session_id

# Save server Certificate
server_cert=$(echo $client_hello | awk '{print $8,$9}' | sed -e '1s/^.//')
#echo $server_cert > server_cert.pem
#echo $server_cert
server_cert=$(echo $client_hello | awk '{print $8,$9.$10,$11,$12}' | sed -e '1s/^.//' | sed 's/.\{4\}$//')
echo $server_cert > server_cert1.pem
sed -i 's/\\n/\n/g' server_cert1.pem 
sed -i 's/ENDCERTIFICATE/END CERTIFICATE/' server_cert1.pem
#sed -i -e '$ { /^$/ d; }' server_cert1.pem
# cat server_cert1.pem

openssl verify -CAfile cert-ca-aws.pem server_cert1.pem 
if [ "$?" -ne 0 ]; then 
	echo "Server Certificate is invalid.">&2
	exit 5
fi
openssl rand -base64 32 > master_key.txt

MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in master_key.txt -outform DER server_cert1.pem | base64 -w 0)
#MASTER_ID=$(cat encrypted_master.txt)
echo $MASTER_KEY > encoded_master.txt
server_encrypted=$(curl -X POST -H "Content-Type: application/json" -d '{"sessionID": "'$SESSION_ID'", "masterKey": "'$MASTER_KEY'", "sampleMessage": "Hi server, please encrypt and send to client!"}' 3.79.154.114:8080/keyexchange)

encrypted_message=$(echo $server_encrypted | awk '{print $4}' | sed 's/.\{2\}$//' | sed -e '1s/^.//')
echo ""
#echo $server_encrypted
echo ""
#touch decrypted_message.txt
#echo $encrypted_message
echo ""
echo $encrypted_message | base64 -d > encoded.txt
#cat decoded.txt
#decrypted=$(openssl smime -decrypt -inform DER -in decoded.txt -inkey master_key.txt)

decrypted=$(openssl enc --aes-256-cbc -d -in encoded.txt -kfile master_key.txt -pbkdf2)
echo ""
echo $decrypted
echo ""
if [[ $decrypted == "" ]]; then
	echo "Server symmetric encryption using the exchanged master-key has failed."
else
	echo "Client-Server TLS handshake has been completed successfully"
fi
#echo $?
echo ""
