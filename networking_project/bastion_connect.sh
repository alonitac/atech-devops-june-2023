!/bin/bash

#bad usage
if [ ! $KEY_PATH ]
then 
        echo "KEY_PATH env var is expected"
        exit 5
fi

#bad usage
if [ $# -lt 1 ]
then 
        echo "Please provide bastion IP address"
        exit 5
#connect to public instance
elif [ $# -eq 1 ]
then 
        ssh -i $KEY_PATH ubuntu@$1
#connect to private instance from local machine
elif [ $# -eq 2 ]
then 
        ssh -i $KEY_PATH ubuntu@$1 "./ssh_private_instance.sh $2"
#run a command in the private machine
else 
        ssh -i $KEY_PATH ubuntu@$1 "./ssh_private_instance.sh $2 ${@:3}"
fi
