from flask import Flask, render_template, request, jsonify
import boto3
from loguru import logger


app = Flask(__name__)

queue_name = 'YOUR_SQS_QUEUE_NAME_HERE'
sqs_client = boto3.client('sqs', region_name='YOUR_REGION_HERE')


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/submit', methods=['POST'])
def submit_youtube_url():
    youtube_url = request.form.get('youtube_url')
    response = sqs_client.send_message(QueueUrl=queue_name, MessageBody=youtube_url)
    return jsonify(status=200, job_id=response['MessageId'])


if __name__ == '__main__':
    app.run(port=8080, host='0.0.0.0')
