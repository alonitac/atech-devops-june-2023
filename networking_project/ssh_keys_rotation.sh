#!bin/bash


 if [[ -z $1 ]]; then
echo "Please provide IP address"


else


ssh-keygen -b 1024 -f new_key

scp new_key.pub ubuntu@$1:~/.ssh/authorized_keys

fi
