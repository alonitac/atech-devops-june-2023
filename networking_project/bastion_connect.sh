#!/bin/bash

#!/bin/bash

if [ -z "$KEY_PATH" ]; then
        echo "Error: KEY_PATH enviroment variable is not set. "
        exit 5
fi

KEY_PATH=/home/devops/Desktop/key.pem
PUBLIC_INSTANCE_IP="13.50.248.163"
PRIVATE_INSTANCE_IP="10.0.1.196"
USER="ubuntu"


ssh -t -i "$KEY_PATH" "$USER"@"$PUBLIC_INSTANCE_IP" "ssh -i key.pem  ubuntu@10.0.1.196"



# TODO your solution here