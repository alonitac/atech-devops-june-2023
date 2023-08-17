#!/bin/bash

echo "Hello $USER"

# Define an environment variable
export COURSE_ID=DevOpsBootcampElevation

# Check the token file permissions
token="$HOME/.token"
if [ -e "$token" ]; then
  if [[ $(stat -c %a "$token") != "600" ]]; then
        echo "Warning: .token file has too open permissions"
    fi
fi

# Change umask
umask 0006

# Add to end of path
export PATH="$PATH:/home/$USER/usercommands"

# Print current date
echo "Date: $(date -u +'%Y-%m-%dT%H:%M:%S%z')"

# Define a command alias
alias ltxt='ls *.txt'

# Create /tmp directory if it doesn't exist, and clean it if it does
tmp_dir=~/tmp
if [ ! -d "$tmp_dir" ]; then
    mkdir "$tmp_dir"
else
    rm -rf "$tmp_dir"/*
fi

# Kill process bound to port 8080 if it exists
process=$(lsof -i :8080 -t)
if [ -n "$process" ]; then
    kill "$process"
fi

echo "Ibrahim Qassem :D"