#!/bin/bash

# Read the webhook URL from the environment variable
WEBHOOK_URL="${NOTIFICATION_WEBHOOK_OPTIONAL:-}"

# Check if the webhook URL is empty
if [ -z "$WEBHOOK_URL" ]; then
  echo "sentry-node-cli has failed too quickly, too many times..."
  exit
fi

echo $WEBHOOK_URL
# If the webhook URL is set, make the POST request
curl -X POST -H "Content-Type: application/json" --data '{"content": "sentry-node-cli has failed too quickly, too many times."}' $WEBHOOK_URL
