# Use an official Python runtime as a parent image
FROM python:3.8-slim

WORKDIR /usr/src/app
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
# Install ngrok
RUN apt-get update && apt-get install -y wget unzip curl jq dos2unix
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin
RUN pip install boto3
# Copy entrypoint.sh into the container
COPY entrypoint.sh .
# Convert entrypoint.sh to Unix line endings
RUN dos2unix entrypoint.sh

RUN chmod +x entrypoint.sh

# Make port 8443 available to the world outside this container
EXPOSE 8443

# Start ngrok and your Flask app using an entrypoint script
CMD ["./entrypoint.sh"]
