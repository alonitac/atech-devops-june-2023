from flask import Flask, render_template, request, jsonify
import boto3
from loguru import logger
import json

app = Flask(__name__)

queue_name = 'YOUR_SQS_QUEUE_NAME_HERE'
topic_arn = 'YOUR_SNS_TOPIC_NAME_HERE'
ngrok_public_url = 'YOUR_SERVER_URL'

# use ngrok to expose your server if you run it locally
server_endpoint = f'https://{ngrok_public_url}/job_update'

sqs_client = boto3.client('sqs', region_name='YOUR_REGION_CODE_HERE')
sns_client = boto3.client('sns', region_name='YOUR_REGION_CODE_HERE')

processed_jobs_ids = {}


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/status')
def check_status():
    job_id = request.args.get('job_id')

    # TODO:
    '''
     1. Check if job_id exists in processed_jobs_ids dict
     2. If exists, query the DynamoDB table to fetch results, and return `jsonify(status=200, response=text)`
     3. else, return `jsonify(status=0)`
    '''


@app.route('/submit', methods=['POST'])
def submit_youtube_url():
    youtube_url = request.form.get('youtube_url')
    response = sqs_client.send_message(QueueUrl=queue_name, MessageBody=youtube_url)
    return jsonify(status=200, job_id=response['MessageId'])


@app.route('/job_update', methods=['POST'])
def job_update():
    data = json.loads(request.get_data().decode())
    if 'Type' in data and data['Type'] == 'SubscriptionConfirmation':
        sns_client.confirm_subscription(TopicArn=data['TopicArn'], Token=data['Token'])
        logger.info(f"Subscribed successfully with SubscriptionArn: {subscription_arn}")
    else:
        # TODO:
        '''
         1. Retrieve the job_id from the `data` object
         2. Add the job_id as a key to dictionary (the value doesn't matter, up to your choice)
        '''
    return "OK"


@app.route('/ready', methods=['get'])
def readiness_probe():
    return 'OK'


if __name__ == '__main__':
    try:
        response = sns_client.subscribe(
            TopicArn=topic_arn,
            Protocol='https',
            Endpoint=server_endpoint
        )

        subscription_arn = response['SubscriptionArn']
    except Exception as e:
        logger.error(str(e))

    app.run(port=8080, host='0.0.0.0')
