#!/bin/sh
# Read the auth key from auth_key.txt if it exists
AUTH_KEY_FILE="/mnt/us/extensions/tailscale/config/auth_key.txt"
LOGIN_SERVER_FILE="/mnt/us/extensions/tailscale/config/login_server.txt"

# Read auth key if available and not empty
if [ -f "$AUTH_KEY_FILE" ] && [ -s "$AUTH_KEY_FILE" ]; then
    AUTH_KEY=$(cat "$AUTH_KEY_FILE")
fi

# Read login server if specified and not empty
if [ -f "$LOGIN_SERVER_FILE" ] && [ -s "$LOGIN_SERVER_FILE" ]; then
    LOGIN_SERVER=$(cat "$LOGIN_SERVER_FILE")
fi

# Execute the command with proper argument passing
if [ -n "$AUTH_KEY" ] && [ -n "$LOGIN_SERVER" ]; then
    /mnt/us/extensions/tailscale/bin/tailscale up --auth-key="$AUTH_KEY" --login-server="$LOGIN_SERVER" > tailscale_start_log.txt 2>&1
elif [ -n "$AUTH_KEY" ]; then
    /mnt/us/extensions/tailscale/bin/tailscale up --auth-key="$AUTH_KEY" > tailscale_start_log.txt 2>&1
elif [ -n "$LOGIN_SERVER" ]; then
    /mnt/us/extensions/tailscale/bin/tailscale up --login-server="$LOGIN_SERVER" > tailscale_start_log.txt 2>&1
else
    /mnt/us/extensions/tailscale/bin/tailscale up > tailscale_start_log.txt 2>&1
fi

kh_msg "$(cat tailscale_start_log.txt)"
