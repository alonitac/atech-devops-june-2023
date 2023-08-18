
#my_solution
echo "Hello $USER!"

export COURSE_ID=DevOpsBootcampElevation

TOKEN_FILE="$HOME/.token"

EXPECTED_PERMISSIONS=600

# Check if  exists
if [[ -e "$TOKEN_FILE" ]]; then
    # Get the octal representation
    ACTUAL_PERMISSIONS=$(stat -c "%a" "$TOKEN_FILE")

    # Compare permissions with expected value
    if [[ "$ACTUAL_PERMISSIONS" -ne "$EXPECTED_PERMISSIONS" ]]; then
        echo "Warning: $TOKEN_FILE file has too open permissions"
    else
        echo "$TOKEN_FILE has correct permissions"
    fi
else
    echo "$TOKEN_FILE does not exist"
fi
#
umask 027

# Adding custom command directory to PATH
export PATH=$PATH:/home/$USER/usercommands

echo "The current date is: $(date -u +"%Y-%m-%dT%H:%M:%S%z")"


alias ltxt='ls *.txt'

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



