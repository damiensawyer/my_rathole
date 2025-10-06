#!/bin/bash

# Trap SIGTERM and SIGINT to kill child processes
trap 'kill $(jobs -p) 2>/dev/null; exit' SIGTERM SIGINT

# Run rathole server in the background
./rathole server.toml &
RATHOLE_PID=$!

# Run Caddy in the background
caddy run --config Caddyfile --adapter caddyfile &
CADDY_PID=$!

# Wait for both processes
wait
