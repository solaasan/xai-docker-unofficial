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



# Send the PK from the environment variable
send $op_key
send "\r"

# Wait for the question about the whitelist for the operator runtime
expect {
   -nocase "? Do you want to use a whitelist for the operator runtime? (y/N)" {
      send "n\r"
   }
   timeout {
      send "exit\r"
      after 2000
      exec /bin/bash -c "/home/sentry/check_update.sh"
   }
}


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
