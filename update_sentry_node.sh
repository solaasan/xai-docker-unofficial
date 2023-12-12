#!/bin/bash

# Set environment variables
export FILE_NAME=sentry-node-cli-linux.zip

# Get latest_version and file_url
source check_updates.sh

# Download and extract
cd $HOME
curl -L --remote-name $file_url
unzip $FILE_NAME
rm -f $FILE_NAME
chmod +x $EXTRACTED_DIR
