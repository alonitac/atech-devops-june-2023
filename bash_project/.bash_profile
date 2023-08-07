#!/bin/bash

# Greeting
echo "Hello $USER!"

# Setting environment variable
export COURSE_ID="DevOpsBootcampElevation"

# Checking and adjusting permissions for .token file
if [ -f ~/.token ]; then
    if [[ $(stat -c '%a' ~/.token) != "600" ]]; then
        echo 'Warning: .token file has too open permissions'
    fi
fi

# Setting umask to restrict default permissions
umask 0006

# Adding custom command directory to PATH
export PATH=$PATH:/home/$USER/usercommands

# Displaying current date in ISO 8601 format
date -u --iso-8601=seconds

# Creating an alias for listing .txt files
alias ltxt='ls *.txt'

# Managing temporary directory
if [ ! -d ~/tmp ]; then
    mkdir ~/tmp
else
    rm -rf ~/tmp/*
fi

# Checking and terminating process on port 8080
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null; then
    echo "Terminating the process running on port 8080..."
    kill -9 $(lsof -t -i:8080)
else
    echo "No process is currently running on port 8080."
fi
