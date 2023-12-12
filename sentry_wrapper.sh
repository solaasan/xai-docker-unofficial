#!/usr/bin/expect

set timeout -1

# Add any necessary environment variables

# Read the API key from the environment variable
set op_key $env(OPERATOR_KEY_VARIABLE)

# Launch the sentry-node-cli
spawn -noecho /bin/bash -i -c "/home/sentry/sentry-node-cli-linux"

# Wait for any text output indicating the tool is ready for input
expect -re .+

# Interact with the sentry node tool by sending commands
send "boot-operator\r"
expect -re .+

# Send the API key from the environment variable
send $op_key
send "\r"

expect {
   -nocase "error" {
      send "exit\r"
      after 2000
      exec /bin/bash -c "/home/sentry/check_update.sh"
   } timeout {
      # Continue to interact if "error" was not found
      interact
   }
}
