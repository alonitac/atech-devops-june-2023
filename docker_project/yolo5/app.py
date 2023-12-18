import logging
import time
from pathlib import Path
from flask import Flask, request, jsonify
from detect import run
import uuid
import yaml
from loguru import logger
import os
import shutil
import requests
from pymongo import MongoClient

import boto3
from botocore.exceptions import NoCredentialsError

images_bucket = os.environ.get('BUCKET_NAME')

# Load COCO names from the YAML file
with open("data/coco128.yaml", "r") as stream:
    names = yaml.safe_load(stream)['names']

app = Flask(__name__)


@app.route('/predict', methods=['POST'])
def predict():
    # Generates a UUID for this current prediction HTTP request.
    prediction_id = str(uuid.uuid4())
    logger.info(f'prediction: {prediction_id}. start processing')

    # Receives a URL parameter representing the image to download from S3
    img_name = request.args.get('imgName')

    # Download img_name from S3, store the local image path in original_img_path
    # The bucket name should be provided as an env var BUCKET_NAME.
    s3 = boto3.client('s3')
    s3.download_file(images_bucket, img_name, img_name)

    logger.info(f'prediction: {img_name}. Download img completed')

    # Predicts the objects in the image
    run(
        weights='yolov5s.pt',
        data='data/coco128.yaml',
        source=img_name,
        project='static/data',
        name=prediction_id,
        save_txt=True
    )

    logger.info(f'prediction: {prediction_id}/{img_name}. done')

    # This is the path for the predicted image with labels
    predicted_img_path = Path(f'static/data/{prediction_id}/{img_name}')

    # Upload the predicted image to S3 without overriding the original image
    s3_predicted_path = f'{prediction_id}/{img_name}'
    upload_predicted_image_to_s3(predicted_img_path, s3_predicted_path)

    # Parse prediction labels and create a summary
    pred_summary_path = Path(f'static/data/{prediction_id}/labels/{img_name.split(".")[0]}.txt')
    if pred_summary_path.exists():
        with open(pred_summary_path) as f:
            labels = f.read().splitlines()
            labels = [line.split(' ') for line in labels]
            labels = [{
                'class': str(names[int(l[0])]),
                'cx': float(l[1]),
                'cy': float(l[2]),
                'width': float(l[3]),
                'height': float(l[4]),
            } for l in labels]

        logger.info(f'prediction: {prediction_id}/{img_name}. prediction summary:\n\n{labels}')

        prediction_summary = {
            'prediction_id': str(prediction_id),
            'original_img_path': str(img_name),
            'predicted_img_path': str(predicted_img_path),
            'labels': labels,
            'time': time.time()
        }

        # Store the prediction_summary in MongoDB
        store_prediction_in_mongodb(prediction_summary)
        prediction_summary['_id'] = str(prediction_summary['_id'])
        return prediction_summary
    else:
        return f'prediction: {prediction_id}/{img_name}. prediction result not found', 404


def upload_predicted_image_to_s3(local_path, s3_path):
    """
    Uploads the predicted image to S3 without overriding the original image.
    """
    s3 = boto3.client('s3')
    bucket_name = os.environ.get('BUCKET_NAME')

    try:
        s3.upload_file(local_path, bucket_name, s3_path)
    except NoCredentialsError:
        raise Exception('AWS credentials not available. Check your configuration.')
    except Exception as e:
        raise Exception(f'Failed to upload predicted image to S3: {str(e)}')


def store_prediction_in_mongodb(prediction_summary):
    """
    Stores the prediction summary in MongoDB.
    """
    from pymongo import MongoClient

    # Connect to a local MongoDB server without authentication
    client = MongoClient(os.environ.get('MONGODB_URI'))

    # Access your database
    db = client["mydb"]

    # Now you can work with your MongoDB database using 'db'
    new_collection_name = "my_collection"

    # Create a new collection
    collection = db[new_collection_name]
    logger.info(prediction_summary)

    collection.insert_one(prediction_summary)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8081)
