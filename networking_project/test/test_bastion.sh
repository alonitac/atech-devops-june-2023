set -e -x

source ../vpc.sh

PUBLIC_EC2=$(aws ec2 describe-instances --region $REGION --filters "Name=instance-id,Values=$PUBLIC_INSTANCE_ID")
PUBLIC_EC2_IP=$(echo $PUBLIC_EC2 | jq -r '.Reservations[0].Instances[0].PublicIpAddress')
PUBLIC_EC2_PRV_IP=$(echo $PUBLIC_EC2 | jq -r '.Reservations[0].Instances[0].PrivateIpAddress')

PRIVATE_EC2=$(aws ec2 describe-instances --region $REGION --filters "Name=instance-id,Values=$PRIVATE_INSTANCE_ID")
PRIVATE_EC2_IP=$(echo $PRIVATE_EC2 | jq -r '.Reservations[0].Instances[0].PrivateIpAddress')
PRIVATE_EC2_AZ=$(echo $PRIVATE_EC2 | jq -r '.Reservations[0].Instances[0].Placement.AvailabilityZone')

echo "$COURSE_STAFF_SSH_KEY" > course_staff
chmod 400 course_staff

set +e +x
export KEY_PATH=$(pwd)/course_staff

PRIVATE_EC2_ENV_VARS=$(bash ../bastion_connect.sh $PUBLIC_EC2_IP $PRIVATE_EC2_IP printenv)

if [ $? -ne "0" ]
then
  echo -e "\n\nbad bastion_connect.sh script. Could not connect to private instance through the public instance."
  exit 1
else
  echo -e "\nenvironment variables retrieved from the private instance:\n\n$PRIVATE_EC2_ENV_VARS"
  if echo $PRIVATE_EC2_ENV_VARS | grep -q -P "SSH_CONNECTION=$PUBLIC_EC2_PRV_IP .* $PRIVATE_EC2_IP"
  then
    echo -e "\n\ngood bastion_connect.sh script! well done!"
  else
     echo -e "\n\nbad bastion_connect.sh script. bastion_connect.sh connected to private instance and tried to execute the command 'printenv', but either the command was not executed properly, or it was connected to a different private machine to what specified in vpc.sh"
     exit 1
  fi
fi
