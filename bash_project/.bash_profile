#!/bin/bash


#User greeeting
echo Hello $USER


#defining the course id
export COURSE_ID="DevOpsBootcampElevation"


#check if .token file exists and if true check its permisions
fileT=/home/$USER/.token
if [ -f  "$fileT" ];
  then
  octal="$(stat -c '%a' $fileT)"

  if [ $octal -ne 600 ];
    then
    echo "Warning: .token file has too open permissions"
  fi
fi


#change the umask
umask 006


#adding new path to linux paths
export PATH="$PATH:/home/$USER/usercommands:PATH"


#print the date
echo The current date is : $(date -Is)


#defining the ltxt command
alias ltxt='ls *.txt'


#check if ~/tmp exists if true clean it if false definr it
tmpDirectory=~/tmp
if [ -d "$tmpDirectory" ];
  then
  rm -f ~/tmp/*
  else
  mkdir ~/tmp
fi


#check if port 8080 if true kill it
if [[ ! -z "$fuser 8080/tcp"]];
  then
  fuser -k 8080/tcp
fi