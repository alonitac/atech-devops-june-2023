import flask
from flask import request
import os
from bot import ObjectDetectionBot, Bot ,QuoteBot

app = flask.Flask(__name__)

TELEGRAM_TOKEN = os.environ['TELEGRAM_TOKEN']
TELEGRAM_APP_URL = os.environ['TELEGRAM_APP_URL']
images_bucket = os.environ['BUCKET_NAME']

@app.route('/', methods=['GET'])
def index():
    return 'Ok'


@app.route(f'/{TELEGRAM_TOKEN}/', methods=['POST'])
def webhook():
    req = request.get_json()
    bot.handle_message(req['message'],images_bucket)
    #bot.handle_message(req['message'])
    return 'Ok'


if __name__ == "__main__":
    #bot = Bot(TELEGRAM_TOKEN, TELEGRAM_APP_URL)
    #bot = QuoteBot(TELEGRAM_TOKEN, TELEGRAM_APP_URL)
    bot = ObjectDetectionBot(TELEGRAM_TOKEN, TELEGRAM_APP_URL)
    app.run(host='0.0.0.0', port=8443)
