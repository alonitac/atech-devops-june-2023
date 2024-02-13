import boto3
import time
import json
import uuid

# Create an SQS client
sqs = boto3.client('sqs', region_name='YOUR_REGION_CODE_HERE')

queue_url = 'YOUR_SQS_QUEUE_NAME_HERE'


def send_messages():
    while True:
        for i in range(5):
            message_body = {
                'retry': 0,
                'job_id': str(uuid.uuid4())
            }
            response = sqs.send_message(QueueUrl=queue_url, MessageBody=json.dumps(message_body))
            print(f"Sent message: {message_body}, MessageId: {response['MessageId']}")

        time.sleep(1)


if __name__ == '__main__':
    send_messages()
