echo Hello $USER
export COURSE_ID=DevOpsBootcampElevation

USER_home_dir="/home/$USER"

permission=$(stat -c "%a" $USER_home_dir/.token 2> /dev/null)
if [ $permission != 600 ]; then
    echo "Warning: .token file has too open permissions"
fi


umask 0006


export PATH=$PATH:$HOME/usercommands

current_date=`date -u +"%Y-%m-%dT%H:%M:%S%z`
echo "The current date is: $current_date"


alias ltxt='ls *.txt'


tmp_dir="$HOME/tmp"
if [[ -d "$tmp_dir" ]]; then
    rm -rf "$tmp_dir"/*
else
    mkdir "$tmp_dir"
fi

process_id=$(lsof -t -i:8080)
if [[ -n "$process_id" ]]; then
    kill "$process_id"
fi

