import telebot
from loguru import logger
import os
import time
from telebot.types import InputFile
import boto3
import requests
#****
from botocore.exceptions import NoCredentialsError
import uuid
#****
class Bot:

    def __init__(self, token, telegram_chat_url):
        # create a new instance of the TeleBot class.
        # all communication with Telegram servers are done using self.telegram_bot_client
        self.telegram_bot_client = telebot.TeleBot(token)

        # remove any existing webhooks configured in Telegram servers
        self.telegram_bot_client.remove_webhook()
        time.sleep(0.5)

        # set the webhook URL
        self.telegram_bot_client.set_webhook(url=f'{telegram_chat_url}/{token}/', timeout=60)

        logger.info(f'Telegram Bot information\n\n{self.telegram_bot_client.get_me()}')

    def send_text(self, chat_id, text):
        self.telegram_bot_client.send_message(chat_id, text)

    def send_text_with_quote(self, chat_id, text, quoted_msg_id):
        self.telegram_bot_client.send_message(chat_id, text, reply_to_message_id=quoted_msg_id)

    def is_current_msg_photo(self, msg):
        return 'photo' in msg

    def download_user_photo(self, msg):
        """
        Downloads the photos that sent to the Bot to `photos` directory (should be existed)
        :return:
        """
        if not self.is_current_msg_photo(msg):
            raise RuntimeError(f'Message content of type \'photo\' expected')

        file_info = self.telegram_bot_client.get_file(msg['photo'][-1]['file_id'])
        data = self.telegram_bot_client.download_file(file_info.file_path)
        folder_name = file_info.file_path.split('/')[0]

        if not os.path.exists(folder_name):
            os.makedirs(folder_name)

        with open(file_info.file_path, 'wb') as photo:
            photo.write(data)

        return file_info.file_path

    def send_photo(self, chat_id, img_path):
        if not os.path.exists(img_path):
            raise RuntimeError("Image path doesn't exist")

        self.telegram_bot_client.send_photo(
            chat_id,
            InputFile(img_path)
        )

    def handle_message(self, msg):
        """Bot Main message handler"""
        logger.info(f'Incoming message: {msg}')
        #self.send_text(msg['chat']['id'], f'Your original message: {msg["text"]}')
        if 'text' in msg:
            self.send_text(msg['chat']['id'], f'Your original message: {msg["text"]}')
        else:
            self.send_text(msg['chat']['id'], 'No text found in the message.')


class QuoteBot(Bot):
    def handle_message(self, msg):
        logger.info(f'Incoming message: {msg}')

        if msg["text"] != 'Please don\'t quote me':
            self.send_text_with_quote(msg['chat']['id'], msg["text"], quoted_msg_id=msg["message_id"])


class ObjectDetectionBot(Bot):
    def handle_message(self, msg,images_bucket):
        logger.info(f'Incoming message: {msg}')

        if self.is_current_msg_photo(msg):
            pass
            # TODO download the user photo (utilize download_user_photo)
            photo_path = self.download_user_photo(msg)

            # TODO upload the photo to S3
            image_id = self.upload_to_s3(photo_path,images_bucket)
            # TODO send a request to the `yolo5` service for prediction
            prediction_result = self.predict_with_flask(image_id)
            # TODO send results to the Telegram end-user
            self.send_text(msg['chat']['id'], f'Prediction Result: {prediction_result}')

    def upload_to_s3(self, local_path,images_bucket):
        s3 = boto3.client('s3')


        image_id = str(uuid.uuid4())
        image_id=f'{image_id}.jpeg'
        try:
            s3.upload_file(local_path, images_bucket,image_id)
            logger.info(f'Photo uploaded to S3. S3 URL: s3://{images_bucket}/{image_id}')
            return image_id
        except NoCredentialsError:
            logger.error("AWS credentials not available.")
            return None
        except Exception as e:
            logger.error(f"Error uploading photo to S3: {e}")
            return None


    def predict_with_flask(self, image_id):
        # Initialize prediction_result with a default value
        prediction_result = None
        # Define the base URL of your Flask applicationubu
        print("hereeee127.0.0.1")
        base_url = "http://127.0.0.1:8081"

        # Define the endpoint
        endpoint = "/predict"

        # Combine the base URL and endpoint
        url = base_url + endpoint

        # Set the image name as a URL parameter
        params = {'imgName': image_id}

        try:
            # Send a POST request to the /predict endpoint
            response = requests.post(url, params=params)

            # Check if the request was successful (status code 200)
            if response.status_code == 200:
                # Print the response JSON
                prediction_result=response.json()
            else:
                # Print an error message if the request was not successful
                print(f"Error: {response.status_code} - {response.text}")

        except requests.exceptions.RequestException as e:
            print(f"Error sending request: {e}")
        return prediction_result