#!/bin/bash
echo Hello $USER
export course_id=DevopsBootcampElevation

fileT=/home/$USER/.token
if [ -f  "$fileT" ];
then
octal="$(stat -c '%a' $fileT)"
echo "$octal"
if [ $octal -ne 600 ];
then
echo "Warning: .token file has too open permissions"
fi
fi
umask u=rw,g=rw
export PATH="$PATH:/home/$USER/usercommands:PATH"
echo The current date is : $(date -Is)
echo "">a.txt
alias ltxt='ls *.txt'
tmpDirectory=~/tmp
if [ -d "$tmpDirectory" ];
  then
  rm -f ~/tmp/*
  else
  mkdir ~/tmp
fi
fuser -k 8080/tcp