#! /bin/bash

echo "Hello $USER"
export COURSE_ID="DevOpsBootcampElevation"
USER_home_directory="/home/$USER"

token_permissions=$(stat -c "%a" "$USER_home_directory/.token 2> /dev/null")
if [ $token_permissions -ne 600 ]; then
    echo "Warning: .token file has too open permissions"
fi


#change defaule permissions  of new created files to be r and w for the user and group only
umask  0077

#add the home/username/usercommands to the end of the PATH env variable.
export PATH=$PATH:/home/$USER/usercommands

#print the current date
current_date=$(date -Isecond -u)
echo "The current date is : $current_date"

#Define command alias ltxt
alias ltxt="ls *.txt"

#create ~/tmp directory if it doesn't exist , else clean it
tmp_d="$USER_home_directory/tmp"
if [ -d  "$USER_home_directory/tmp" ]; then
    rm -rf "$USER_home_directory/tmp"/*
else
    mkdir "$USER_home_directory/tmp"
fi

#if it exists kill the process that is bound to port 8080
if [ $(lsof -t -i :8080) ]; then
    kill -9 $(lsof -t -i :8080)

