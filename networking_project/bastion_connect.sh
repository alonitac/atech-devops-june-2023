#!/bin/bash

# Check if KEY_PATH environment variable exists
if [ -z "$KEY_PATH" ]; then
  echo "KEY_PATH env var is expected"
  exit 5
fi

# Check if public instance IP is provided
if [ -z "$1" ]; then
  echo "Please provide bastion IP address"
  exit 5
fi

public_ip="$1"

# Check if private instance IP is provided
if [ -z "$2" ]; then
  # Connect to public instance
  ssh -i "$KEY_PATH" "ubuntu@$public_ip"
else
  private_ip="$2"
  shift 2
  # Connect to private instance through public instance
  ssh -i "$KEY_PATH" -t "ubuntu@$public_ip" "ssh -i $KEY_PATH ubuntu@$private_ip $*"
fi