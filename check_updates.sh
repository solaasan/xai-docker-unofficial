#!/bin/bash

# Set environment variables
export FILE_NAME=sentry-node-cli-linux.zip
export VERSION_FILE=$(pwd)/current_version.txt


# Get latest release info
release_info=$(curl --silent "https://api.github.com/repos/xai-foundation/sentry/releases/latest")

# Extract the tag_name and browser_download_url for sentry-node-cli-linux.zip
latest_version=$(echo $release_info | jq -r .tag_name | sed 's/v//')
file_url=$(echo $release_info | jq -r '.assets[] | select(.name=="sentry-node-cli-linux.zip") | .browser_download_url')
echo $latest_version

current_version=$(cat $VERSION_FILE | tr -d '[:space:]')
latest_version=$(echo $latest_version | tr -d '[:space:]')

echo "Current version: $current_version"

if [ ! -f "$VERSION_FILE" ]; then
    echo Initial ver download
    cd $HOME
    curl -L --remote-name $file_url
    rm -f sentry-node-cli-linux
    unzip -o $FILE_NAME
    rm -f $FILE_NAME
    chmod +x sentry-node-cli-linux
    export current_version="$latest_version"
    echo "$current_version" > $VERSION_FILE
else
  # Update if necessary
  if [ "$current_version" != "$latest_version" ]; then

    echo "New release found. Updating..."
    
    cd $HOME
    curl -L --remote-name $file_url
    rm -f sentry-node-cli-linux
    unzip -o $FILE_NAME
    rm -f $FILE_NAME
    chmod +x sentry-node-cli-linux
    export current_version="$latest_version"
    echo "$current_version" > $VERSION_FILE

    # Read the webhook URL from the environment variable
    WEBHOOK_URL="${NOTIFICATION_WEBHOOK_OPTIONAL:-}"

    # Check if the webhook URL is empty
    if [ -z "$WEBHOOK_URL" ]; then
      echo "Node updated to $latest_version. Restarting the process..."
    else
      # If the webhook URL is set, make the POST request
      curl -X POST -H "Content-Type: application/json" --data '{"content": "sentry-node-cli updated."}' $WEBHOOK_URL
    fi



    supervisorctl restart sentry-node-cli
    
  else
    echo "No new release found."
  fi
fi

