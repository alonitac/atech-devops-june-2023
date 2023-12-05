import time
from pathlib import Path
from flask import Flask, request, jsonify
from detect import run
import uuid
import yaml
from loguru import logger
import os
# **********
import boto3
from botocore.exceptions import NoCredentialsError
from pymongo import MongoClient
import json

# **********
images_bucket = os.environ['BUCKET_NAME']
with open("data/coco128.yaml", "r") as stream:
    names = yaml.safe_load(stream)['names']

app = Flask(__name__)


@app.route('/', methods=['POST'])
def hello_world():
    return jsonify({'message': 'Hello, World!'})

# processing
@app.route('/predict', methods=['POST'])
def predict():
    print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii")
    print(images_bucket)

    # Generates a UUID for this current prediction HTTP request. This id can be used as a reference in logs to identify and track individual prediction requests.
    prediction_id = str(uuid.uuid4())

    logger.info(f'prediction: {prediction_id}. start processing')

    # Receives a URL parameter representing the image to download from S3
    img_name = request.args.get('imgName')
    logger.info(f'**************8{img_name}**************')
    # TODO download img_name from S3, store the local image path in original_img_path
    # ****************
    s3 = boto3.client('s3')

    print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii")
    nested_directory_path = f'data/images'

    # Expand the '~' to the user's home directory
    nested_directory_path = os.path.expanduser(nested_directory_path)

    # Create the nested directory if it doesn't exist
    if not os.path.exists(nested_directory_path):
        os.makedirs(nested_directory_path)
    local_img_path = f'{nested_directory_path}/{img_name}'
    print("****************" + local_img_path + "***************")
    try:
        s3.download_file(images_bucket, img_name, local_img_path)
        logger.info(f'prediction: {prediction_id}/{local_img_path}. Download img completed')
    except NoCredentialsError:
        logger.error("AWS credentials not available.")
        return "Error: AWS credentials not available.", 500
    except Exception as e:
        logger.error(f"Error downloading image: {e}")
        return f"Error downloading image: {e}", 500
    # ****************
    #  The bucket name should be provided as an env var BUCKET_NAME.
    #original_img_path = ...
    original_img_path =local_img_path
    logger.info(f'prediction: {prediction_id}/{original_img_path}. Download img completed')

    # Predicts the objects in the image
    run(
        weights='yolov5s.pt',
        data='data/coco128.yaml',
        source=original_img_path,  # *************
        project='static/data',
        name=prediction_id,
        save_txt=True
    )

    logger.info(f'prediction: {prediction_id}/{original_img_path}. done')

    # This is the path for the predicted image with labels
    # The predicted image typically includes bounding boxes drawn around the detected objects, along with class labels and possibly confidence scores.
    #^^^^^^^^^^^^^^^^^^^^
    nested_directory_path = f'static/data/{prediction_id}'

    # Expand the '~' to the user's home directory
    nested_directory_path = os.path.expanduser(nested_directory_path)

    # Create the nested directory if it doesn't exist
    if not os.path.exists(nested_directory_path):
        os.makedirs(nested_directory_path)
    predicted_img_path = f'{nested_directory_path}/{img_name}'
    #^^^^^^^^^^^^^^^^^^^^
    #predicted_img_path = Path(f'static/data/{prediction_id}/{img_name}')

    # TODO Uploads the predicted image (predicted_img_path) to S3 (be careful not to override the original image).
    # *************
    try:
        s3.upload_file(predicted_img_path, images_bucket, f'predictions/{prediction_id}/{img_name}')
        logger.info(f'prediction: {prediction_id}/{local_img_path}. Predicted img uploaded to S3.')
    except Exception as e:
        logger.error(f"Error uploading predicted image to S3: {e}")

    # *************
    # Parse prediction labels and create a summary
    pred_summary_path = Path(f'static/data/{prediction_id}/labels/{img_name.split(".")[0]}.txt')
    if pred_summary_path.exists():
        with open(pred_summary_path) as f:
            labels = f.read().splitlines()
            labels = [line.split(' ') for line in labels]
            labels = [{
                'class': names[int(l[0])],
                'cx': float(l[1]),
                'cy': float(l[2]),
                'width': float(l[3]),
                'height': float(l[4]),
            } for l in labels]

        logger.info(f'prediction: {prediction_id}/{original_img_path}. prediction summary:\n\n{labels}')

        prediction_summary = {
            'prediction_id': prediction_id,
            'original_img_path': original_img_path,
            'predicted_img_path': predicted_img_path,
            'labels': labels,
            'time': time.time()
        }

        # TODO store the prediction_summary in MongoDB
        # ***********

        try:
            client = MongoClient("mongo1", 27017)
            predictions_db = client.predictions
            predictions_collection = predictions_db.predictions_collection
            predictions_collection.insert_one(prediction_summary)

            logger.info(f'prediction: {prediction_id}/{local_img_path}. Prediction summary stored in MongoDB.')
            print("hellllllooooooooooooooooooooooo:)))))")
        except Exception as e:
            logger.error(f"Error storing prediction summary in MongoDB: {e}")

        # ***********
        prediction_summary = {
            'prediction_id': prediction_id,
            'original_img_path': original_img_path,
            'predicted_img_path': predicted_img_path,
            'labels': labels,
            'time': time.time()
        }
        return prediction_summary
    else:
        return f'prediction: {prediction_id}/{original_img_path}. prediction result not found', 404


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8081)
