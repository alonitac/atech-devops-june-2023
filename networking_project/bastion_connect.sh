#!/bin/bash


# TODO your solution here
#!/bin/bash

#!/bin/bash
publicip=$1
privateip=$2

if [ -z "${KEY_PATH}" ]; then
        echo "KEY_PATH env var is expected"
        exit 5 
else
        if [ "$#" -eq 0 ]
        then 
                echo "Please provide bastion IP address"
                exit 5
        elif [ "$#" -eq 1 ]
        then
                ssh -i "$KEY_PATH" ubuntu@"$publicip"
        
        else
                cmd=${@:3}
                ssh -i "$KEY_PATH" -t "ubuntu@$publicip" "./privatecmd.sh $privateip $cmd"
        fi
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

###############ROTATION CODE###############
# KEY_PATH=~/new_key

# if [ -z "${KEY_PATH}" ]; then
#         echo "KEY_PATH env var is expected"
#         exit 5
# elif [ "$#" -lt 1 ]; then
#         echo "Please provide IP address"
#         exit 5
# else
#         ssh-keygen -t rsa -f ~/old_key -N ""

#         echo "1"

#         scp -i $KEY_PATH /old_key.pub ubuntu@$1:/

#         echo "2"
#         ssh -tt -i $KEY_PATH ubuntu@$1 "cat ~/old_key.pub > ~/.ssh/authorized_keys && rm ~/old_key.pub"
#         echo "3"
#         mv  ~/old_key ~/new_key
#         echo "4"
#         mv ~/old_key.pub ~/new_key.pub

# fi