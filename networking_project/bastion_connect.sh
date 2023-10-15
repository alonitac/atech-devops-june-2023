#!/bin/bash

# Check if KEY_PATH environment variable exists

if [ -z "$KEY_PATH" ]; then
  echo "KEY_PATH env var is expected"
  exit 5
fi

# Check if the script has at least one argument
if [ $# -lt 1 ]; then
  echo "Please provide bastion IP address"
  exit 5
fi

# Set the key file path based on the KEY_PATH environment variable
KEY_FILE="$KEY_PATH"

# Extract the bastion IP address
BASTION_IP="$1"
shift


# If there's another argument, it's the private instance IP
if [ $# -gt 0 ]; then
  PRIVATE_IP="$1"
  shift

  # Check if there are more arguments (command to run on the private machine)
  if [ $# -gt 0 ]; then
    COMMAND="$@"
  fi
fi

# Construct the SSH command depending on whether a private IP is provided
if [ -n "$PRIVATE_IP" ]; then
  if [ ! -n "$PRIVATE_KEY_PATH" ]; then
    PRIVATE_KEY_PATH="$KEY_PATH"
  fi

  if [ -n "$COMMAND" ]; then
    ssh -i "$KEY_FILE" -t -A "ubuntu@$BASTION_IP" "ssh -i new_key -A 'ubuntu@$PRIVATE_IP' \"$COMMAND\""
  else
    ssh -i "$KEY_FILE" -t -A "ubuntu@$BASTION_IP" "ssh -i new_key -A 'ubuntu@$PRIVATE_IP'"
  fi
else
  ssh -i "$KEY_FILE" "ubuntu@$BASTION_IP" "$@"
fi
