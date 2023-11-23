echo "Hello $USER"
export COURSE_ID="DevOpsBootcampElevation"
if [ -f ~/.token ];then
  if [[ "$(stat --format %a ~/.token)" != 600 ]];then
    echo 'Warning: .token file ha too open permissions'
  fi
fi
umask 0006
export  PATH=$PATH:/home/$USER/usercommands

echo "Date: $(date -u +'%Y-%m-%dT%H:%M:%S%z')"

alias ltxt='ls *.txt'
if [[ ! -d "~/tmp" ]]; then
  mkdir ~/tmp
else
  rm -rf ~/tmp/*
fi

process=$(lsof -i :8080 -t)
if [ -n "$process" ]; then
    kill "$process"
fi
