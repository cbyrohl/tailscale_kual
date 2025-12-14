#!/bin/sh
# Read the auth key from auth_key.txt if it exists
AUTH_KEY_FILE="/mnt/us/extensions/tailscale/config/auth_key.txt"
LOGIN_SERVER_FILE="/mnt/us/extensions/tailscale/config/login_server.txt"

# Build the tailscale up command
CMD="/mnt/us/extensions/tailscale/bin/tailscale up"

# Add auth key if available and not empty
if [ -f "$AUTH_KEY_FILE" ] && [ -s "$AUTH_KEY_FILE" ]; then
    AUTH_KEY=$(cat "$AUTH_KEY_FILE")
    CMD="$CMD --auth-key=\"$AUTH_KEY\""
fi

# Add login server if specified and not empty
if [ -f "$LOGIN_SERVER_FILE" ] && [ -s "$LOGIN_SERVER_FILE" ]; then
    LOGIN_SERVER=$(cat "$LOGIN_SERVER_FILE")
    CMD="$CMD --login-server=\"$LOGIN_SERVER\""
fi

# Execute the command
eval $CMD > tailscale_start_log.txt 2>&1

kh_msg "$(cat tailscale_start_log.txt)"
