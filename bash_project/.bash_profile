#greet the user:
# username=$(whoami)
# echo Hello $username

echo Hello $USER

#define COURSE_ID:
export COURSE_ID='DevOpsBootcampElevation'

#check .token permission:
token="$HOME/.token"
if [ -f "$token" ]; then
   per=$(stat --format="%a" "$token")
   if [[ $per != 600 ]]; then
      echo Warning: .token file has too open permissions
   fi
fi

#change  umask:
umask 0006

#change PATH:
PATH=$PATH/home/$USER/usercommands

#print date in ISO format:
date -u --iso-8601=s


#list all file with .txt:
alias ltxt='ls * | grep \.txt'

#create ~/tmp:

if [ -d $HOME/tmp ]
 then
 rm -rf $HOME/tmp/*
 else
 mkdir $HOME/tmp
fi

# kill 8080:
pid=$(lsof -t -i:8080)
if [ -n "$pid" ]; then
    kill "$pid"
fi


