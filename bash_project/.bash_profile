####### greet the user #######
username=$(whoami)
echo Hello $username

####### define COURSE_ID #######
COURSE_ID='DevOpsBootcampElevation'

####### check if .token permission=600 #######
per=$(stat --format="%a" .token)

if [[ $per = 600 ]]; then
        echo
else
        echo Warning: .token file has too open permissions
fi

####### change the umask of the user #######
umask=660

####### print date in ISO format #######
date —iso-8601=s

####### list all file with .txt  #######
alias ltxt='ls * | grep \.txt'

####### create or clean ~/tmp #######
DIR='~/tmp'
if [ -d “$DIR” ]; then
rm /home/$username/tmp/*
else
mkdir ~/tmp
fi

####### kill 8080 #######
kill $(lsof -t -i:8080)










