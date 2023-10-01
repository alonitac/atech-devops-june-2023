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
                ssh -i "$KEY_PATH" -t "ubuntu@$1" "./privatecmd.sh '$privateip $cmd'"
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
