#!/bin/bash
echo Hello $USER
export course_id=DevopsBootcampElevation
if [ -f  "$/home/$USER/.token" ];
   then
   export  octal="$(stat -c '%a' /home/$USER/.token)"
      if [ $octal == 600 ];
        then
        echo Warning .token file has too open permision
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