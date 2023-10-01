#!/bin/bash


# TODO your solution here

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
# Extract the command from the argument list
  cmnd=${@:3}
  # Connect to private instance through public instance
  ssh -i "$KEY_PATH" -t "ubuntu@$public_ip" "./remote.sh '$2 $cmnd'"
fi


# if [[-z "${KEY_PATH}" ]]; then
#     echo "KEY_PATH env var is expected"
#     exit 5 
# else
#     if ["$#" -eq 0]
#     then 
#         echo "Please provide bastion IP address"
#         exit 5
#     elif ["$#" -eq 1]
#     then
#         ssh -i $KEY_PATH ubuntu@$1
#     elif ["$#" -eq 2]
#     then
#         ssh -tt -i $KEY_PATH ubuntu@$1 ssh -i $KEY_PATH ubuntu@$2
#     elif ["$#" -gt 2]
#     then
#         ssh -tt -i $KEY_PATH ubuntu@$1 ssh -i $KEY_PATH ubuntu@$2 ${@:3}
#     fi
# fi
