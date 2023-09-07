#!/bin/bash

# print Hello to the new user
echo "Hello $USER"

export COURSE_ID="DevOpsBootcampElevation"


TOKEN="$HOME/.token"
if [[ -f "$TOKEN" ]]; then
    permissions=$(stat -c %a "$TOKEN")
    # If the octal representation of the permissions set is different from 600
    if [[ $permissions -ne 600 ]]; then
        echo "Warning: .token file has too open permissions"
    fi
fi

umask 0006

export PATH="$PATH:/home/$USER/usercommands"

# Print the current date
DATE=$(date -u +"%Y-%m-%dT%H:%M:%S%z")
echo "The current date is : $DATE"

# alias command that prints all files with .txt extension
alias ltxt='ls *.txt'



TMP="$HOME/tmp"
if [[ -d "$TMP" ]]; then
    #If it exists, clean it's contents
    rm -rf "$TMP"/*
else
    # If it doesn’t exist, create the ~/tmp directory on the user’s home dir
    mkdir "$TMP"
fi


# If it exists, kill the process that is bound to port 8080
PRCSS=$(lsof -t -i:8080)
if [[ -n "$PRCSS" ]]; then
    kill "$PRCSS"
fi