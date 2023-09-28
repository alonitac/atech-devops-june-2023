#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stoppi ng. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
fi
#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stoppi ng. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi




#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
#!/bin/bash

function VerifySSHKey() {
#!/bin/bash

function VerifySSHKey() {
#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi


# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >
!/bin/bash

function VerifySSHKey() {
#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi
!/bin/bash

function VerifySSHKey() {
#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi


# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi


fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi


#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi


#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
#!/bin/bash

function VerifySSHKey() {
# Test the old key first to make sure it works

    echo "Testing the current private EC2 key passed in the command line..."
    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" >

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
        echo "KEY_PATH env var is expected"
        exit 5
fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi


fi

if [ "$#" -lt 1 ]; then
        echo "Please prodive bastion IP address"
        exit 5
fi


        exit 5
fi


    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" who && RETURN_CODE=$? || RETURN_CODE=$?

    if [ "$RETURN_CODE" -ne 0 ] ; then
        >&2 echo "Unable to connect via SSH using the EC2 key '$OLD_KEY_FILE'"
        >&2 echo "Stopping. No keys were rotated."
        exit 5
    else
        echo "EC2 key '$OLD_KEY_FILE' works."
    fi

}



if [ -z $KEY_PATH ]; then
      echo "KEY_PATH env var is expected"
      exit 5
fi

if [ "$#" -lt 1 ]; then
      echo "Please prodive bastion IP address"
      exit 5
fi


echo "Starting key rotation process..."

OLD_KEY_FILE=new_key.pem
EC2_USER=ubuntu
EC2_HOST=$1

VerifySSHKey



# Create a new private key via ssh-keygen
echo "uthorized-keys"
echo "Generating new keys..."
cd "$__dir"
#NEW_KEY_LABEL=EC2-Key
# NEW_KEY_NAME="$NEW_KEY_LABEL"-$(date +"%Y-%m-%d-%H%M%S")
NEW_KEY_NAME="new_key"
NEW_PRIVATE_KEY_FILE="$NEW_KEY_NAME.pem"
NEW_PUBLIC_KEY_FILE="$NEW_KEY_NAME.pub"

ssh-keygen -t rsa -f "$NEW_KEY_NAME.pem" -q -N "" -C "$NEW_KEY_NAME"
mv "$NEW_KEY_NAME.pem.pub" "$NEW_PUBLIC_KEY_FILE"
NEW_PUBLIC_KEY=$(cat "$NEW_PUBLIC_KEY_FILE")

# Display new key info
echo "---------------------------------------"
echo "New key name: $NEW_KEY_NAME"
echo "New private key file: $NEW_KEY_NAME.pem"
echo "New public key file: $NEW_KEY_NAME.pub"
echo "Files are located in directory: $__dir"
echo "---------------------------------------"
echo ""

# Test the new key: Add the new key to the authorized keys on the instance, update a test file, and re-log in
# with the new key to retrieve the test value
echo "Testing new key..."
echo $(cat "$NEW_PUBLIC_KEY_FILE") | ssh -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" \
    "cat >> ~/.ssh/authorized_keys"

TEST_VALUE="Testing 123"
echo "$TEST_VALUE" | ssh -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" "cat > ~/.rotation_test_file"
NEW_TEST_VALUE=$(ssh -o StrictHostKeyChecking=no -q -i "$NEW_PRIVATE_KEY_FILE" "$EC2_USER@$EC2_HOST" "cat ~/.rotation_test_file")

if [ "$NEW_TEST_VALUE" != "$TEST_VALUE" ] ; then
    >&2 echo "Test with the new key failed. Stopping."
    exit 4
fi

echo "Test successful. Removing old key..."

if [ "$PLATFORM" == "coreos" ]; then
    # First, replace the public ssh key mananged by the CoreOS boot manager, ignition. This is stored in:
    # ~/.ssh/authorized_keys.d/coreos-ignition.
    # Ignition is a replacement for cloud-init. You can't run cloud-init if you want to rotate keys on CoreOS, because
    # cloud-init will ignore your changes and pull the EC2 key from the EC2 meta-data on every reboot.
    ssh -o StrictHostKeyChecking=no -q -i "$OLD_KEY_FILE" "$EC2_USER@$EC2_HOST" \
            "echo $NEW_PUBLIC_KEY > ~/.ssh/authorized_keys.d/coreos-ignition && update-ssh-keys"
else
    # Get a sed-search-safe version of the public key that escapes forward slashes contained in the key
    OLD_PUBLIC_KEY=$(ssh-keygen -y -f $OLD_KEY_FILE)
    OLD_PUBLIC_KEY=$(echo "$OLD_PUBLIC_KEY" | sed 's/\//\\\//g')

     # Remove the old key from ~/.ssh/authorized_keys
    ssh -o StrictHostKeyChecking=no -q -i "$NEW_PRIVATE_KEY_FILE" "$EC2_USER@$EC2_HOST" \
            "sed -i \"/$OLD_PUBLIC_KEY/d\" ~/.ssh/authorized_keys"
fi

# Test again with new key
echo "Re-testing new key..."
NEW_TEST_VALUE=$(ssh -o StrictHostKeyChecking=no -q -i "$NEW_KEY_NAME.pem" "$EC2_USER@$EC2_HOST" "cat ~/.rotation_test_file")

if [ "$NEW_TEST_VALUE" != "$TEST_VALUE" ] ; then
    >&2 echo "WARNING: Second test with the new key failed. Try accessing EC2 instance immediately."
    exit 4
fi

echo "Second test successful. Keys have been rotated. Please keep your new key files in a secure location."

# Cleanup the temp file used for testing
ssh -o StrictHostKeyChecking=no -q -i "$NEW_KEY_NAME.pem" "$EC2_USER@$EC2_HOST" "rm -f ~/.rotation_test_file"

# Update the EC2 instance to include a tag with the key name
#echo "Updating the instance tag to include the key name..."
#aws ec2 create-tags --resources "$INSTANCE_ID" --tags Key=EC2KeyName,Value="$NEW_KEY_NAME"

echo "Rotation complete"

# Test again with new key
echo "Re-testing new key..."
NEW_TEST_VALUE=$(ssh -o StrictHostKeyChecking=no -q -i "$NEW_KEY_NAME.pem" "$EC2_USER@$EC2_HOST" "c>

if [ "$NEW_TEST_VALUE" != "$TEST_VALUE" ] ; then
    >&2 echo "WARNING: Second test with the new key failed. Try accessing EC2 instance immediately."
    exit 4
fi

echo "Second test successful. Keys have been rotated. Please keep your new key files in a secure lo>

# Cleanup the temp file used for testing
ssh -o StrictHostKeyChecking=no -q -i "$NEW_KEY_NAME.pem" "$EC2_USER@$EC2_HOST" "rm -f ~/.rotation_>

# Update the EC2 instance to include a tag with the key name
#echo "Updating the instance tag to include the key name..."
#aws ec2 create-tags --resources "$INSTANCE_ID" --tags Key=EC2KeyName,Value="$NEW_KEY_NAME"

echo "Rotation complete"
