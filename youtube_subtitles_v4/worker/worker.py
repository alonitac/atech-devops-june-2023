import json
from pytube import YouTube
import boto3
from moviepy.editor import AudioFileClip
from transformers import pipeline
from loguru import logger

topic_arn = 'YOUR_SNS_TOPIC_NAME_HERE'
queue_name = 'YOUR_SQS_QUEUE_NAME_HERE'

sqs_client = boto3.client('sqs', region_name='YOUR_REGION_CODE_HERE')
sns_client = boto3.client('sns', region_name='YOUR_REGION_CODE_HERE')


def consume():
    while True:
        response = sqs_client.receive_message(QueueUrl=queue_name, MaxNumberOfMessages=1, WaitTimeSeconds=5)

        if 'Messages' in response:
            message = response['Messages'][0]['Body']
            receipt_handle = response['Messages'][0]['ReceiptHandle']
            msg_id = response['Messages'][0]['MessageId']

            print("Received message:", message)

            try:
                yt = YouTube(message)
                audio_stream = yt.streams.filter(only_audio=True).first()
                filename = yt.title.replace(' ', '_') + '.mp4'
                audio_stream.download(filename=filename)

                audio = AudioFileClip(filename)
                audio.write_audiofile(filename + '.flac', codec='flac')

                filename = filename + '.flac'
                result = generator(filename)

                # TODO (1) write results to DynamoDB table, and (2) publish a message to the SNS topic
                # TODO what should come first? (1) or (2)?

                sqs_client.delete_message(QueueUrl=queue_name, ReceiptHandle=receipt_handle)

            except Exception as e:
                print(str(e))


if __name__ == '__main__':
    generator = pipeline(model="openai/whisper-tiny")
    consume()
