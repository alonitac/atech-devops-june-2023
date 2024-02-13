import boto3
import time
import random

sqs = boto3.client('sqs', region_name='YOUR_REGION_CODE_HERE')
queue_url = 'YOUR_SQS_QUEUE_NAME_HERE'


def process_message(message):
    # Simulate processing
    if random.random() < 0.3:  # 10% chance of failure
        raise Exception("Processing failed")
    else:
        print(f"Processed message: {message['Body']}")


def receive_messages():
    while True:
        response = sqs.receive_message(QueueUrl=queue_url, MaxNumberOfMessages=1)

        if 'Messages' in response:
            message = response['Messages'][0]
            try:
                process_message(message)
                sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=message['ReceiptHandle'])
            except Exception as e:
                print(f"Error processing message: {e}")
                # TODO implement error handling mechanism

        time.sleep(0.1)


if __name__ == '__main__':
    receive_messages()
