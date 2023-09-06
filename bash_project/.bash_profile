# your solution here...
echo Hello $USER
export COURSE_ID=DevOpsBootcampElevation

USER_home_dir="/home/$USER"
token_permissions=$(stat -c "%a" $USER_home_dir/.token 2> /dev/null)
if [ $token_permissions != 600 ]; then
    echo "Warning: .token file has too open permissions"
fi

# Set umask for new files
umask 0077

# Add directory to PATH
export PATH=$PATH:$HOME/usercommands

# Print current date in ISO 8601 format (UTC)
echo "The current date is: $(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Alias for ltxt
alias ltxt='ls *.txt'

# Create or clean ~/tmp directory
tmp_dir="$HOME/tmp"
if [[ -d "$tmp_dir" ]]; then
    rm -rf "$tmp_dir"/*
else
    mkdir "$tmp_dir"
fi

# Kill process bound to port 8080 (if exists)
process_id=$(lsof -t -i:8080)
if [[ -n "$process_id" ]]; then
    kill "$process_id"
fi







