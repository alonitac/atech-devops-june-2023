#!/bin/bash

# Read the password from user input
read -p "Enter password for new users: " password

# Loop through the users file and create the users with the specified password
while read user; do

    echo "creating $user"

    aws iam create-user --user-name "$user" --profile elv
    aws iam add-user-to-group --group-name students --user-name "$user" --profile elv
    aws iam create-login-profile --user-name "$user" --password "$password" --password-reset-required --profile elv
    sleep 3
done < users.txt