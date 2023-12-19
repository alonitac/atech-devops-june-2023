#!/bin/bash

PROFILE=''

# Read the password from user input
read -p "Enter password for new users: " PASSWORD

# Loop through the users file and create the users with the specified password
while read user; do

    echo "creating $user"

    aws iam create-user --user-name "$user" --profile $PROFILE
    aws iam add-user-to-group --group-name students --user-name "$user" --profile $PROFILE
    aws iam create-login-profile --user-name "$user" --password "$PASSWORD" --password-reset-required --profile $PROFILE
    sleep 3
done < users.txt