import telebot
from loguru import logger
import os
from pathlib import Path
import time
from telebot.types import InputFile
import boto3
import requests

BUCKET_NAME="abzahbucket"
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
        logger.info(f"the local path is {file_info.file_path}")
        return str(file_info.file_path)

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
        self.send_text(msg['chat']['id'], f'Your original message: {msg["text"]}')


class QuoteBot(Bot):
    def handle_message(self, msg):
        logger.info(f'Incoming message: {msg}')

        if msg["text"] != 'Please don\'t quote me':
            self.send_text_with_quote(msg['chat']['id'], msg["text"], quoted_msg_id=msg["message_id"])


class ObjectDetectionBot(Bot):
    import boto3

            # TODO download the user photo (utilize download_user_photo)
            # TODO upload the photo to S3
            # TODO send a request to the `yolo5` service for prediction
            # TODO send results to the Telegram end-user

    def handle_message(self, msg):
        logger.info(f'Incoming message: {msg}')

        if self.is_current_msg_photo(msg):
            try:
                local_path = self.download_user_photo(msg)
                s3_path = f'images/{os.path.basename(local_path)}'
                self.upload_to_s3(local_path, s3_path)
                logger.info(f'@@@@@@@@@@@')
                results = self.predict_objects(s3_path)
                self.send_text(msg['chat']['id'], f'Object detection results: {results}')

            except Exception as e:
                logger.error(f'Error processing photo: {str(e)}')
                self.send_text(msg['chat']['id'], f'Error processing photo: {str(e)}')
        else:
            self.send_text(msg['chat']['id'], 'Please send a photo for object detection.')

    def upload_to_s3(self, local_path, s3_path):
        """
        Uploads the predicted image to S3 without overriding the original image.
        """
        s3 = boto3.client('s3')
       ##### bucket_name = os.environ.get('BUCKET_NAME')

        try:
            logger.info(f'\n local_path ,,,,,,,,,{local_path}\n')
            logger.info(f'uploading {local_path} to   ,,,,,,,,,{BUCKET_NAME}/{s3_path}')
            s3.upload_file(Path(local_path), BUCKET_NAME, s3_path)
            #except NoCredentialsError:
            #raise Exception('AWS credentials not available. Check your configuration.')
        except Exception as e:
            raise Exception(f'Failed to upload predicted image to S3: {str(e)}')


    def predict_objects(self, img_url):
        try:
            logger.info(f'\nimg_url = {img_url}\n')
            response = requests.post(f"http://172.18.0.5:8081/predict?imgName={img_url}")
            if response.status_code == 200:
                return response.json()
            else:
                logger.error(f"Prediction request failed: {response.text}")
                return None
        except requests.exceptions.RequestException as e:
            logger.error(f"Request error: {e}")
            return None
