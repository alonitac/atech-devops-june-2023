#!/bin/bash
echo "hi"
# Set ngrok authtoken at runtime
/usr/local/bin/ngrok authtoken $NGROK_AUTHTOKEN

# Start ngrok in the background
/usr/local/bin/ngrok http 8443 &

# Wait for ngrok to start and retrieve public URL
sleep 5
export TELEGRAM_APP_URL=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

# Start your Flask app
python app.py
