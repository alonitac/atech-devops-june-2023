from urllib.parse import quote
from flask import Flask, render_template, request, jsonify
from loguru import logger
import requests


app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/submit', methods=['POST'])
def submit_youtube_url():
    youtube_url = request.form.get('youtube_url')
    response = requests.get(f'http://localhost:8081?youtube_url={quote(youtube_url)}', timeout=120)
    return jsonify(status=200, response=response.text)




if __name__ == '__main__':
    app.run(port=8080, host='0.0.0.0')
