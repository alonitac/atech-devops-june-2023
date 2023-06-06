set -e

USER_PASS=1234

OUTPUT_FILE=terminal_output
function print_terminal_output {
  printf "\nYour terminal output after login is: \n------------------------------------\n\n\n$(cat $OUTPUT_FILE)\n------------------------------------\n\n"
}

function print_test_case {
  printf "\n\n======================================\n%s\n======================================\n\n" "$1"
}

# delete myuser if exists
rm -f -r /home/myuser
if id -u myuser &> /dev/null; then
  userdel myuser
fi

cat .bash_profile > /etc/skel/.bash_profile

adduser myuser --gecos "" --disabled-password
echo "myuser:$USER_PASS" | chpasswd

print_test_case "Case 1: No .token file in user's home dir"

echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "touch .token" > $OUTPUT_FILE
print_terminal_output

if ! grep -q "Hello myuser" "$OUTPUT_FILE"; then
  >&2 printf "Bad greeting. Expected 'Hello myuser' to be found"
  exit 1
fi

if grep -q ".token" "$OUTPUT_FILE"; then
  >&2 printf "There should not be any message regarding .token file since it doesn't exist yet"
  exit 1
fi

print_test_case "Case 2: .token file with bad permissions"

echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "chmod 600 .token" > $OUTPUT_FILE
print_terminal_output

if ! grep -q "Warning: .token file has too open permissions" "$OUTPUT_FILE"; then
  >&2 printf "Expected a message regarding .token permissions: 'Warning: .token file has too open permissions'"
  exit 1
fi

print_test_case "Case 3: .token file with right permissions"

echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "chmod 600 .token" > $OUTPUT_FILE
print_terminal_output

if grep -q ".token" "$OUTPUT_FILE"; then
  >&2 printf "There should not be any message regarding .token file since it has good permissions set"
  exit 1
fi


print_test_case "Case 4: Existed COURSE_ID env var"
echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "printenv" > $OUTPUT_FILE
print_terminal_output

if ! grep -q "COURSE_ID=DevOpsBootcampElevation" "$OUTPUT_FILE"; then
  >&2 printf "Missing environment variable COURSE_ID with value 'DevOpsBootcampElevation'"
  exit 1
fi

print_test_case "Case 5: Correct umask"
echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "umask" > $OUTPUT_FILE
print_terminal_output

if ! grep -q "0006" "$OUTPUT_FILE"; then
  >&2 printf "Bad user umask"
  exit 1
fi

print_test_case "Case 6: Updated PATH env var"
echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c 'echo $PATH' > $OUTPUT_FILE
print_terminal_output


if ! grep -E -q ".*\/home\/myuser\/usercommands" "$OUTPUT_FILE"; then
  >&2 printf "The PATH env var must ends with '/home/myuser/usercommands'"
  exit 1
fi

print_test_case "Case 7: Date in ISO format"

if ! grep -P -q "\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d" "$OUTPUT_FILE"; then
  >&2 printf "ISO format date was not found"
  exit 1
fi

print_test_case "Case 8: ~/tmp dir exists"

echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "stat tmp && touch tmp/test" > $OUTPUT_FILE

if ! grep -q "File: tmp" "$OUTPUT_FILE"; then
  >&2 printf "'~/tmp' dir doesn't exist"
  exit 1
fi

print_test_case "Case 9: ~/tmp cleaned-up"
echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "ls tmp" > $OUTPUT_FILE

if grep -q "test" "$OUTPUT_FILE"; then
  >&2 printf "'~/tmp' dir should be empty after every login"
  exit 1
fi

echo "WELL DONE!!! you've passed all tests!"
